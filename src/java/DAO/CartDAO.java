package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import model.Book;
import model.CartItem;

public class CartDAO {

    public void addToCart(int accountId, int bookId, int quantity) {
        String getCartIdQuery = "SELECT id FROM cart WHERE u_id = ?";
        String checkItemQuery = "SELECT * FROM cart_items WHERE cart_id = ? AND b_id = ?";
        String updateQuantityQuery = "UPDATE cart_items SET quantity = quantity + ? WHERE cart_id = ? AND b_id = ?";
        String insertItemQuery = "INSERT INTO cart_items (cart_id, b_id, quantity) VALUES (?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Bước 1: Lấy cart_id của người dùng
            int cartId = -1;
            ps = conn.prepareStatement(getCartIdQuery);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            if (rs.next()) {
                cartId = rs.getInt("id");
            }
            // Lưu ý: Cần có sẵn cart cho mỗi user. Nếu không, bạn cần thêm logic tạo cart.

            if (cartId != -1) {
                // Bước 2: Kiểm tra sách đã có trong giỏ chưa
                ps.close(); // Đóng PreparedStatement cũ
                rs.close(); // Đóng ResultSet cũ
                
                ps = conn.prepareStatement(checkItemQuery);
                ps.setInt(1, cartId);
                ps.setInt(2, bookId);
                rs = ps.executeQuery();
                
                if (rs.next()) { // Sản phẩm đã có
                    // Bước 3a: Cập nhật số lượng
                    ps.close();
                    ps = conn.prepareStatement(updateQuantityQuery);
                    ps.setInt(1, quantity);
                    ps.setInt(2, cartId);
                    ps.setInt(3, bookId);
                    ps.executeUpdate();
                } else { // Sản phẩm chưa có
                    // Bước 3b: Thêm mới
                    ps.close();
                    ps = conn.prepareStatement(insertItemQuery);
                    ps.setInt(1, cartId);
                    ps.setInt(2, bookId);
                    ps.setInt(3, quantity);
                    ps.executeUpdate();
                }
            }
            conn.commit(); // Hoàn tất và lưu thay đổi vào DB
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback(); // Hoàn tác nếu có lỗi
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // **QUAN TRỌNG: LUÔN ĐÓNG KẾT NỐI**
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
    public Map<CartItem, Book> getCartItemsByAccountId(int accountId) {
        Map<CartItem, Book> cartMap = new HashMap<>();
        String query = "SELECT ci.id as cart_item_id, ci.cart_id, ci.b_id, ci.quantity, b.b_title, b.price "
                + "FROM cart c "
                + "JOIN cart_items ci ON c.id = ci.cart_id "
                + "JOIN books b ON ci.b_id = b.b_id "
                + "WHERE c.u_id = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();

            while (rs.next()) {
                // Tạo đối tượng CartItem
                CartItem item = new CartItem();
                item.setId(rs.getInt("cart_item_id"));
                item.setCartId(rs.getInt("cart_id"));
                item.setBId(rs.getInt("b_id"));
                item.setQuantity(rs.getInt("quantity"));

                // Tạo đối tượng Book
                Book book = new Book();
                book.setBId(rs.getInt("b_id"));
                book.setBTitle(rs.getString("b_title"));
                book.setPrice(rs.getDouble("price"));
                // Bạn có thể set thêm các thuộc tính khác của Book nếu cần

                // Đưa cặp CartItem và Book vào Map
                cartMap.put(item, book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng các kết nối...
        }
        return cartMap;
    }
}