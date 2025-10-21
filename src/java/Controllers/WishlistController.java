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
import model.Book;

@WebServlet(name = "WishlistController", urlPatterns = {"/wishlist"})
public class WishlistController extends HttpServlet {

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

        WishlistDAO wishlistDAO = new WishlistDAO();

        if ("add".equals(action)) {
            // Xử lý thêm vào wishlist
            try {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                wishlistDAO.addToWishlist(account.getU_id(), bookId);
                
                String page = request.getParameter("page");
                page = (page == null || page.isEmpty()) ? "1" : page;
                
                // Chuyển hướng về trang chủ với thông báo
                response.sendRedirect("home?page=" + page + "&wishlist_add=success");
                
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        } else {
            // Hiển thị trang wishlist
            List<Book> wishlistItems = wishlistDAO.getWishlistItems(account.getU_id());
            request.setAttribute("wishlistItems", wishlistItems);
            request.getRequestDispatcher("customer/wishlist.jsp").forward(request, response);
        }
    }
}