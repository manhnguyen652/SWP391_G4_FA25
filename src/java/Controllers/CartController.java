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

    }

}
