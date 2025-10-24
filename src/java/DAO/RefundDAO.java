//package DAO;
//
//import model.Refund;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Timestamp;
//import java.util.ArrayList;
//import java.util.List;
//
//public class RefundDAO {
//    
//    public boolean createRefund(Refund refund) {
//        String sql = "INSERT INTO refunds (order_id, user_id, amount, reason, status, request_date) VALUES (?, ?, ?, ?, ?, ?)";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, refund.getOrderId());
//            ps.setInt(2, refund.getUserId());
//            ps.setDouble(3, refund.getAmount());
//            ps.setString(4, refund.getReason());
//            ps.setString(5, refund.getStatus());
//            ps.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
//            return ps.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//    
//    public List<Refund> getAllRefunds(int page, int recordsPerPage) {
//        List<Refund> refunds = new ArrayList<>();
//        String sql = "SELECT r.*, a.f_name, a.l_name, o.total_amount " +
//                    "FROM refunds r " +
//                    "JOIN account a ON r.user_id = a.u_id " +
//                    "JOIN [order] o ON r.order_id = o.id " +
//                    "ORDER BY r.request_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, (page - 1) * recordsPerPage);
//            ps.setInt(2, recordsPerPage);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Refund refund = mapResultSetToRefund(rs);
//                refunds.add(refund);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return refunds;
//    }
//    
//    public Refund getRefundById(int refundId) {
//        String sql = "SELECT r.*, a.f_name, a.l_name, a.u_email, o.total_amount, o.create_date as order_date " +
//                    "FROM refunds r " +
//                    "JOIN account a ON r.user_id = a.u_id " +
//                    "JOIN [order] o ON r.order_id = o.id " +
//                    "WHERE r.id = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, refundId);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                Refund refund = mapResultSetToRefund(rs);
//                // Thêm thông tin bổ sung
//                refund.setCustomerName(rs.getString("f_name") + " " + rs.getString("l_name"));
//                refund.setCustomerEmail(rs.getString("u_email"));
//                refund.setOrderAmount(rs.getDouble("total_amount"));
//                refund.setOrderDate(rs.getTimestamp("order_date"));
//                return refund;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//    
//    public List<Refund> getRefundsByOrderId(int orderId) {
//        List<Refund> refunds = new ArrayList<>();
//        String sql = "SELECT r.*, a.f_name, a.l_name, o.total_amount " +
//                    "FROM refunds r " +
//                    "JOIN account a ON r.user_id = a.u_id " +
//                    "JOIN [order] o ON r.order_id = o.id " +
//                    "WHERE r.order_id = ? ORDER BY r.request_date DESC";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, orderId);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Refund refund = mapResultSetToRefund(rs);
//                refunds.add(refund);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return refunds;
//    }
//    
//    public boolean updateRefundStatus(int refundId, String status, String processedBy, String notes) {
//        String sql = "UPDATE refunds SET status = ?, process_date = ?, processed_by = ?, notes = ? WHERE id = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setString(1, status);
//            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
//            ps.setString(3, processedBy);
//            ps.setString(4, notes);
//            ps.setInt(5, refundId);
//            return ps.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//    
//    public int getTotalRefunds() {
//        String sql = "SELECT COUNT(*) FROM refunds";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//    
//    public int getRefundsByStatus(String status) {
//        String sql = "SELECT COUNT(*) FROM refunds WHERE status = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setString(1, status);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//    
//    public double getTotalRefundAmount() {
//        String sql = "SELECT ISNULL(SUM(amount), 0) FROM refunds WHERE status = 'COMPLETED'";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return rs.getDouble(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return 0.0;
//    }
//    
//    public List<Refund> searchRefunds(String searchTerm, int page, int recordsPerPage) {
//        List<Refund> refunds = new ArrayList<>();
//        String sql = "SELECT r.*, a.f_name, a.l_name, o.total_amount " +
//                    "FROM refunds r " +
//                    "JOIN account a ON r.user_id = a.u_id " +
//                    "JOIN [order] o ON r.order_id = o.id " +
//                    "WHERE (a.f_name LIKE ? OR a.l_name LIKE ? OR a.u_email LIKE ? OR r.id LIKE ? OR o.id LIKE ?) " +
//                    "ORDER BY r.request_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            String searchPattern = "%" + searchTerm + "%";
//            ps.setString(1, searchPattern);
//            ps.setString(2, searchPattern);
//            ps.setString(3, searchPattern);
//            ps.setString(4, searchPattern);
//            ps.setString(5, searchPattern);
//            ps.setInt(6, (page - 1) * recordsPerPage);
//            ps.setInt(7, recordsPerPage);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Refund refund = mapResultSetToRefund(rs);
//                refunds.add(refund);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return refunds;
//    }
//    
//    public int getTotalSearchRefunds(String searchTerm) {
//        String sql = "SELECT COUNT(*) FROM refunds r " +
//                    "JOIN account a ON r.user_id = a.u_id " +
//                    "JOIN [order] o ON r.order_id = o.id " +
//                    "WHERE (a.f_name LIKE ? OR a.l_name LIKE ? OR a.u_email LIKE ? OR r.id LIKE ? OR o.id LIKE ?)";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//            String searchPattern = "%" + searchTerm + "%";
//            ps.setString(1, searchPattern);
//            ps.setString(2, searchPattern);
//            ps.setString(3, searchPattern);
//            ps.setString(4, searchPattern);
//            ps.setString(5, searchPattern);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
//    
//    private Refund mapResultSetToRefund(ResultSet rs) throws SQLException {
//        Refund refund = new Refund();
//        refund.setId(rs.getInt("id"));
//        refund.setOrderId(rs.getInt("order_id"));
//        refund.setUserId(rs.getInt("user_id"));
//        refund.setAmount(rs.getDouble("amount"));
//        refund.setReason(rs.getString("reason"));
//        refund.setStatus(rs.getString("status"));
//        refund.setRequestDate(rs.getTimestamp("request_date"));
//        refund.setProcessDate(rs.getTimestamp("process_date"));
//        refund.setProcessedBy(rs.getString("processed_by"));
//        refund.setNotes(rs.getString("notes"));
//        return refund;
//    }
//}
