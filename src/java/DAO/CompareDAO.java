package DAO;

import model.Book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CompareDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private static final int MAX_COMPARE_ITEMS = 3;

    private int getCompareId(int accountId, Connection connection) throws SQLException {
        int compareId = -1; // Mặc định là -1 (không tìm thấy)
        String findCompareQuery = "SELECT id FROM compare WHERE u_id = ?";

        PreparedStatement findPs = null;
        ResultSet findRs = null;
        try {
            findPs = connection.prepareStatement(findCompareQuery);
            findPs.setInt(1, accountId);
            findRs = findPs.executeQuery();

            if (findRs.next()) {
                compareId = findRs.getInt("id");
            } else {
                System.out.println("CompareDAO: Compare list not found for user: " + accountId + ". Returning -1."); // Log thông tin
            }
        } finally {
            if (findRs != null) try { findRs.close(); } catch (SQLException e) { /* ignore */ }
            if (findPs != null) try { findPs.close(); } catch (SQLException e) { /* ignore */ }
        }
        return compareId; // Trả về -1 nếu không tìm thấy
    }

    public int getCompareItemCount(int accountId) {
        int count = 0;
        String countItemsQuery = "SELECT COUNT(id) FROM compare_items WHERE compare_id = ?";

        try {
            conn = DBConnection.getConnection();
            int compareId = getCompareId(accountId, conn); // Lấy compareId

            if (compareId != -1) { // Chỉ đếm nếu có compare list
                 ps = conn.prepareStatement(countItemsQuery);
                 ps.setInt(1, compareId);
                 rs = ps.executeQuery();
                 if (rs.next()) {
                     count = rs.getInt(1);
                 }
            } else {
                // Nếu compareId là -1, count mặc định là 0
                System.out.println("CompareDAO: No compare list for user " + accountId + ", item count is 0.");
            }

        } catch (SQLException e) {
            System.err.println("CompareDAO: Error counting compare items for user " + accountId + ": " + e.getMessage());
            e.printStackTrace();
            count = 0; // Trả về 0 nếu có lỗi
        } finally {
            closeResources();
        }
        return count;
    }

     public boolean addToCompare(int accountId, int bookId) {
        String checkQuery = "SELECT COUNT(*) FROM compare_items WHERE compare_id = ? AND b_id = ?";
        String insertQuery = "INSERT INTO compare_items (compare_id, b_id) VALUES (?, ?)";
        String countItemsQuery = "SELECT COUNT(id) FROM compare_items WHERE compare_id = ?";
        boolean added = false;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int compareId = getCompareId(accountId, conn); // Lấy compareId

            if (compareId == -1) {
                 System.err.println("CompareDAO: Cannot add item, Compare list not found for user: " + accountId);
                 conn.rollback(); // Không cần rollback vì chưa làm gì, nhưng để cho chắc
                 return false; // Thất bại vì không có compare list
            }


             ps = conn.prepareStatement(countItemsQuery);
             ps.setInt(1, compareId);
             rs = ps.executeQuery();
             int currentCount = 0;
             if (rs.next()) {
                 currentCount = rs.getInt(1);
             }
             closeResultSetAndStatement();

            if (currentCount >= MAX_COMPARE_ITEMS) {
                System.out.println("CompareDAO: Compare list full for compareId " + compareId + ". Cannot add Book ID: " + bookId);
                conn.rollback();
                return false;
            }

            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, compareId);
            ps.setInt(2, bookId);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) == 0) {
                closeResultSetAndStatement();

                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, compareId);
                ps.setInt(2, bookId);
                ps.executeUpdate();
                conn.commit();
                System.out.println("CompareDAO: Book (ID: " + bookId + ") added to compare list (ID: " + compareId + ").");
                added = true;
            } else {
                conn.rollback();
                System.out.println("CompareDAO: Book (ID: " + bookId + ") already in compare list (ID: " + compareId + ").");
                added = false;
            }

        } catch (SQLException e) {
            System.err.println("CompareDAO: Error adding Book ID " + bookId + " for user " + accountId + ": " + e.getMessage());
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            added = false;
        } finally {
            closeResources();
        }
        return added;
    }


    public List<Book> getCompareItems(int accountId) {
        List<Book> compareItems = new ArrayList<>();
        // *** SỬA CÂU QUERY NÀY ***
        String query = "SELECT ci.id as compare_item_id, b.*, a.name AS authorName " +
                       "FROM compare_items ci " + // Bắt đầu từ compare_items
                       "JOIN books b ON ci.b_id = b.b_id " +
                       "JOIN authors a ON b.a_id = a.id " +
                       "WHERE ci.compare_id = ?"; // Lọc theo compare_id

        try {
            conn = DBConnection.getConnection();
            int compareId = getCompareId(accountId, conn); // Lấy compareId trước

            if (compareId == -1) { // Nếu user không có compare list
                 System.out.println("CompareDAO: No compare list found for user " + accountId + ". Returning empty compare items list.");
                 return compareItems; // Trả về danh sách rỗng
            }

            // Chỉ chạy query nếu có compareId hợp lệ
            ps = conn.prepareStatement(query);
            ps.setInt(1, compareId); // Dùng compareId đã lấy
            rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setBId(rs.getInt("b_id"));
                book.setBTitle(rs.getString("b_title"));
                book.setDescription(rs.getString("description"));
                book.setPublicationYear(rs.getInt("publication_year"));
                book.setPrice(rs.getDouble("price"));
                book.setStock(rs.getInt("stock"));
                book.setPId(rs.getInt("p_id"));
                book.setAId(rs.getInt("a_id"));
                book.setImageId(rs.getInt("image_id"));
                book.setCId(rs.getInt("c_id"));
                book.setAuthorName(rs.getString("authorName"));
                book.setCompareItemId(rs.getInt("compare_item_id"));
                compareItems.add(book);
            }
        } catch (SQLException e) {
            System.err.println("CompareDAO: Error getting compare items for user " + accountId + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return compareItems;
    }

    public void removeFromCompare(int compareItemId) {
        String query = "DELETE FROM compare_items WHERE id = ?";

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, compareItemId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                 System.out.println("CompareDAO: Item (ID: " + compareItemId + ") removed from compare items.");
            } else {
                 System.out.println("CompareDAO: Compare item (ID: " + compareItemId + ") not found or error removing.");
            }
        } catch (SQLException e) {
             System.err.println("CompareDAO: Error removing compare item (ID: " + compareItemId + "): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    private void closeResultSetAndStatement() {
         if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignore */ }
         if (ps != null) try { ps.close(); } catch (SQLException e) { /* ignore */ }
         rs = null; ps = null;
    }

    private void closeResources() {
        closeResultSetAndStatement();
        if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignore */ }
        conn = null;
    }
}