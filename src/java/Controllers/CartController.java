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
import java.util.ArrayList;

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
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("cart?delete=error");
                return;
            }
        } else if ("checkoutAll".equals(action)) {
            // Lấy tất cả items trong giỏ hàng và chuyển sang checkout
            List<CartItemDTO> cartItems = cartDAO.getCartItemsByAccountId(account.getU_id());
            if (cartItems == null || cartItems.isEmpty()) {
                response.sendRedirect("cart?error=emptycart");
                return;
            }
            
            // Lấy tất cả cart item IDs
            List<Integer> allItemIds = new ArrayList<>();
            for (CartItemDTO item : cartItems) {
                allItemIds.add(item.getCartItemId());
            }
            
            // Set vào session và redirect đến checkout
            session.setAttribute("selectedCheckoutItems", allItemIds);
            response.sendRedirect("checkout");
            return;
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

            List<CartItemDTO> cartItems = cartDAO.getCartItemsByAccountId(account.getU_id());
            try {
                for (CartItemDTO item : cartItems) {

                    String paramName = "quantity_" + item.getCartItemId();
                    int newQuantity = Integer.parseInt(request.getParameter(paramName));

                    cartDAO.updateCartItemQuantity(item.getCartItemId(), newQuantity);
                }
                response.sendRedirect("cart?update=success");
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("cart?update=error");
            }

        } else if ("checkout".equals(action)) {

            String[] selectedItemIds = request.getParameterValues("selectedItems");

            if (selectedItemIds == null || selectedItemIds.length == 0) {

                response.sendRedirect("cart?error=noselection");
                return;
            }

            List<Integer> selectedItemsList = new ArrayList<>();
            for (String idStr : selectedItemIds) {
                try {
                    selectedItemsList.add(Integer.parseInt(idStr));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            session.setAttribute("selectedCheckoutItems", selectedItemsList);

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

            response.sendRedirect("checkout");
        } else {
            response.sendRedirect("cart");
        }
    }

}
