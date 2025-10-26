package Controllers;

import DAO.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Book;
import model.CartItem;
import model.CartItemDTO;
import java.util.ArrayList; // Thêm import

public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String action = request.getParameter("action");

        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        if ("delete".equals(action)) {
            try {
                int cartItemId = Integer.parseInt(request.getParameter("itemId"));
                cartDAO.deleteItemFromCart(cartItemId);
                response.sendRedirect("cart?delete=success");
                return; // Stop further processing
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("cart?delete=error");
                return;
            }
        }
        List<CartItemDTO> cartItems = cartDAO.getCartItemsByAccountId(account.getU_id());

        double subTotal = 0;
        for (CartItemDTO item : cartItems) {
            subTotal += item.getTotal();
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subTotal", subTotal);
        request.getRequestDispatcher("customer/cart.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String action = request.getParameter("action");

        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        CartDAO cartDAO = new CartDAO();

        if ("update".equals(action)) {
            // Cập nhật số lượng cho TẤT CẢ các mục trong giỏ hàng
            List<CartItemDTO> cartItems = cartDAO.getCartItemsByAccountId(account.getU_id());
            try {
                for (CartItemDTO item : cartItems) {
                    // Lấy số lượng mới từ form, dựa theo name="quantity_..."
                    String paramName = "quantity_" + item.getCartItemId();
                    int newQuantity = Integer.parseInt(request.getParameter(paramName));
                    
                    // Gọi DAO để cập nhật
                    cartDAO.updateCartItemQuantity(item.getCartItemId(), newQuantity);
                }
                response.sendRedirect("cart?update=success");
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("cart?update=error");
            }
            
        } else if ("checkout".equals(action)) {
            // Xử lý thanh toán cho các mục ĐÃ CHỌN
            String[] selectedItemIds = request.getParameterValues("selectedItems");

            if (selectedItemIds == null || selectedItemIds.length == 0) {
                // Không có mục nào được chọn, quay lại giỏ hàng với thông báo
                response.sendRedirect("cart?error=noselection");
                return;
            }

            // Lưu danh sách ID các mục đã chọn vào session để trang checkout xử lý
            // Chuyển String[] thành List<Integer> để dễ xử lý hơn
            List<Integer> selectedItemsList = new ArrayList<>();
            for (String idStr : selectedItemIds) {
                try {
                    selectedItemsList.add(Integer.parseInt(idStr));
                } catch (NumberFormatException e) {
                    e.printStackTrace(); // Bỏ qua ID không hợp lệ
                }
            }

            // Lưu vào session
            session.setAttribute("selectedCheckoutItems", selectedItemsList);
            
            // Cập nhật số lượng của các mục đã chọn (phòng trường hợp user thay đổi số lượng nhưng chưa bấm update)
             try {
                for (int itemId : selectedItemsList) {
                    String paramName = "quantity_" + itemId;
                    int newQuantity = Integer.parseInt(request.getParameter(paramName));
                    cartDAO.updateCartItemQuantity(itemId, newQuantity);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("cart?update=error");
                return;
            }

            // Chuyển hướng đến servlet/trang checkout
            // (Giả sử bạn có một servlet "checkout")
            response.sendRedirect("checkout"); 
        } else {
            // Hành động không xác định, quay lại giTỏ hàng
            response.sendRedirect("cart");
        }
    }

}