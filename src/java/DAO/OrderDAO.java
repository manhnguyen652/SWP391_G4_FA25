package DAO;

import model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<Order> getAllOrders(int page, int recordsPerPage) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, a.f_name, a.l_name, s.name as status_name " +
                    "FROM [order] o " +
                    "JOIN account a ON o.u_id = a.u_id " +
                    "JOIN status s ON o.status_id = s.id " +
                    "ORDER BY o.id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * recordsPerPage);
            ps.setInt(2, recordsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setU_id(rs.getInt("u_id"));
                order.setTotal_amount(rs.getDouble("total_amount"));
                order.setCreate_date(rs.getTimestamp("create_date"));
                order.setStatus_id(rs.getInt("status_id"));
                order.setCustomerName(rs.getString("f_name") + " " + rs.getString("l_name"));
                order.setStatusName(rs.getString("status_name"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " o.*, a.f_name, a.l_name, s.name as status_name " +
                    "FROM [order] o " +
                    "JOIN account a ON o.u_id = a.u_id " +
                    "JOIN status s ON o.status_id = s.id " +
                    "ORDER BY o.create_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setU_id(rs.getInt("u_id"));
                order.setTotal_amount(rs.getDouble("total_amount"));
                order.setCreate_date(rs.getTimestamp("create_date"));
                order.setStatus_id(rs.getInt("status_id"));
                order.setCustomerName(rs.getString("f_name") + " " + rs.getString("l_name"));
                order.setStatusName(rs.getString("status_name"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM [order]";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalRevenue() {
        String sql = "SELECT ISNULL(SUM(total_amount), 0) FROM [order] WHERE status_id = 4"; // Đã giao hàng
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public boolean updateOrderStatus(int orderId, int statusId) {
        String sql = "UPDATE [order] SET status_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, statusId);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Object[]> getMonthlyStatistics() {
        List<Object[]> stats = new ArrayList<>();
        String sql = "SELECT YEAR(create_date) as year, MONTH(create_date) as month, " +
                    "COUNT(*) as order_count, SUM(total_amount) as revenue " +
                    "FROM [order] " +
                    "WHERE status_id = 4 " +
                    "GROUP BY YEAR(create_date), MONTH(create_date) " +
                    "ORDER BY year DESC, month DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Object[] stat = new Object[4];
                stat[0] = rs.getInt("year");
                stat[1] = rs.getInt("month");
                stat[2] = rs.getInt("order_count");
                stat[3] = rs.getDouble("revenue");
                stats.add(stat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, a.f_name, a.l_name, a.u_email, s.name as status_name " +
                    "FROM [order] o " +
                    "JOIN account a ON o.u_id = a.u_id " +
                    "JOIN status s ON o.status_id = s.id " +
                    "WHERE o.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setU_id(rs.getInt("u_id"));
                order.setTotal_amount(rs.getDouble("total_amount"));
                order.setCreate_date(rs.getTimestamp("create_date"));
                order.setStatus_id(rs.getInt("status_id"));
                order.setCustomerName(rs.getString("f_name") + " " + rs.getString("l_name"));
                order.setCustomerEmail(rs.getString("u_email"));
                order.setStatusName(rs.getString("status_name"));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Object[]> getOrderDetails(int orderId) {
        List<Object[]> orderDetails = new ArrayList<>();
        String sql = "SELECT od.*, b.b_title, b.price, od.quantity, od.price_per_item " +
                    "FROM order_details od " +
                    "JOIN books b ON od.b_id = b.b_id " +
                    "WHERE od.order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Object[] detail = new Object[5];
                detail[0] = rs.getInt("b_id");
                detail[1] = rs.getString("b_title");
                detail[2] = rs.getInt("quantity");
                detail[3] = rs.getDouble("price_per_item");
                detail[4] = rs.getDouble("quantity") * rs.getDouble("price_per_item");
                orderDetails.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public List<Object[]> getAllStatuses() {
        List<Object[]> statuses = new ArrayList<>();
        String sql = "SELECT id, name FROM status ORDER BY id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Object[] status = new Object[2];
                status[0] = rs.getInt("id");
                status[1] = rs.getString("name");
                statuses.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statuses;
    }

    public List<Order> searchOrders(String searchTerm, int page, int recordsPerPage) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, a.f_name, a.l_name, s.name as status_name " +
                    "FROM [order] o " +
                    "JOIN account a ON o.u_id = a.u_id " +
                    "JOIN status s ON o.status_id = s.id " +
                    "WHERE (a.f_name LIKE ? OR a.l_name LIKE ? OR a.u_email LIKE ? OR o.id LIKE ?) " +
                    "ORDER BY o.id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            ps.setInt(5, (page - 1) * recordsPerPage);
            ps.setInt(6, recordsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setU_id(rs.getInt("u_id"));
                order.setTotal_amount(rs.getDouble("total_amount"));
                order.setCreate_date(rs.getTimestamp("create_date"));
                order.setStatus_id(rs.getInt("status_id"));
                order.setCustomerName(rs.getString("f_name") + " " + rs.getString("l_name"));
                order.setStatusName(rs.getString("status_name"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getTotalSearchOrders(String searchTerm) {
        String sql = "SELECT COUNT(*) FROM [order] o " +
                    "JOIN account a ON o.u_id = a.u_id " +
                    "WHERE (a.f_name LIKE ? OR a.l_name LIKE ? OR a.u_email LIKE ? OR o.id LIKE ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getOrdersByStatus(int statusId) {
        String sql = "SELECT COUNT(*) FROM [order] WHERE status_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, statusId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTodayOrders() {
        String sql = "SELECT COUNT(*) FROM [order] WHERE CAST(create_date AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTodayRevenue() {
        String sql = "SELECT ISNULL(SUM(total_amount), 0) FROM [order] WHERE status_id = 4 AND CAST(create_date AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}
