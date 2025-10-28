package Controllers;

import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CategoryDAO;
import DAO.PublisherDAO;
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

// You might need @WebServlet annotation if not using web.xml
// import jakarta.servlet.annotation.WebServlet;
// @WebServlet(name = "SearchController", urlPatterns = {"/search"})
public class SearchController extends HttpServlet {

    // Đặt số lượng sản phẩm mỗi trang (giống như trang home)
    private static final int PAGE_SIZE = 9;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processSearchRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processSearchRequest(request, response);
    }

    protected void processSearchRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String searchQuery = request.getParameter("searchQuery");
        String pageStr = request.getParameter("page");
        int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

        BookDAO bookDAO = new BookDAO();
        List<Book> bookList;
        int totalBooks;

        // Trim search query to handle empty spaces
        String trimmedQuery = (searchQuery != null) ? searchQuery.trim() : "";

        if (!trimmedQuery.isEmpty()) {
            // Thực hiện tìm kiếm
            bookList = bookDAO.searchBooks(trimmedQuery, currentPage, PAGE_SIZE);
            totalBooks = bookDAO.getTotalSearchBooks(trimmedQuery);
            request.setAttribute("searchQuery", trimmedQuery); // Pass the trimmed query
        } else {
            // Nếu không có từ khóa hoặc chỉ có khoảng trắng, hiển thị như trang home
            bookList = bookDAO.getBooksByPage(currentPage, PAGE_SIZE);
            totalBooks = bookDAO.getTotalBooks();
            // Không set searchQuery attribute
        }

        int totalPages = (int) Math.ceil((double) totalBooks / PAGE_SIZE);

       
        CategoryDAO categoryDAO = new CategoryDAO();
        AuthorDAO authorDAO = new AuthorDAO();
        PublisherDAO publisherDAO = new PublisherDAO();

        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Author> authorList = authorDAO.getAllAuthors();
        List<Publisher> publisherList = publisherDAO.getAllPublishers();

       
        request.setAttribute("bookList", bookList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        

        request.setAttribute("categoryList", categoryList);
        request.setAttribute("authorList", authorList);
        request.setAttribute("publisherList", publisherList);

      
        request.getRequestDispatcher("/customer/home.jsp").forward(request, response);
    }
}
