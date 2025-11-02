package Controllers;

import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CategoryDAO;
import DAO.PublisherDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Author;
import model.Book;
import model.Category;
import model.Publisher;

@WebServlet(name = "BookManagementStaffController", urlPatterns = {"/staff/book-management"})
public class BookManagementStaffController extends HttpServlet {

    private AuthorDAO authorDAO = new AuthorDAO();
    private BookDAO bookDAO = new BookDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private PublisherDAO publisherDAO = new PublisherDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        // Kiểm tra đăng nhập
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login-register");
            return;
        }
        
        // Kiểm tra quyền - chỉ cho phép Staff (permission_id = 3)
        if (currentUser.getPermission_id() != 3) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    showBookList(request, response);
                    break;
                case "view":
                    showBookDetail(request, response);
                    break;
                case "add":
                    showBookForm(request, response);
                    break;
                case "edit":
                    showBookForm(request, response);
                    break;
                default:
                    showBookList(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            showBookList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        // Kiểm tra đăng nhập và quyền
        if (currentUser == null || currentUser.getPermission_id() != 3) {
            response.sendRedirect(request.getContextPath() + "/login-register");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addBook(request, response);
                    break;
                case "update":
                    updateBook(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "updateStock":
                    updateBookStock(request, response);
                    break;
                default:
                    response.sendRedirect("book-management");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi khi xử lý: " + e.getMessage());
            response.sendRedirect("book-management");
        }
    }

    private void showBookList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Lấy thông báo từ session và xóa nó
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");
        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("success");
        }
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }
        
        String pageStr = request.getParameter("page");
        String search = request.getParameter("search");
        
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int recordsPerPage = 10;
        
        List<Book> books;
        int totalBooks;
        
        if (search != null && !search.trim().isEmpty()) {
            books = bookDAO.searchBooks(search, page, recordsPerPage, "default");
            totalBooks = bookDAO.getTotalSearchBooks(search);
        } else {
            books = bookDAO.getAllBooksWithDetails(page, recordsPerPage);
            totalBooks = bookDAO.getTotalBooks();
        }
        
        int totalPages = (int) Math.ceil((double) totalBooks / recordsPerPage);
        
        // Lấy số lượng bán cho mỗi sách
        java.util.Map<Integer, Integer> soldCountMap = new java.util.HashMap<>();
        for (Book book : books) {
            int soldCount = bookDAO.getBooksSoldCount(book.getBId());
            soldCountMap.put(book.getBId(), soldCount);
        }
        
        // Thống kê
        int lowStockCount = bookDAO.getLowStockBooksCount();
        int outOfStockCount = bookDAO.getOutOfStockBooksCount();
        
        request.setAttribute("books", books);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("search", search);
        request.setAttribute("soldCountMap", soldCountMap);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("outOfStockCount", outOfStockCount);
        
        request.getRequestDispatcher("/staff/book-management.jsp").forward(request, response);
    }

    private void showBookDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book book = bookDAO.getBookWithDetailsById(bookId);
        
        if (book == null) {
            request.setAttribute("error", "Không tìm thấy sách!");
            response.sendRedirect("book-management");
            return;
        }
        
        // Lấy thông tin bổ sung
        int soldCount = bookDAO.getBooksSoldCount(bookId);
        boolean isInOrder = bookDAO.isBookInOrder(bookId);
        
        request.setAttribute("book", book);
        request.setAttribute("soldCount", soldCount);
        request.setAttribute("isInOrder", isInOrder);
        
        request.getRequestDispatcher("/staff/book-detail.jsp").forward(request, response);
    }

    private void showBookForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        Book book = null;
        int soldCount = 0;
        boolean isInOrder = false;
        
        if ("edit".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            book = bookDAO.getBookWithDetailsById(bookId);
            if (book == null) {
                request.setAttribute("error", "Không tìm thấy sách!");
                response.sendRedirect("book-management");
                return;
            }
            soldCount = bookDAO.getBooksSoldCount(bookId);
            isInOrder = bookDAO.isBookInOrder(bookId);
        }
        
        // Lấy danh sách authors, categories, publishers
        List<Author> authors = authorDAO.getAllAuthors();
        List<Category> categories = categoryDAO.getAllCategories();
        List<Publisher> publishers = publisherDAO.getAllPublishers();
        
        request.setAttribute("book", book);
        request.setAttribute("soldCount", soldCount);
        request.setAttribute("isInOrder", isInOrder);
        request.setAttribute("authors", authors);
        request.setAttribute("categories", categories);
        request.setAttribute("publishers", publishers);
        
        request.getRequestDispatcher("/staff/book-form.jsp").forward(request, response);
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String publicationYearStr = request.getParameter("publicationYear");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String publisherIdStr = request.getParameter("publisherId");
            String authorIdStr = request.getParameter("authorId");
            String categoryIdStr = request.getParameter("categoryId");
            
            // Validation
            if (title == null || title.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập tên sách!");
                response.sendRedirect("book-management?action=add");
                return;
            }
            
            int publicationYear = Integer.parseInt(publicationYearStr);
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);
            int publisherId = Integer.parseInt(publisherIdStr);
            int authorId = Integer.parseInt(authorIdStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            boolean success = bookDAO.addBook(title.trim(), description != null ? description.trim() : "", 
                                            publicationYear, price, stock, publisherId, authorId, categoryId);
            
            if (success) {
                session.setAttribute("success", "Thêm sách thành công!");
            } else {
                session.setAttribute("error", "Thêm sách thất bại!");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Vui lòng nhập đúng định dạng số!");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi khi thêm sách: " + e.getMessage());
        }
        
        response.sendRedirect("book-management");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String publicationYearStr = request.getParameter("publicationYear");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String publisherIdStr = request.getParameter("publisherId");
            String authorIdStr = request.getParameter("authorId");
            String categoryIdStr = request.getParameter("categoryId");
            
            // Validation
            if (title == null || title.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập tên sách!");
                response.sendRedirect("book-management?action=edit&bookId=" + bookId);
                return;
            }
            
            int publicationYear = Integer.parseInt(publicationYearStr);
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);
            int publisherId = Integer.parseInt(publisherIdStr);
            int authorId = Integer.parseInt(authorIdStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            boolean success = bookDAO.updateBook(bookId, title.trim(), description != null ? description.trim() : "", 
                                               publicationYear, price, stock, publisherId, authorId, categoryId);
            
            if (success) {
                session.setAttribute("success", "Cập nhật sách thành công!");
            } else {
                session.setAttribute("error", "Cập nhật sách thất bại!");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Vui lòng nhập đúng định dạng số!");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi khi cập nhật sách: " + e.getMessage());
        }
        
        response.sendRedirect("book-management");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        
        // Kiểm tra xem sách có đang được sử dụng trong đơn hàng không
        if (bookDAO.isBookInOrder(bookId)) {
            session.setAttribute("error", "Không thể xóa sách đang được sử dụng trong đơn hàng!");
            response.sendRedirect("book-management");
            return;
        }
        
        boolean success = bookDAO.deleteBook(bookId);
        
        if (success) {
            session.setAttribute("success", "Xóa sách thành công!");
        } else {
            session.setAttribute("error", "Xóa sách thất bại!");
        }
        
        response.sendRedirect("book-management");
    }

    private void updateBookStock(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int newStock = Integer.parseInt(request.getParameter("newStock"));
            
            boolean success = bookDAO.updateBookStock(bookId, newStock);
            
            if (success) {
                session.setAttribute("success", "Cập nhật tồn kho thành công!");
            } else {
                session.setAttribute("error", "Cập nhật tồn kho thất bại!");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Vui lòng nhập đúng định dạng số!");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi khi cập nhật tồn kho: " + e.getMessage());
        }
        
        response.sendRedirect("book-management");
    }
}

