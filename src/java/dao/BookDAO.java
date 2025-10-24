package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Book;

public class BookDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Book> getAllBooks() {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id";

        try {

            conn = DBConnection.getConnection();
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
    
    public List<Book> getAllBooks(int page, int recordsPerPage) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "ORDER BY b.b_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, (page - 1) * recordsPerPage);
            ps.setInt(2, recordsPerPage);
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
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookList;
    }

    public List<Book> getTopSellingBooks(int limit) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT TOP " + limit + " b.*, a.name AS authorName, SUM(od.quantity) as total_sold "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN order_details od ON b.b_id = od.b_id "
                + "INNER JOIN [order] o ON od.order_id = o.id "
                + "WHERE o.status_id = 4 "
                + "GROUP BY b.b_id, b.b_title, b.description, b.publication_year, b.price, b.stock, b.p_id, b.a_id, b.image_id, b.c_id, a.name "
                + "ORDER BY total_sold DESC";

        try {
            conn = DBConnection.getConnection();
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
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookList;
    }

    public boolean updateBookStock(int bookId, int newStock) {
        String query = "UPDATE books SET stock = ? WHERE b_id = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newStock);
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Object[]> getCategoryStatistics() {
        List<Object[]> stats = new ArrayList<>();
        String query = "SELECT c.cate_name, COUNT(b.b_id) as book_count, SUM(od.quantity) as total_sold "
                + "FROM category c "
                + "LEFT JOIN books b ON c.id = b.c_id "
                + "LEFT JOIN order_details od ON b.b_id = od.b_id "
                + "LEFT JOIN [order] o ON od.order_id = o.id AND o.status_id = 4 "
                + "GROUP BY c.id, c.cate_name "
                + "ORDER BY book_count DESC";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Object[] stat = new Object[3];
                stat[0] = rs.getString("cate_name");
                stat[1] = rs.getInt("book_count");
                stat[2] = rs.getInt("total_sold");
                stats.add(stat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return stats;
    }
    
    // CRUD Operations for Book Management
    public boolean addBook(String title, String description, int publicationYear, double price, 
                          int stock, int publisherId, int authorId, int categoryId) {
        String query = "INSERT INTO books (b_title, description, publication_year, price, stock, p_id, a_id, c_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setInt(3, publicationYear);
            ps.setDouble(4, price);
            ps.setInt(5, stock);
            ps.setInt(6, publisherId);
            ps.setInt(7, authorId);
            ps.setInt(8, categoryId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateBook(int bookId, String title, String description, int publicationYear, 
                             double price, int stock, int publisherId, int authorId, int categoryId) {
        String query = "UPDATE books SET b_title = ?, description = ?, publication_year = ?, price = ?, stock = ?, p_id = ?, a_id = ?, c_id = ? WHERE b_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setInt(3, publicationYear);
            ps.setDouble(4, price);
            ps.setInt(5, stock);
            ps.setInt(6, publisherId);
            ps.setInt(7, authorId);
            ps.setInt(8, categoryId);
            ps.setInt(9, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteBook(int bookId) {
        String query = "DELETE FROM books WHERE b_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Book> searchBooks(String searchTerm, int page, int recordsPerPage) {
        List<Book> bookList = new ArrayList<>();
        // Tạm thời sử dụng query đơn giản không có publishers
        String query = "SELECT b.*, a.name AS authorName, c.cate_name "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN category c ON b.c_id = c.id "
                + "WHERE b.b_title LIKE ? OR a.name LIKE ? OR c.cate_name LIKE ? "
                + "ORDER BY b.b_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setInt(4, (page - 1) * recordsPerPage);
            ps.setInt(5, recordsPerPage);
            
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
                book.setCId(rs.getInt("c_id"));
                book.setAuthorName(rs.getString("authorName"));
                book.setCategoryName(rs.getString("cate_name"));
                book.setPublisherName("N/A"); // Tạm thời set N/A
                bookList.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookList;
    }
    
    public int getTotalSearchBooks(String searchTerm) {
        // Tạm thời sử dụng query đơn giản không có publishers
        String query = "SELECT COUNT(*) FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN category c ON b.c_id = c.id "
                + "WHERE b.b_title LIKE ? OR a.name LIKE ? OR c.cate_name LIKE ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return 0;
    }
    
    public List<Book> getAllBooksWithDetails(int page, int recordsPerPage) {
        List<Book> bookList = new ArrayList<>();
        // Tạm thời sử dụng query đơn giản không có publishers
        String query = "SELECT b.*, a.name AS authorName, c.cate_name "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN category c ON b.c_id = c.id "
                + "ORDER BY b.b_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, (page - 1) * recordsPerPage);
            ps.setInt(2, recordsPerPage);
            
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
                book.setCId(rs.getInt("c_id"));
                book.setAuthorName(rs.getString("authorName"));
                book.setCategoryName(rs.getString("cate_name"));
                book.setPublisherName("N/A"); // Tạm thời set N/A
                bookList.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookList;
    }
    
    public Book getBookWithDetailsById(int bookId) {
        // Tạm thời sử dụng query đơn giản không có publishers
        String query = "SELECT b.*, a.name AS authorName, c.cate_name "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN category c ON b.c_id = c.id "
                + "WHERE b.b_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
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
                book.setCId(rs.getInt("c_id"));
                book.setAuthorName(rs.getString("authorName"));
                book.setCategoryName(rs.getString("cate_name"));
                book.setPublisherName("N/A"); // Tạm thời set N/A
                return book;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    
    public boolean isBookInOrder(int bookId) {
        String query = "SELECT COUNT(*) FROM order_details WHERE b_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int getBooksSoldCount(int bookId) {
        String query = "SELECT ISNULL(SUM(od.quantity), 0) FROM order_details od "
                + "INNER JOIN [order] o ON od.order_id = o.id "
                + "WHERE od.b_id = ? AND o.status_id = 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getLowStockBooksCount() {
        String query = "SELECT COUNT(*) FROM books WHERE stock < 10";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getOutOfStockBooksCount() {
        String query = "SELECT COUNT(*) FROM books WHERE stock = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
