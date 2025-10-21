package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Book;

public class WishlistDAO {

    /**
     * Thêm một sản phẩm vào danh sách yêu thích của người dùng.
     * Chỉ thêm nếu sản phẩm đó chưa tồn tại trong danh sách.
     * @param accountId ID của người dùng.
     * @param bookId ID của sách.
     */
    public void addToWishlist(int accountId, int bookId) {
        String getWishlistIdQuery = "SELECT id FROM wishlist WHERE u_id = ?";
        String checkItemQuery = "SELECT * FROM wishlist_items WHERE wishlist_id = ? AND b_id = ?";
        String insertItemQuery = "INSERT INTO wishlist_items (wishlist_id, b_id) VALUES (?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Bước 1: Lấy wishlist_id của người dùng
            int wishlistId = -1;
            ps = conn.prepareStatement(getWishlistIdQuery);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            if (rs.next()) {
                wishlistId = rs.getInt("id");
            }
            // Giả sử mỗi user luôn có một wishlist.

            if (wishlistId != -1) {
                // Bước 2: Kiểm tra sách đã có trong wishlist chưa
                ps.close();
                rs.close();
                ps = conn.prepareStatement(checkItemQuery);
                ps.setInt(1, wishlistId);
                ps.setInt(2, bookId);
                rs = ps.executeQuery();

                if (!rs.next()) { // Nếu sản phẩm chưa có
                    // Bước 3: Thêm mới
                    ps.close();
                    ps = conn.prepareStatement(insertItemQuery);
                    ps.setInt(1, wishlistId);
                    ps.setInt(2, bookId);
                    ps.executeUpdate();
                }
                // Nếu đã có rồi thì không làm gì cả
            }
            conn.commit();
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Đóng các kết nối
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    /**
     * Lấy danh sách sản phẩm trong wishlist của người dùng.
     * @param accountId ID của người dùng.
     * @return Danh sách các đối tượng Book.
     */
    public List<Book> getWishlistItems(int accountId) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name as authorName "
                + "FROM wishlist w "
                + "JOIN wishlist_items wi ON w.id = wi.wishlist_id "
                + "JOIN books b ON wi.b_id = b.b_id "
                + "JOIN authors a ON b.a_id = a.id "
                + "WHERE w.u_id = ?";
        
        // Code truy vấn và trả về List<Book> tương tự như getCartItems
        // ...

        return bookList;
    }
}