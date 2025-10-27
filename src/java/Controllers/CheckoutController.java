package Controllers;

import DAO.CartDAO;
import model.Account;
import model.CartItemDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        // 1. Kiểm tra đăng nhập
        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        // 2. Lấy danh sách ID mục đã chọn từ session
        @SuppressWarnings("unchecked") // Bỏ cảnh báo cast
        List<Integer> selectedItemIds = (List<Integer>) session.getAttribute("selectedCheckoutItems");

        // 3. Kiểm tra xem có mục nào được chọn không
        if (selectedItemIds == null || selectedItemIds.isEmpty()) {
            // Nếu không có gì trong session, quay lại giỏ hàng
            response.sendRedirect("cart?error=noselection");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        
        // 4. Lấy chi tiết các mục đã chọn từ CSDL
        // (Chúng ta sẽ thêm phương thức getCartItemsByIds vào CartDAO)
        List<CartItemDTO> checkoutItems = cartDAO.getCartItemsByIds(selectedItemIds);

        // 5. Tính toán tổng tiền
        double subTotal = 0;
        for (CartItemDTO item : checkoutItems) {
            // Đảm bảo tổng của mỗi mục đã được tính
            // (Phương thức DAO của chúng ta sẽ làm điều này)
            subTotal += item.getTotal();
        }
        
        double shippingFee = 0; // Tạm thời miễn phí vận chuyển
        double grandTotal = subTotal + shippingFee;

        // 6. Đặt thuộc tính cho trang JSP
        request.setAttribute("checkoutItems", checkoutItems);
        request.setAttribute("checkoutSubTotal", subTotal);
        request.setAttribute("checkoutShippingFee", shippingFee);
        request.setAttribute("checkoutGrandTotal", grandTotal);

        // 7. Chuyển tiếp đến trang checkout.jsp
        // (Giả sử file của bạn nằm ở customer/checkout.jsp)
        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Phương thức POST sẽ xử lý khi người dùng nhấn "Place Order"
        // Tạm thời, chúng ta sẽ để trống hoặc gọi doGet
        // ... (Logic đặt hàng sẽ ở đây)
        String action = request.getParameter("action");
        if("placeOrder".equals(action)){
            // Xử lý logic đặt hàng
            // ...
        } else {
             doGet(request, response);
        }
       
    }
}