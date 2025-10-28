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

        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        @SuppressWarnings("unchecked")
        List<Integer> selectedItemIds = (List<Integer>) session.getAttribute("selectedCheckoutItems");

        if (selectedItemIds == null || selectedItemIds.isEmpty()) {
            response.sendRedirect("cart?error=noselection");
            return;
        }

        CartDAO cartDAO = new CartDAO();

        List<CartItemDTO> checkoutItems = cartDAO.getCartItemsByIds(selectedItemIds);

        double subTotal = 0;
        for (CartItemDTO item : checkoutItems) {

            subTotal += item.getTotal();
        }

        double shippingFee = 0;
        double grandTotal = subTotal + shippingFee;

        request.setAttribute("checkoutItems", checkoutItems);
        request.setAttribute("checkoutSubTotal", subTotal);
        request.setAttribute("checkoutShippingFee", shippingFee);
        request.setAttribute("checkoutGrandTotal", grandTotal);

        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("placeOrder".equals(action)) {
         
        } else {
            doGet(request, response);
        }

    }
}
