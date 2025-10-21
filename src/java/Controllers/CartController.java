
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

public class CartController extends HttpServlet {
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    HttpSession session = request.getSession();
    Account account = (Account) session.getAttribute("account");

    if (account == null) {
        // Nếu chưa đăng nhập, chuyển về trang đăng nhập
        response.sendRedirect("login-register"); // Hoặc URL trang login của bạn
        return;
    }

    // Nếu đã đăng nhập, lấy các sản phẩm trong giỏ hàng
    CartDAO cartDAO = new CartDAO();
    List<CartItemDTO> cartItems = cartDAO.getCartItemsByAccountId(account.getU_id());
    
    // Tính tổng tiền
    double subTotal = 0;
    for (CartItemDTO item : cartItems) {
        subTotal += item.getTotal();
    }

    // Gửi danh sách sản phẩm và tổng tiền sang trang JSP
    request.setAttribute("cartItems", cartItems);
    request.setAttribute("subTotal", subTotal);
    
    request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
}
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }

}
