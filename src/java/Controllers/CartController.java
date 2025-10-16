
package Controllers;

import DAO.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import model.Account;
import model.Book;
import model.CartItem;

public class CartController extends HttpServlet {
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
    Account account = (Account) session.getAttribute("account");

    if (account == null) {
        response.sendRedirect("login-register");
        return;
    }

    CartDAO cartDAO = new CartDAO();
    // Lấy dữ liệu dưới dạng Map
    Map<CartItem, Book> cartMap = cartDAO.getCartItemsByAccountId(account.getU_id());

    // Tính tổng tiền
    double subTotal = 0;
    for (Map.Entry<CartItem, Book> entry : cartMap.entrySet()) {
        CartItem item = entry.getKey();
        Book book = entry.getValue();
        subTotal += item.getQuantity() * book.getPrice();
    }

    // Gửi Map và tổng tiền sang JSP
    request.setAttribute("cartMap", cartMap);
    request.setAttribute("subTotal", subTotal);

    request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
}
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }

}
