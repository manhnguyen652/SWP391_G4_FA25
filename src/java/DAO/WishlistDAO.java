package DAO;

import model.Book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement; // Needed for RETURN_GENERATED_KEYS if auto-creating wishlist
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    /**
     * Gets the wishlist ID for a given user ID.
     * Assumes each user has one wishlist record. Creates one if not found (OPTIONAL - uncomment if needed).
     */
    private int getWishlistId(int accountId, Connection connection) throws SQLException {
        int wishlistId = -1;
        // Adjust table and column names if different
        String findWishlistQuery = "SELECT id FROM wishlist WHERE u_id = ?";
        // String createWishlistQuery = "INSERT INTO wishlist (u_id) VALUES (?)"; // For auto-creation

        PreparedStatement findPs = null;
        ResultSet findRs = null;

        try {
            findPs = connection.prepareStatement(findWishlistQuery);
            findPs.setInt(1, accountId);
            findRs = findPs.executeQuery();

            if (findRs.next()) {
                wishlistId = findRs.getInt("id");
            } else {
                // --- OPTIONAL: Auto-create wishlist ---
                /*
                System.out.println("Wishlist not found for user " + accountId + ", attempting to create.");
                findPs.close(); // Close previous resources
                findRs.close();

                PreparedStatement createPs = connection.prepareStatement(createWishlistQuery, Statement.RETURN_GENERATED_KEYS);
                createPs.setInt(1, accountId);
                int affectedRows = createPs.executeUpdate();

                if (affectedRows > 0) {
                    ResultSet generatedKeys = createPs.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        wishlistId = generatedKeys.getInt(1);
                        System.out.println("Created new wishlist with ID: " + wishlistId);
                    } else {
                         throw new SQLException("Creating wishlist failed, no ID obtained.");
                    }
                     if (generatedKeys != null) generatedKeys.close();
                } else {
                     throw new SQLException("Creating wishlist failed, no rows affected.");
                }
                if (createPs != null) createPs.close();
                */
                // --- END OPTIONAL ---

                // If not auto-creating:
                 System.err.println("Wishlist not found for user: " + accountId);
                 throw new SQLException("Wishlist not found for user " + accountId + ".");

            }
        } finally {
             // Close resources used within this method
            if (findRs != null) try { findRs.close(); } catch (SQLException e) { /* ignore */ }
            if (findPs != null) try { findPs.close(); } catch (SQLException e) { /* ignore */ }
        }
        return wishlistId;
    }


    /**
     * Thêm sách vào danh sách yêu thích của người dùng (using wishlist_items table).
     */
    public void addToWishlist(int accountId, int bookId) {
        // Adjust table and column names if different
        String checkQuery = "SELECT COUNT(*) FROM wishlist_items WHERE wishlist_id = ? AND b_id = ?";
        String insertQuery = "INSERT INTO wishlist_items (wishlist_id, b_id) VALUES (?, ?)";

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            int wishlistId = getWishlistId(accountId, conn); // Get wishlist ID

            // Check if the book already exists
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, wishlistId);
            ps.setInt(2, bookId);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) == 0) { // If count is 0, item does not exist
                closeResultSetAndStatement(); // Close before reusing ps

                // Insert into wishlist_items
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, wishlistId);
                ps.setInt(2, bookId);
                ps.executeUpdate();
                conn.commit(); // Commit transaction
                System.out.println("Book (ID: " + bookId + ") added to wishlist (ID: " + wishlistId + ").");
            } else {
                conn.rollback(); // Rollback if item already exists
                System.out.println("Book (ID: " + bookId + ") already in wishlist (ID: " + wishlistId + ") or error checking.");
            }

        } catch (SQLException e) {
            System.err.println("Error adding to wishlist: " + e.getMessage());
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            // Consider re-throwing a custom exception
        } finally {
            closeResources(); // Close conn, ps, rs used in this method scope
        }
    }

    /**
     * Lấy danh sách các sách trong wishlist của người dùng (using wishlist_items).
     */
    public List<Book> getWishlistItems(int accountId) {
        List<Book> wishlistItems = new ArrayList<>();
        // Adjust table/column names as needed (b_id, a_id, id)
        String query = "SELECT wi.id as wishlist_item_id, b.*, a.name AS authorName " +
                       "FROM wishlist w " +
                       "JOIN wishlist_items wi ON w.id = wi.wishlist_id " +
                       "JOIN books b ON wi.b_id = b.b_id " + // Make sure book primary key is b_id
                       "JOIN authors a ON b.a_id = a.id " +   // Make sure author foreign key is a_id and primary key is id
                       "WHERE w.u_id = ?";

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                // Populate Book object from ResultSet
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

                // Set the ID from the wishlist_items table
                book.setWishlistItemId(rs.getInt("wishlist_item_id"));

                wishlistItems.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Error getting wishlist items: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return wishlistItems;
    }

     /**
     * Xóa một mục khỏi danh sách yêu thích dựa trên ID của mục wishlist_items.
     */
    public void removeFromWishlist(int wishlistItemId) {
        // Adjust table name if different
        String query = "DELETE FROM wishlist_items WHERE id = ?"; // 'id' is pk of wishlist_items

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, wishlistItemId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                 System.out.println("Item (ID: " + wishlistItemId + ") removed from wishlist items.");
            } else {
                 System.out.println("Wishlist item (ID: " + wishlistItemId + ") not found or error removing.");
            }
        } catch (SQLException e) {
             System.err.println("Error removing from wishlist items: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // Helper to close ResultSet and PreparedStatement
    private void closeResultSetAndStatement() {
         if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignore */ }
         if (ps != null) try { ps.close(); } catch (SQLException e) { /* ignore */ }
         rs = null; // Reset references
         ps = null;
    }

    // Helper to close all resources
    private void closeResources() {
        closeResultSetAndStatement(); // Close rs and ps first
        if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignore */ }
        conn = null; // Reset reference
    }
}