package Controllers;

import DAO.CartDAO;
import model.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateCartQuantityServlet", urlPatterns = {"/update-cart-quantity"})
public class UpdateCartQuantityServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("account") == null) {
            // Người dùng chưa đăng nhập
            out.print("{\"success\": false, \"message\": \"Not logged in\"}");
            out.flush();
            return;
        }

        try {

            int cartItemId = Integer.parseInt(request.getParameter("itemId"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            CartDAO cartDAO = new CartDAO();
            cartDAO.updateCartItemQuantity(cartItemId, newQuantity);
            out.print("{\"success\": true}");

        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Invalid input\"}");
            e.printStackTrace();
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cart");
    }
}
