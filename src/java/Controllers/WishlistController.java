package Controllers;

import DAO.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Book; // Ensure Book model is imported

@WebServlet(name = "WishlistController", urlPatterns = {"/wishlist"})
public class WishlistController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String action = request.getParameter("action");

        // 1. Check Login
        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        WishlistDAO wishlistDAO = new WishlistDAO();
        int userId = account.getU_id();

        // 2. Process Action
        if ("add".equals(action)) {
            try {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                wishlistDAO.addToWishlist(userId, bookId);

                String referer = request.getHeader("Referer");
                String redirectUrl = (referer != null && !referer.isEmpty()) ? referer : "home";

                if (redirectUrl.contains("?")) {
                    redirectUrl += "&wishlist_add=success";
                } else {
                    redirectUrl += "?wishlist_add=success";
                }
                response.sendRedirect(redirectUrl);
                return;

            } catch (NumberFormatException e) {
                response.sendRedirect("home"); // Redirect home on invalid bookId
                return;
            } catch (Exception e) { // Catch potential exceptions from DAO (like wishlist not found)
                e.printStackTrace(); // Log the error
                // Redirect back with an error message
                String referer = request.getHeader("Referer");
                String redirectUrl = (referer != null && !referer.isEmpty()) ? referer : "home";
                if (redirectUrl.contains("?")) {
                    redirectUrl += "&wishlist_add=error";
                } else {
                    redirectUrl += "?wishlist_add=error";
                }
                response.sendRedirect(redirectUrl);
                return;
            }
        } else if ("remove".equals(action)) {
            try {
                int wishlistItemId = Integer.parseInt(request.getParameter("itemId")); // This ID is from wishlist_items table
                wishlistDAO.removeFromWishlist(wishlistItemId);
                response.sendRedirect("wishlist?remove=success"); // Redirect back to wishlist page
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect("wishlist?error=invalid_item");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("wishlist?error=remove_failed");
                return;
            }
        } else {
            // Default: Display Wishlist Page
            List<Book> wishlistItems = wishlistDAO.getWishlistItems(userId);
            request.setAttribute("wishlistItems", wishlistItems);
            // Ensure the path to your JSP is correct
            request.getRequestDispatcher("/customer/wishlist.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // Forward POST requests to doGet
    }
}
