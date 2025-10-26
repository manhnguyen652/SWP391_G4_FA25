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

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Thực hiện tìm kiếm
            bookList = bookDAO.searchBooks(searchQuery, currentPage, PAGE_SIZE);
            totalBooks = bookDAO.getTotalSearchBooks(searchQuery);
            request.setAttribute("searchQuery", searchQuery); // Gửi lại từ khóa để sticky form và phân trang
        } else {
            // Nếu không có từ khóa, hoạt động như trang home
            bookList = bookDAO.getBooksByPage(currentPage, PAGE_SIZE);
            totalBooks = bookDAO.getTotalBooks();
        }

        int totalPages = (int) Math.ceil((double) totalBooks / PAGE_SIZE);

        // --- TẢI DỮ LIỆU SIDEBAR (BẮT BUỘC) ---
        // Giả định bạn đã có các DAO này
        CategoryDAO categoryDAO = new CategoryDAO();
        AuthorDAO authorDAO = new AuthorDAO();
        PublisherDAO publisherDAO = new PublisherDAO();

        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Author> authorList = authorDAO.getAllAuthors();
        List<Publisher> publisherList = publisherDAO.getAllPublishers();

        // --- Gửi dữ liệu đến JSP ---
        request.setAttribute("bookList", bookList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("categoryList", categoryList);
        request.setAttribute("authorList", authorList);
        request.setAttribute("publisherList", publisherList);

        // (Giả sử dữ liệu giỏ hàng (cartItemsHeader, v.v.) được tải bởi một Filter)
        // Forward về home.jsp để hiển thị
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
