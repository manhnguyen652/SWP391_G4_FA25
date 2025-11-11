package Controllers;

import DAO.BookDAO;
import DAO.CategoryDAO;
import DAO.OrderDAO;
import DAO.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import com.google.gson.Gson;

@WebServlet(name = "StatisticsAPI", urlPatterns = {"/statistics-api"})
public class StatisticsAPI extends HttpServlet {
    
    private OrderDAO orderDAO = new OrderDAO();
    private BookDAO bookDAO = new BookDAO();
    // private CategoryDAO categoryDAO = new CategoryDAO(); // Will be used later
    private AccountDAO accountDAO = new AccountDAO();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        PrintWriter out = response.getWriter();
        
        try {
            switch (action) {
                case "revenue":
                    getRevenueData(out);
                    break;
                case "orderStatus":
                    getOrderStatusData(out);
                    break;
                case "categoryStats":
                    getCategoryStatsData(out);
                    break;
                case "userStats":
                    getUserStatsData(out);
                    break;
                case "bookStats":
                    getBookStatsData(out);
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"error\": \"Invalid action\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
    
    private void getRevenueData(PrintWriter out) {
        // Dữ liệu doanh thu theo tháng (có thể thay thế bằng dữ liệu thực từ database)
        List<Map<String, Object>> revenueData = new ArrayList<>();
        
        String[] months = {"Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", 
                          "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"};
        
        // Dữ liệu mẫu - có thể thay thế bằng query thực từ database
        double[] revenues = {12000000, 19000000, 15000000, 25000000, 22000000, 30000000, 
                           28000000, 35000000, 32000000, 40000000, 38000000, 45000000};
        
        for (int i = 0; i < months.length; i++) {
            Map<String, Object> monthData = new HashMap<>();
            monthData.put("month", months[i]);
            monthData.put("revenue", revenues[i]);
            revenueData.add(monthData);
        }
        
        out.print(gson.toJson(revenueData));
    }
    
    private void getOrderStatusData(PrintWriter out) {
        // Lấy dữ liệu trạng thái đơn hàng thực từ database
        Map<String, Integer> statusData = new HashMap<>();
        
        try {
            // Đếm số đơn hàng theo từng trạng thái
            statusData.put("pending", orderDAO.getOrdersByStatus(1));
            statusData.put("confirmed", orderDAO.getOrdersByStatus(2));
            statusData.put("shipping", orderDAO.getOrdersByStatus(3));
            statusData.put("completed", orderDAO.getOrdersByStatus(4));
            statusData.put("cancelled", orderDAO.getOrdersByStatus(5));
            
            // Tạo response với labels và data
            Map<String, Object> response = new HashMap<>();
            response.put("labels", new String[]{"Chờ xử lý", "Đã xác nhận", "Đang giao", "Hoàn thành", "Đã hủy"});
            response.put("data", new int[]{
                statusData.get("pending"),
                statusData.get("confirmed"),
                statusData.get("shipping"),
                statusData.get("completed"),
                statusData.get("cancelled")
            });
            
            out.print(gson.toJson(response));
        } catch (Exception e) {
            // Fallback data nếu có lỗi
            Map<String, Object> response = new HashMap<>();
            response.put("labels", new String[]{"Chờ xử lý", "Đã xác nhận", "Đang giao", "Hoàn thành", "Đã hủy"});
            response.put("data", new int[]{12, 19, 8, 45, 6});
            out.print(gson.toJson(response));
        }
    }
    
    private void getCategoryStatsData(PrintWriter out) {
        try {
            List<Object[]> categoryStats = bookDAO.getCategoryStatistics();
            List<Map<String, Object>> response = new ArrayList<>();
            
            for (Object[] stat : categoryStats) {
                Map<String, Object> categoryData = new HashMap<>();
                categoryData.put("category", stat[0]);
                categoryData.put("bookCount", stat[1]);
                categoryData.put("totalSold", stat[2]);
                response.add(categoryData);
            }
            
            out.print(gson.toJson(response));
        } catch (Exception e) {
            out.print("[]");
        }
    }
    
    private void getUserStatsData(PrintWriter out) {
        try {
            Map<String, Object> userStats = new HashMap<>();
            userStats.put("totalUsers", accountDAO.getTotalUsers());
            userStats.put("verifiedUsers", accountDAO.getVerifiedUsersCount());
            userStats.put("newUsersToday", accountDAO.getNewUsersTodayCount());
            
            out.print(gson.toJson(userStats));
        } catch (Exception e) {
            out.print("{}");
        }
    }
    
    private void getBookStatsData(PrintWriter out) {
        try {
            Map<String, Object> bookStats = new HashMap<>();
            bookStats.put("totalBooks", bookDAO.getTotalBooks());
            bookStats.put("lowStockBooks", bookDAO.getLowStockBooksCount());
            bookStats.put("outOfStockBooks", bookDAO.getOutOfStockBooksCount());
            
            out.print(gson.toJson(bookStats));
        } catch (Exception e) {
            out.print("{}");
        }
    }
}
