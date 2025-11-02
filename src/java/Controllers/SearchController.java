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
        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "default";
        }
        int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);
        
        // Lấy các tham số filter
        String categoryIdStr = request.getParameter("categoryId");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String authorIdStr = request.getParameter("authorId");
        String publisherIdStr = request.getParameter("publisherId");
        
        // Parse các tham số filter
        Integer categoryId = null;
        Double minPrice = null;
        Double maxPrice = null;
        Integer authorId = null;
        Integer publisherId = null;
        
        try {
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                categoryId = Integer.parseInt(categoryIdStr);
            }
            if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
            if (authorIdStr != null && !authorIdStr.trim().isEmpty()) {
                authorId = Integer.parseInt(authorIdStr);
            }
            if (publisherIdStr != null && !publisherIdStr.trim().isEmpty()) {
                publisherId = Integer.parseInt(publisherIdStr);
            }
        } catch (NumberFormatException e) {
            // Nếu parse lỗi, giữ giá trị null (không áp dụng filter đó)
            e.printStackTrace();
        }

        BookDAO bookDAO = new BookDAO();
        List<Book> bookList;
        int totalBooks;

        // Trim search query to handle empty spaces
        String trimmedQuery = (searchQuery != null) ? searchQuery.trim() : "";
        
        // Kiểm tra xem có filter hoặc search không
        boolean hasFilter = categoryId != null || minPrice != null || maxPrice != null 
                          || authorId != null || publisherId != null;
        boolean hasSearch = !trimmedQuery.isEmpty();

        if (hasSearch || hasFilter) {
            // Sử dụng phương thức searchAndFilterBooks để kết hợp tìm kiếm và lọc
            bookList = bookDAO.searchAndFilterBooks(
                trimmedQuery.isEmpty() ? null : trimmedQuery,
                categoryId, minPrice, maxPrice, authorId, publisherId, sortOrder,
                currentPage, PAGE_SIZE
            );
            totalBooks = bookDAO.getTotalSearchAndFilterBooks(
                trimmedQuery.isEmpty() ? null : trimmedQuery,
                categoryId, minPrice, maxPrice, authorId, publisherId
            );
            if (!trimmedQuery.isEmpty()) {
                request.setAttribute("searchQuery", trimmedQuery);
            }
        } else {
            // Nếu không có từ khóa và không có filter, hiển thị như trang home
            bookList = bookDAO.getBooksByPage(currentPage, PAGE_SIZE, sortOrder);
            totalBooks = bookDAO.getTotalBooks();
        }

        int totalPages = (int) Math.ceil((double) totalBooks / PAGE_SIZE);

       
        CategoryDAO categoryDAO = new CategoryDAO();
        AuthorDAO authorDAO = new AuthorDAO();
        PublisherDAO publisherDAO = new PublisherDAO();

        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Author> authorList = authorDAO.getAllAuthors();
        List<Publisher> publisherList = publisherDAO.getAllPublishers();
        
        // Lấy khoảng giá min/max
        java.util.Map<String, Double> priceRange = bookDAO.getPriceRange();

       
        request.setAttribute("bookList", bookList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        
        // Truyền lại các giá trị filter để hiển thị trên UI
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("selectedMinPrice", minPrice);
        request.setAttribute("selectedMaxPrice", maxPrice);
        request.setAttribute("selectedAuthorId", authorId);
        request.setAttribute("selectedPublisherId", publisherId);
        request.setAttribute("selectedSortOrder", sortOrder);
        request.setAttribute("priceRange", priceRange);

        request.setAttribute("categoryList", categoryList);
        request.setAttribute("authorList", authorList);
        request.setAttribute("publisherList", publisherList);

      
        request.getRequestDispatcher("/customer/home.jsp").forward(request, response);
    }
}
