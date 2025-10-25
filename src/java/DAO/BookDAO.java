package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Book;
import model.CartItem;

public class BookDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<Book> getAllBooks() {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id";

        try {

            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
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
                bookList.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookList;
    }

    public Book getBookById(int id) {
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "WHERE b.b_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
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
                return book;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public int getTotalBooks() {
        String query = "SELECT count(*) FROM books";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng kết nối
        }
        return 0;
    }

    public List<Book> getBooksByPage(int pageNumber, int pageSize) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b INNER JOIN authors a ON b.a_id = a.id "
                + "ORDER BY b.b_id " // Cần ORDER BY để phân trang chính xác
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            // Tính toán offset
            int offset = (pageNumber - 1) * pageSize;
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);

            rs = ps.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                // ... (set các thuộc tính cho book như trong phương thức getAllBooks)
                book.setBId(rs.getInt("b_id"));
                book.setBTitle(rs.getString("b_title"));
                book.setPrice(rs.getDouble("price"));
                book.setAuthorName(rs.getString("authorName"));
                // ... set các thuộc tính còn lại
                bookList.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng kết nối
        }
        return bookList;
    }

    public void addToCart(int accountId, int bookId, int quantity) {

        String getCartIdQuery = "SELECT id FROM cart WHERE u_id = ?";
        String checkItemQuery = "SELECT * FROM cart_items WHERE cart_id = ? AND b_id = ?";
        String updateQuantityQuery = "UPDATE cart_items SET quantity = quantity + ? WHERE cart_id = ? AND b_id = ?";
        String insertItemQuery = "INSERT INTO cart_items (cart_id, b_id, quantity) VALUES (?, ?, ?)";

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int cartId = -1;
            ps = conn.prepareStatement(getCartIdQuery);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            if (rs.next()) {
                cartId = rs.getInt("id");
            }

            if (cartId != -1) {
                // Bước 2
                ps = conn.prepareStatement(checkItemQuery);
                ps.setInt(1, cartId);
                ps.setInt(2, bookId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    ps = conn.prepareStatement(updateQuantityQuery);
                    ps.setInt(1, quantity);
                    ps.setInt(2, cartId);
                    ps.setInt(3, bookId);
                    ps.executeUpdate();
                } else {

                    ps = conn.prepareStatement(insertItemQuery);
                    ps.setInt(1, cartId);
                    ps.setInt(2, bookId);
                    ps.setInt(3, quantity);
                    ps.executeUpdate();
                }
            }
            conn.commit();
        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {

        }
    }

    public List<Book> searchBooks(String searchQuery, int pageNumber, int pageSize) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN publishers p ON b.p_id = p.id " // JOIN thêm bảng publishers
                + "WHERE b.b_title LIKE ? OR a.name LIKE ? OR p.name LIKE ? " // Điều kiện tìm kiếm
                + "ORDER BY b.b_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        int offset = (pageNumber - 1) * pageSize;

        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            String searchPattern = "%" + searchQuery + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setInt(4, offset);
            ps.setInt(5, pageSize);

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
                bookList.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookList;
    }

    /**
     * MỚI: Lấy tổng số sách tìm thấy dựa trên từ khóa.
     */
    public int getTotalSearchBooks(String searchQuery) {
        String query = "SELECT count(*) "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN publishers p ON b.p_id = p.id " // JOIN thêm bảng publishers
                + "WHERE b.b_title LIKE ? OR a.name LIKE ? OR p.name LIKE ?";

        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            String searchPattern = "%" + searchQuery + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return 0;
    }
//    public static void main(String[] args) {
//        BookDAO bookDAO = new BookDAO();
//        Book bookList = bookDAO.getBookById(1);
//        if (bookList==null) {
//            System.out.println("Không tìm thấy cuốn sách nào.");
//        } else {
//            System.out.println("Đã tìm thấy " + " cuốn sách. Đang kiểm tra title...");
//            
//                System.out.println(bookList.toString());
//            
//        }
//    }
}
