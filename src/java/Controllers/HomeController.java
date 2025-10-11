package Controllers;

import dao.AuthorDAO;
import dao.BookDAO;
import dao.CategoryDAO;
import dao.PublisherDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
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

            request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
