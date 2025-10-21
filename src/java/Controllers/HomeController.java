package Controllers;

import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CartDAO;
import DAO.CategoryDAO;
import DAO.PublisherDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Author;
import model.Book;
import model.Category;
import model.Publisher;

public class HomeController extends HttpServlet {

    private static final int BOOKS_PER_PAGE = 9;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String state = request.getParameter("state");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        CategoryDAO categoryDAO = new CategoryDAO();
        AuthorDAO authorDAO = new AuthorDAO();
        PublisherDAO publisherDAO = new PublisherDAO();

        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Author> authorList = authorDAO.getAllAuthors();
        List<Publisher> publisherList = publisherDAO.getAllPublishers();

        request.setAttribute("categoryList", categoryList);
        request.setAttribute("authorList", authorList);
        request.setAttribute("publisherList", publisherList);

        BookDAO bookDAO = new BookDAO();

        if (state == null) {
            String pageStr = request.getParameter("page");
            int currentPage = (pageStr == null) ? 1 : Integer.parseInt(pageStr);

            int totalBooks = bookDAO.getTotalBooks();
            int totalPages = (int) Math.ceil((double) totalBooks / BOOKS_PER_PAGE);

            List<Book> bookList = bookDAO.getBooksByPage(currentPage, BOOKS_PER_PAGE);

            request.setAttribute("bookList", bookList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

            request.getRequestDispatcher("/customer/home.jsp").forward(request, response);

        } else if ("detail".equals(state)) {
            String bookIdStr = request.getParameter("bookId");
            try {
                int bookId = Integer.parseInt(bookIdStr);
                Book book = bookDAO.getBookById(bookId);
                request.setAttribute("bookDetail", book);
                request.getRequestDispatcher("/customer/book_detail.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }

        } else if ("cart".equals(state)) {
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login-register");
                return;
            }
            if ("add".equals(action)) {

                try {
                    int bookId = Integer.parseInt(request.getParameter("bookId"));
                    int accountId = account.getU_id();

                    CartDAO cartDAO = new CartDAO();
                    cartDAO.addToCart(accountId, bookId, 1);

                    String currentPage = request.getParameter("page");
                    currentPage = (currentPage == null || currentPage.isEmpty()) ? "1" : currentPage;
                    response.sendRedirect("home?page=" + currentPage + "&add=success");
                    return; // Dừng lại sau khi xử lý xong
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("home");
                    return;
                }
            } else {
                request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
            }
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
