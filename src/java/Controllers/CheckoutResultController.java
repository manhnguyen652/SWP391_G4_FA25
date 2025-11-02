package Controllers;

import DAO.CartDAO;
import DAO.OrderDAO;
import com.vnpay.common.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Order; // Import model Order
import model.OrderDetailDTO; // Import DTO mới

@WebServlet(name = "CheckoutResultController", urlPatterns = {"/checkout-result"})
public class CheckoutResultController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        
        Map<String, String> fieldsForHash = new HashMap<>();
         for (Map.Entry<String, String> entry : fields.entrySet()) {
             fieldsForHash.put(
                     URLEncoder.encode(entry.getKey(), StandardCharsets.US_ASCII.toString()),
                     URLEncoder.encode(entry.getValue(), StandardCharsets.US_ASCII.toString())
             );
         }
        
        String signValue = Config.hashAllFields(fieldsForHash); 
        
        if (signValue.equals(vnp_SecureHash)) {
            String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
            String vnp_TxnRef = request.getParameter("vnp_TxnRef");
            
            OrderDAO orderDAO = new OrderDAO();
            int orderId = -1;
            try {
                 orderId = Integer.parseInt(vnp_TxnRef);
            } catch (NumberFormatException e) {
                 e.printStackTrace();
            }

            if ("00".equals(vnp_ResponseCode)) {
                // --- THAY ĐỔI TỪ ĐÂY ---
                System.out.println("Payment success for order: " + orderId);
                orderDAO.updateOrderStatus(orderId, 2); // 2 = Đã thanh toán
                
                // Xóa items khỏi giỏ hàng sau khi thanh toán thành công
                HttpSession session = request.getSession();
                @SuppressWarnings("unchecked")
                List<Integer> selectedItemIds = (List<Integer>) session.getAttribute("selectedCheckoutItems");
                
                if (selectedItemIds != null && !selectedItemIds.isEmpty()) {
                    CartDAO cartDAO = new CartDAO();
                    cartDAO.removeItemsFromCart(selectedItemIds);
                    session.removeAttribute("selectedCheckoutItems");
                    System.out.println("Removed " + selectedItemIds.size() + " items from cart after successful payment");
                }
                
                // Lấy thông tin chi tiết đơn hàng
                Order orderInfo = orderDAO.getOrderById(orderId);
                List<OrderDetailDTO> orderItems = orderDAO.getOrderDetailsDTO(orderId);
                
                // Gửi thông tin sang JSP
                request.setAttribute("orderInfo", orderInfo);
                request.setAttribute("orderItems", orderItems);
                
                // Chuyển sang trang order-complete.jsp
                request.getRequestDispatcher("customer/order_complete.jsp").forward(request, response);
                // --- KẾT THÚC THAY ĐỔI ---
            } else {
                System.out.println("Payment failed for order: " + orderId + " with code: " + vnp_ResponseCode);
                orderDAO.updateOrderStatus(orderId, 3); // 3 = Thanh toán thất bại
                request.setAttribute("message", "Thanh toán thất bại cho đơn hàng: " + orderId);
                request.getRequestDispatcher("customer/order_failure.jsp").forward(request, response);
            }
        } else {
            System.err.println("VNPAY SecureHash mismatch!");
            request.setAttribute("message", "Lỗi xác thực chữ ký VNPAY!");
            request.getRequestDispatcher("customer/order_failure.jsp").forward(request, response);
        }
    }
}