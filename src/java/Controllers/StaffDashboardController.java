package Controllers;

import DAO.AccountDAO;
import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CategoryDAO;
import DAO.OrderDAO;
import DAO.PublisherDAO;
import DAO.RefundDAO;
import model.Account;
import model.Author;
import model.Book;
import model.Category;
import model.Order;
import model.Publisher;
import model.Refund;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StaffDashboardController", urlPatterns = {"/staff-dashboard"})
public class StaffDashboardController extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();
    private AuthorDAO authorDAO = new AuthorDAO();
    private BookDAO bookDAO = new BookDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private PublisherDAO publisherDAO = new PublisherDAO();
    private RefundDAO refundDAO = new RefundDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        // Kiểm tra quyền truy cập
        if (currentUser == null) {
            response.sendRedirect("login-register");
            return;
        }
        
        // Chỉ cho phép Admin và Staff truy cập
        if (currentUser.getPermission_id() != 1 && currentUser.getPermission_id() != 3) {
            response.sendRedirect("home");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }
        
        try {
            switch (action) {
                case "dashboard":
                    showDashboard(request, response);
                    break;
                case "users":
                    showUserManagement(request, response);
                    break;
                case "viewUser":
                    showUserDetail(request, response);
                    break;
                case "addUser":
                    showUserForm(request, response);
                    break;
                case "editUser":
                    showUserForm(request, response);
                    break;
                case "books":
                    showBookManagement(request, response);
                    break;
                case "orders":
                    showOrderManagement(request, response);
                    break;
                case "viewOrder":
                    showOrderDetail(request, response);
                    break;
                case "refunds":
                    showRefundManagement(request, response);
                    break;
                case "viewRefund":
                    showRefundDetail(request, response);
                    break;
                case "createRefund":
                    showCreateRefundForm(request, response);
                    break;
                case "authors":
                    showAuthorManagement(request, response);
                    break;
                case "viewAuthor":
                    showAuthorDetail(request, response);
                    break;
                case "addAuthor":
                    showAuthorForm(request, response);
                    break;
                case "editAuthor":
                    showAuthorForm(request, response);
                    break;
                case "exportAuthors":
                    exportAuthorsToExcel(request, response);
                    break;
                case "viewBook":
                    showBookDetail(request, response);
                    break;
                case "addBook":
                    showBookForm(request, response);
                    break;
                case "editBook":
                    showBookForm(request, response);
                    break;
                case "exportBooks":
                    exportBooksToExcel(request, response);
                    break;
                case "categories":
                    showCategoryManagement(request, response);
                    break;
                case "viewCategory":
                    showCategoryDetail(request, response);
                    break;
                case "addCategory":
                    showCategoryForm(request, response);
                    break;
                case "editCategory":
                    showCategoryForm(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        // Kiểm tra quyền truy cập
        if (currentUser == null || (currentUser.getPermission_id() != 1 && currentUser.getPermission_id() != 3)) {
            response.sendRedirect("login-register");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "updateUserStatus":
                    updateUserStatus(request, response);
                    break;
                case "addUser":
                    addUser(request, response);
                    break;
                case "updateUser":
                    updateUser(request, response);
                    break;
                case "deleteUser":
                    deleteUser(request, response);
                    break;
                case "updateBookStock":
                    updateBookStock(request, response);
                    break;
                case "updateOrderStatus":
                    updateOrderStatus(request, response);
                    break;
                case "createRefund":
                    createRefund(request, response);
                    break;
                case "updateRefundStatus":
                    updateRefundStatus(request, response);
                    break;
                case "addAuthor":
                    addAuthor(request, response);
                    break;
                case "updateAuthor":
                    updateAuthor(request, response);
                    break;
                case "deleteAuthor":
                    deleteAuthor(request, response);
                    break;
                case "addBook":
                    addBook(request, response);
                    break;
                case "updateBook":
                    updateBook(request, response);
                    break;
                case "deleteBook":
                    deleteBook(request, response);
                    break;
                case "addCategory":
                    addCategory(request, response);
                    break;
                case "updateCategory":
                    updateCategory(request, response);
                    break;
                case "deleteCategory":
                    deleteCategory(request, response);
                    break;
                default:
                    response.sendRedirect("staff-dashboard");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy thống kê tổng quan
        int totalUsers = accountDAO.getTotalUsers();
        int totalBooks = bookDAO.getTotalBooks();
        int totalOrders = orderDAO.getTotalOrders();
        double totalRevenue = orderDAO.getTotalRevenue();
        
        // Lấy danh sách đơn hàng gần đây
        List<Order> recentOrders = orderDAO.getRecentOrders(5);
        
        // Lấy danh sách sách bán chạy
        List<Book> topSellingBooks = bookDAO.getTopSellingBooks(5);
        
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("topSellingBooks", topSellingBooks);
        
        request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
    }
    

    private void showUserManagement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pageStr = request.getParameter("page");
        String search = request.getParameter("search");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int recordsPerPage = 10;
        
        // Lấy danh sách users với filter
        List<Account> users = accountDAO.getUsersWithFilter(search, role, status, page, recordsPerPage);
        
        // Lấy thống kê
        int totalUsers = accountDAO.getTotalUsers();
        int verifiedUsers = accountDAO.getVerifiedUsersCount();
        int unverifiedUsers = totalUsers - verifiedUsers;
        int newUsersToday = accountDAO.getNewUsersTodayCount();
        
        // Tính tổng số trang
        int totalFilteredUsers = accountDAO.getTotalUsersWithFilter(search, role, status);
        int totalPages = (int) Math.ceil((double) totalFilteredUsers / recordsPerPage);
        
        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("verifiedUsers", verifiedUsers);
        request.setAttribute("unverifiedUsers", unverifiedUsers);
        request.setAttribute("newUsersToday", newUsersToday);
        
        request.getRequestDispatcher("/staff/user-management.jsp").forward(request, response);
    }

    private void showOrderManagement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pageStr = request.getParameter("page");
        String search = request.getParameter("search");
        
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int recordsPerPage = 10;
        
        List<Order> orders;
        int totalOrders;
        
        if (search != null && !search.trim().isEmpty()) {
            orders = orderDAO.searchOrders(search, page, recordsPerPage);
            totalOrders = orderDAO.getTotalSearchOrders(search);
        } else {
            orders = orderDAO.getAllOrders(page, recordsPerPage);
            totalOrders = orderDAO.getTotalOrders();
        }
        
        int totalPages = (int) Math.ceil((double) totalOrders / recordsPerPage);
        
        // Thống kê đơn hàng
        int pendingOrders = orderDAO.getOrdersByStatus(1); // Đang chờ xử lý
        int confirmedOrders = orderDAO.getOrdersByStatus(2); // Đã xác nhận
        int shippingOrders = orderDAO.getOrdersByStatus(3); // Đang giao hàng
        int completedOrders = orderDAO.getOrdersByStatus(4); // Đã giao hàng
        int cancelledOrders = orderDAO.getOrdersByStatus(5); // Đã hủy
        int todayOrders = orderDAO.getTodayOrders(); // Đơn hàng hôm nay
        double todayRevenue = orderDAO.getTodayRevenue(); // Doanh thu hôm nay
        double totalRevenue = orderDAO.getTotalRevenue(); // Tổng doanh thu
        
        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("search", search);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("confirmedOrders", confirmedOrders);
        request.setAttribute("shippingOrders", shippingOrders);
        request.setAttribute("completedOrders", completedOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);
        request.setAttribute("todayOrders", todayOrders);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("totalRevenue", totalRevenue);
        
        request.getRequestDispatcher("/staff/order-management.jsp").forward(request, response);
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = orderDAO.getOrderById(orderId);
        
        if (order == null) {
            request.setAttribute("error", "Không tìm thấy đơn hàng!");
            response.sendRedirect("staff-dashboard?action=orders");
            return;
        }
        
        // Lấy chi tiết đơn hàng
        List<Object[]> orderDetails = orderDAO.getOrderDetails(orderId);
        
        // Lấy danh sách trạng thái
        List<Object[]> statuses = orderDAO.getAllStatuses();
        
        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);
        request.setAttribute("statuses", statuses);
        
        request.getRequestDispatcher("/staff/order-detail.jsp").forward(request, response);
    }


    private void updateUserStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        boolean isVerified = Boolean.parseBoolean(request.getParameter("isVerified"));
        
        // Lấy thông tin user cần cập nhật
        Account targetUser = accountDAO.getAccountById(userId);
        
        if (targetUser == null) {
            request.setAttribute("error", "Không tìm thấy người dùng!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        // Kiểm tra quyền
        boolean hasPermission = false;
        if (currentUser.getPermission_id() == 1) { // Admin
            // Admin có thể xác thực tất cả trừ Admin khác
            hasPermission = (targetUser.getPermission_id() != 1);
        } else if (currentUser.getPermission_id() == 3) { // Staff
            // Staff có thể xác thực User thông thường và Shipper
            hasPermission = (targetUser.getPermission_id() == 2 || targetUser.getPermission_id() == 4);
        }
        
        if (!hasPermission) {
            request.setAttribute("error", "Bạn không có quyền thực hiện thao tác này!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        boolean success = accountDAO.updateUserVerificationStatus(userId, isVerified);
        
        if (success) {
            request.setAttribute("success", "Cập nhật trạng thái người dùng thành công!");
        } else {
            request.setAttribute("error", "Cập nhật trạng thái người dùng thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=users");
    }

    private void updateBookStock(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int newStock = Integer.parseInt(request.getParameter("newStock"));
        
        boolean success = bookDAO.updateBookStock(bookId, newStock);
        
        if (success) {
            request.setAttribute("success", "Cập nhật tồn kho thành công!");
        } else {
            request.setAttribute("error", "Cập nhật tồn kho thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=books");
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int statusId = Integer.parseInt(request.getParameter("statusId"));
        
        boolean success = orderDAO.updateOrderStatus(orderId, statusId);
        
        if (success) {
            request.setAttribute("success", "Cập nhật trạng thái đơn hàng thành công!");
        } else {
            request.setAttribute("error", "Cập nhật trạng thái đơn hàng thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=orders");
    }

    private void showUserDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        Account user = accountDAO.getAccountById(userId);
        
        if (user == null) {
            request.setAttribute("error", "Không tìm thấy người dùng!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/staff/user-detail.jsp").forward(request, response);
    }

    private void showUserForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        Account user = null;
        
        if ("editUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            user = accountDAO.getAccountById(userId);
            
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy người dùng!");
                response.sendRedirect("staff-dashboard?action=users");
                return;
            }
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/staff/user-form.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        // Kiểm tra quyền tạo user
        if (currentUser.getPermission_id() != 1 && currentUser.getPermission_id() != 3) {
            request.setAttribute("error", "Bạn không có quyền thực hiện thao tác này!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dob = request.getParameter("dob");
        int permissionId = Integer.parseInt(request.getParameter("permission"));
        
        // Kiểm tra quyền tạo role
        if (currentUser.getPermission_id() == 3 && (permissionId == 1 || permissionId == 3)) {
            request.setAttribute("error", "Bạn không có quyền tạo tài khoản Admin hoặc Staff!");
            response.sendRedirect("staff-dashboard?action=addUser");
            return;
        }
        
        // Kiểm tra email đã tồn tại
        if (accountDAO.checkAccountExist(email) != null) {
            request.setAttribute("error", "Email đã tồn tại!");
            response.sendRedirect("staff-dashboard?action=addUser");
            return;
        }
        
        Account newUser = new Account();
        newUser.setU_email(email);
        newUser.setU_pass(password);
        newUser.setF_name(firstName);
        newUser.setL_name(lastName);
        if (dob != null && !dob.isEmpty()) {
            newUser.setDob(java.sql.Date.valueOf(dob));
        }
        newUser.setPermission_id(permissionId);
        newUser.setIs_verified(true); // Tự động xác thực khi tạo bởi Admin/Staff
        
        boolean success = accountDAO.register(newUser);
        
        if (success) {
            request.setAttribute("success", "Thêm người dùng thành công!");
        } else {
            request.setAttribute("error", "Thêm người dùng thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=users");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        Account targetUser = accountDAO.getAccountById(userId);
        
        if (targetUser == null) {
            request.setAttribute("error", "Không tìm thấy người dùng!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        // Kiểm tra quyền chỉnh sửa
        boolean hasPermission = false;
        if (currentUser.getPermission_id() == 1) {
            hasPermission = (targetUser.getPermission_id() != 1);
        } else if (currentUser.getPermission_id() == 3) {
            hasPermission = (targetUser.getPermission_id() == 2 || targetUser.getPermission_id() == 4);
        }
        
        if (!hasPermission) {
            request.setAttribute("error", "Bạn không có quyền chỉnh sửa người dùng này!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dob = request.getParameter("dob");
        int permissionId = Integer.parseInt(request.getParameter("permission"));
        
        // Kiểm tra quyền thay đổi role
        if (currentUser.getPermission_id() == 3 && (permissionId == 1 || permissionId == 3)) {
            request.setAttribute("error", "Bạn không có quyền thay đổi thành Admin hoặc Staff!");
            response.sendRedirect("staff-dashboard?action=editUser&userId=" + userId);
            return;
        }
        
        // Kiểm tra email trùng (trừ chính user đó)
        Account existingUser = accountDAO.checkAccountExist(email);
        if (existingUser != null && existingUser.getU_id() != userId) {
            request.setAttribute("error", "Email đã được sử dụng bởi người dùng khác!");
            response.sendRedirect("staff-dashboard?action=editUser&userId=" + userId);
            return;
        }
        
        boolean success = accountDAO.updateUser(userId, email, password, firstName, lastName, dob, permissionId);
        
        if (success) {
            request.setAttribute("success", "Cập nhật người dùng thành công!");
        } else {
            request.setAttribute("error", "Cập nhật người dùng thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");
        
        // Chỉ Admin mới có quyền xóa
        if (currentUser.getPermission_id() != 1) {
            request.setAttribute("error", "Bạn không có quyền xóa người dùng!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        int userId = Integer.parseInt(request.getParameter("userId"));
        Account targetUser = accountDAO.getAccountById(userId);
        
        if (targetUser == null) {
            request.setAttribute("error", "Không tìm thấy người dùng!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        // Không thể xóa Admin khác
        if (targetUser.getPermission_id() == 1) {
            request.setAttribute("error", "Không thể xóa tài khoản Admin!");
            response.sendRedirect("staff-dashboard?action=users");
            return;
        }
        
        boolean success = accountDAO.deleteUser(userId);
        
        if (success) {
            request.setAttribute("success", "Xóa người dùng thành công!");
        } else {
            request.setAttribute("error", "Xóa người dùng thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=users");
    }

    // Category Management Methods
    private void showCategoryManagement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pageStr = request.getParameter("page");
        String search = request.getParameter("search");
        
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int recordsPerPage = 10;
        
        List<Category> categories;
        int totalCategories;
        
        if (search != null && !search.trim().isEmpty()) {
            categories = categoryDAO.searchCategories(search, page, recordsPerPage);
            totalCategories = categoryDAO.getTotalSearchCategories(search);
        } else {
            categories = categoryDAO.getAllCategories(page, recordsPerPage);
            totalCategories = categoryDAO.getTotalCategories();
        }
        
        int totalPages = (int) Math.ceil((double) totalCategories / recordsPerPage);
        
        // Lấy thống kê categories
        List<Object[]> categoryStats = categoryDAO.getCategoryStatistics();
        
        // Tạo Map để dễ dàng truy cập số sách theo category ID
        java.util.Map<Integer, Integer> bookCountMap = new java.util.HashMap<>();
        for (Object[] stat : categoryStats) {
            bookCountMap.put((Integer) stat[0], (Integer) stat[2]);
        }
        
        // Tính toán thống kê chính xác
        int categoriesWithBooks = 0;
        int emptyCategories = 0;
        for (Category category : categories) {
            Integer bookCount = bookCountMap.get(category.getId());
            if (bookCount == null) bookCount = 0;
            if (bookCount > 0) {
                categoriesWithBooks++;
            } else {
                emptyCategories++;
            }
        }
        
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("search", search);
        request.setAttribute("categoryStats", categoryStats);
        request.setAttribute("bookCountMap", bookCountMap);
        request.setAttribute("categoriesWithBooks", categoriesWithBooks);
        request.setAttribute("emptyCategories", emptyCategories);
        
        request.getRequestDispatcher("/staff/category-management.jsp").forward(request, response);
    }

    private void showCategoryDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Category category = categoryDAO.getCategoryById(categoryId);
        
        if (category == null) {
            request.setAttribute("error", "Không tìm thấy danh mục!");
            response.sendRedirect("staff-dashboard?action=categories");
            return;
        }
        
        // Lấy số sách trong danh mục
        int bookCount = categoryDAO.getTotalBooksInCategory(categoryId);
        
        request.setAttribute("category", category);
        request.setAttribute("bookCount", bookCount);
        
        request.getRequestDispatcher("/staff/category-detail.jsp").forward(request, response);
    }

    private void showCategoryForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        Category category = null;
        int bookCount = 0;
        
        if ("editCategory".equals(action)) {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            category = categoryDAO.getCategoryById(categoryId);
            if (category == null) {
                request.setAttribute("error", "Không tìm thấy danh mục!");
                response.sendRedirect("staff-dashboard?action=categories");
                return;
            }
            // Lấy số sách trong danh mục khi edit
            bookCount = categoryDAO.getTotalBooksInCategory(categoryId);
        }
        
        request.setAttribute("category", category);
        request.setAttribute("bookCount", bookCount);
        request.getRequestDispatcher("/staff/category-form.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryName = request.getParameter("categoryName");
        
        if (categoryName == null || categoryName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên danh mục!");
            response.sendRedirect("staff-dashboard?action=categories");
            return;
        }
        
        boolean success = categoryDAO.addCategory(categoryName.trim());
        
        if (success) {
            request.setAttribute("success", "Thêm danh mục thành công!");
        } else {
            request.setAttribute("error", "Thêm danh mục thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=categories");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String categoryName = request.getParameter("categoryName");
        
        if (categoryName == null || categoryName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên danh mục!");
            response.sendRedirect("staff-dashboard?action=categories");
            return;
        }
        
        boolean success = categoryDAO.updateCategory(categoryId, categoryName.trim());
        
        if (success) {
            request.setAttribute("success", "Cập nhật danh mục thành công!");
        } else {
            request.setAttribute("error", "Cập nhật danh mục thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=categories");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        
        // Kiểm tra xem danh mục có đang được sử dụng không
        if (categoryDAO.isCategoryInUse(categoryId)) {
            request.setAttribute("error", "Không thể xóa danh mục đang được sử dụng bởi sách!");
            response.sendRedirect("staff-dashboard?action=categories");
            return;
        }
        
        boolean success = categoryDAO.deleteCategory(categoryId);
        
        if (success) {
            request.setAttribute("success", "Xóa danh mục thành công!");
        } else {
            request.setAttribute("error", "Xóa danh mục thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=categories");
    }

    // Refund Management Methods
    private void showRefundManagement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pageStr = request.getParameter("page");
        String search = request.getParameter("search");
        
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int recordsPerPage = 10;
        
        List<Refund> refunds;
        int totalRefunds;
        
        if (search != null && !search.trim().isEmpty()) {
            refunds = refundDAO.searchRefunds(search, page, recordsPerPage);
            totalRefunds = refundDAO.getTotalSearchRefunds(search);
        } else {
            refunds = refundDAO.getAllRefunds(page, recordsPerPage);
            totalRefunds = refundDAO.getTotalRefunds();
        }
        
        int totalPages = (int) Math.ceil((double) totalRefunds / recordsPerPage);
        
        // Thống kê refund
        int pendingRefunds = refundDAO.getRefundsByStatus("PENDING");
        int approvedRefunds = refundDAO.getRefundsByStatus("APPROVED");
        int rejectedRefunds = refundDAO.getRefundsByStatus("REJECTED");
        int completedRefunds = refundDAO.getRefundsByStatus("COMPLETED");
        double totalRefundAmount = refundDAO.getTotalRefundAmount();
        
        request.setAttribute("refunds", refunds);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRefunds", totalRefunds);
        request.setAttribute("search", search);
        request.setAttribute("pendingRefunds", pendingRefunds);
        request.setAttribute("approvedRefunds", approvedRefunds);
        request.setAttribute("rejectedRefunds", rejectedRefunds);
        request.setAttribute("completedRefunds", completedRefunds);
        request.setAttribute("totalRefundAmount", totalRefundAmount);
        
        request.getRequestDispatcher("/staff/refund-management.jsp").forward(request, response);
    }

    private void showRefundDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int refundId = Integer.parseInt(request.getParameter("refundId"));
        Refund refund = refundDAO.getRefundById(refundId);
        
        if (refund == null) {
            request.setAttribute("error", "Không tìm thấy yêu cầu hoàn tiền!");
            response.sendRedirect("staff-dashboard?action=refunds");
            return;
        }
        
        request.setAttribute("refund", refund);
        request.getRequestDispatcher("/staff/refund-detail.jsp").forward(request, response);
    }

    private void showCreateRefundForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = orderDAO.getOrderById(orderId);
        
        if (order == null) {
            request.setAttribute("error", "Không tìm thấy đơn hàng!");
            response.sendRedirect("staff-dashboard?action=orders");
            return;
        }
        
        request.setAttribute("order", order);
        request.getRequestDispatcher("/staff/refund-form.jsp").forward(request, response);
    }

    private void createRefund(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        String reason = request.getParameter("reason");
        
        if (reason == null || reason.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập lý do hoàn tiền!");
            response.sendRedirect("staff-dashboard?action=createRefund&orderId=" + orderId);
            return;
        }
        
        Refund refund = new Refund(orderId, userId, amount, reason.trim());
        boolean success = refundDAO.createRefund(refund);
        
        if (success) {
            request.setAttribute("success", "Tạo yêu cầu hoàn tiền thành công!");
        } else {
            request.setAttribute("error", "Tạo yêu cầu hoàn tiền thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=refunds");
    }

    private void updateRefundStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int refundId = Integer.parseInt(request.getParameter("refundId"));
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String processedBy = account.getF_name() + " " + account.getL_name();
        
        boolean success = refundDAO.updateRefundStatus(refundId, status, processedBy, notes);
        
        if (success) {
            request.setAttribute("success", "Cập nhật trạng thái hoàn tiền thành công!");
        } else {
            request.setAttribute("error", "Cập nhật trạng thái hoàn tiền thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=refunds");
    }

    // Author Management Methods
    private void showAuthorManagement(HttpServletRequest request, HttpServletResponse response) 
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
        
        List<Author> authors;
        int totalAuthors;
        
        if (search != null && !search.trim().isEmpty()) {
            authors = authorDAO.searchAuthors(search, page, recordsPerPage);
            totalAuthors = authorDAO.getTotalSearchAuthors(search);
        } else {
            authors = authorDAO.getAllAuthors(page, recordsPerPage);
            totalAuthors = authorDAO.getTotalAuthors();
        }
        
        int totalPages = (int) Math.ceil((double) totalAuthors / recordsPerPage);
        
        // Lấy số sách cho mỗi tác giả
        java.util.Map<Integer, Integer> bookCountMap = new java.util.HashMap<>();
        for (Author author : authors) {
            int bookCount = authorDAO.getBookCountByAuthor(author.getId());
            bookCountMap.put(author.getId(), bookCount);
        }
        
        request.setAttribute("authors", authors);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalAuthors", totalAuthors);
        request.setAttribute("search", search);
        request.setAttribute("bookCountMap", bookCountMap);
        
        request.getRequestDispatcher("/staff/author-management.jsp").forward(request, response);
    }

    private void showAuthorDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int authorId = Integer.parseInt(request.getParameter("authorId"));
        Author author = authorDAO.getAuthorById(authorId);
        
        if (author == null) {
            request.setAttribute("error", "Không tìm thấy tác giả!");
            response.sendRedirect("staff-dashboard?action=authors");
            return;
        }
        
        // Lấy số sách của tác giả
        int bookCount = authorDAO.getBookCountByAuthor(authorId);
        boolean isInUse = authorDAO.isAuthorInUse(authorId);
        
        request.setAttribute("author", author);
        request.setAttribute("bookCount", bookCount);
        request.setAttribute("isInUse", isInUse);
        
        request.getRequestDispatcher("/staff/author-detail.jsp").forward(request, response);
    }

    private void showAuthorForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        Author author = null;
        int bookCount = 0;
        
        if ("editAuthor".equals(action)) {
            int authorId = Integer.parseInt(request.getParameter("authorId"));
            author = authorDAO.getAuthorById(authorId);
            if (author == null) {
                request.setAttribute("error", "Không tìm thấy tác giả!");
                response.sendRedirect("staff-dashboard?action=authors");
                return;
            }
            bookCount = authorDAO.getBookCountByAuthor(authorId);
        }
        
        request.setAttribute("author", author);
        request.setAttribute("bookCount", bookCount);
        request.getRequestDispatcher("/staff/author-form.jsp").forward(request, response);
    }

    private void addAuthor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");
        
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập tên tác giả!");
            response.sendRedirect("staff-dashboard?action=authors");
            return;
        }
        
        boolean success = authorDAO.addAuthor(name.trim(), bio != null ? bio.trim() : "");
        
        if (success) {
            session.setAttribute("success", "Thêm tác giả thành công!");
        } else {
            session.setAttribute("error", "Thêm tác giả thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=authors");
    }

    private void updateAuthor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        int authorId = Integer.parseInt(request.getParameter("authorId"));
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");
        
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập tên tác giả!");
            response.sendRedirect("staff-dashboard?action=authors");
            return;
        }
        
        boolean success = authorDAO.updateAuthor(authorId, name.trim(), bio != null ? bio.trim() : "");
        
        if (success) {
            session.setAttribute("success", "Cập nhật tác giả thành công!");
        } else {
            session.setAttribute("error", "Cập nhật tác giả thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=authors");
    }

    private void deleteAuthor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        int authorId = Integer.parseInt(request.getParameter("authorId"));
        
        // Kiểm tra xem tác giả có đang được sử dụng không
        if (authorDAO.isAuthorInUse(authorId)) {
            session.setAttribute("error", "Không thể xóa tác giả đang được sử dụng bởi sách!");
            response.sendRedirect("staff-dashboard?action=authors");
            return;
        }
        
        boolean success = authorDAO.deleteAuthor(authorId);
        
        if (success) {
            session.setAttribute("success", "Xóa tác giả thành công!");
        } else {
            session.setAttribute("error", "Xóa tác giả thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=authors");
    }

    private void exportAuthorsToExcel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Author> authors = authorDAO.getAllAuthors();
            
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=authors_list.xls");
            
            java.io.PrintWriter out = response.getWriter();
            
            // Tạo header Excel
            out.println("<html>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<table border='1'>");
            out.println("<tr>");
            out.println("<th>ID</th>");
            out.println("<th>Tên tác giả</th>");
            out.println("<th>Tiểu sử</th>");
            out.println("<th>Số sách</th>");
            out.println("</tr>");
            
            // Thêm dữ liệu
            for (Author author : authors) {
                int bookCount = authorDAO.getBookCountByAuthor(author.getId());
                out.println("<tr>");
                out.println("<td>" + author.getId() + "</td>");
                out.println("<td>" + author.getName() + "</td>");
                out.println("<td>" + (author.getBio() != null ? author.getBio() : "") + "</td>");
                out.println("<td>" + bookCount + "</td>");
                out.println("</tr>");
            }
            
            out.println("</table>");
            out.println("</body>");
            out.println("</html>");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi xuất file Excel: " + e.getMessage());
            response.sendRedirect("staff-dashboard?action=authors");
        }
    }

    // Book Management Methods
    private void showBookManagement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
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
                books = bookDAO.searchBooks(search, page, recordsPerPage);
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
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải trang quản lý sách: " + e.getMessage());
            request.getRequestDispatcher("/staff/dashboard.jsp").forward(request, response);
        }
    }

    private void showBookDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book book = bookDAO.getBookWithDetailsById(bookId);
        
        if (book == null) {
            request.setAttribute("error", "Không tìm thấy sách!");
            response.sendRedirect("staff-dashboard?action=books");
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
        
        if ("editBook".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            book = bookDAO.getBookWithDetailsById(bookId);
            if (book == null) {
                request.setAttribute("error", "Không tìm thấy sách!");
                response.sendRedirect("staff-dashboard?action=books");
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
                response.sendRedirect("staff-dashboard?action=books");
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
        
        response.sendRedirect("staff-dashboard?action=books");
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
                response.sendRedirect("staff-dashboard?action=books");
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
        
        response.sendRedirect("staff-dashboard?action=books");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        
        // Kiểm tra xem sách có đang được sử dụng trong đơn hàng không
        if (bookDAO.isBookInOrder(bookId)) {
            session.setAttribute("error", "Không thể xóa sách đang được sử dụng trong đơn hàng!");
            response.sendRedirect("staff-dashboard?action=books");
            return;
        }
        
        boolean success = bookDAO.deleteBook(bookId);
        
        if (success) {
            session.setAttribute("success", "Xóa sách thành công!");
        } else {
            session.setAttribute("error", "Xóa sách thất bại!");
        }
        
        response.sendRedirect("staff-dashboard?action=books");
    }

    private void exportBooksToExcel(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Book> books = bookDAO.getAllBooksWithDetails(1, 1000); // Lấy tối đa 1000 sách
            
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=books_list.xls");
            
            java.io.PrintWriter out = response.getWriter();
            
            // Tạo header Excel
            out.println("<html>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<table border='1'>");
            out.println("<tr>");
            out.println("<th>ID</th>");
            out.println("<th>Tên sách</th>");
            out.println("<th>Tác giả</th>");
            out.println("<th>Danh mục</th>");
            out.println("<th>Nhà xuất bản</th>");
            out.println("<th>Năm xuất bản</th>");
            out.println("<th>Giá</th>");
            out.println("<th>Tồn kho</th>");
            out.println("</tr>");
            
            // Thêm dữ liệu
            for (Book book : books) {
                out.println("<tr>");
                out.println("<td>" + book.getBId() + "</td>");
                out.println("<td>" + book.getBTitle() + "</td>");
                out.println("<td>" + (book.getAuthorName() != null ? book.getAuthorName() : "") + "</td>");
                out.println("<td>" + (book.getCategoryName() != null ? book.getCategoryName() : "") + "</td>");
                out.println("<td>" + (book.getPublisherName() != null ? book.getPublisherName() : "") + "</td>");
                out.println("<td>" + book.getPublicationYear() + "</td>");
                out.println("<td>" + book.getPrice() + "</td>");
                out.println("<td>" + book.getStock() + "</td>");
                out.println("</tr>");
            }
            
            out.println("</table>");
            out.println("</body>");
            out.println("</html>");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi xuất file Excel: " + e.getMessage());
            response.sendRedirect("staff-dashboard?action=books");
        }
    }
}
