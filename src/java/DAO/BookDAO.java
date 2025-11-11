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

    public List<Book> getBooksByPage(int pageNumber, int pageSize, String sortOrder) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b INNER JOIN authors a ON b.a_id = a.id "
                + getOrderByClause(sortOrder)
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

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

    public List<Book> searchBooks(String searchQuery, int pageNumber, int pageSize, String sortOrder) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN publishers p ON b.p_id = p.id " // JOIN thêm bảng publishers
                + "WHERE b.b_title LIKE ? OR a.name LIKE ? OR p.name LIKE ? OR b.description LIKE ? " // Điều kiện tìm kiếm (thêm description)
                + getOrderByClause(sortOrder)
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        int offset = (pageNumber - 1) * pageSize;

        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            String searchPattern = "%" + searchQuery + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern); // Thêm tìm kiếm theo description
            ps.setInt(5, offset);
            ps.setInt(6, pageSize);

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
                + "WHERE b.b_title LIKE ? OR a.name LIKE ? OR p.name LIKE ? OR b.description LIKE ?"; // Thêm tìm kiếm theo description

        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            String searchPattern = "%" + searchQuery + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern); // Thêm tìm kiếm theo description
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
    /**
     * Lấy ORDER BY clause dựa trên sortOrder
     * @param sortOrder - Loại sắp xếp: default, name_asc, name_desc, price_asc, price_desc
     * @return ORDER BY clause
     */
    private String getOrderByClause(String sortOrder) {
        if (sortOrder == null || sortOrder.isEmpty() || "default".equals(sortOrder)) {
            return "ORDER BY b.b_id";
        }
        
        switch (sortOrder) {
            case "name_asc":
                return "ORDER BY b.b_title ASC";
            case "name_desc":
                return "ORDER BY b.b_title DESC";
            case "price_asc":
                return "ORDER BY b.price ASC";
            case "price_desc":
                return "ORDER BY b.price DESC";
            default:
                return "ORDER BY b.b_id";
        }
    }
    
    /**
     * Lọc sách theo nhiều tiêu chí (thể loại, giá, tác giả, nhà xuất bản)
     * @param categoryId - ID thể loại (null nếu không lọc theo thể loại)
     * @param minPrice - Giá tối thiểu (null nếu không lọc theo giá)
     * @param maxPrice - Giá tối đa (null nếu không lọc theo giá)
     * @param authorId - ID tác giả (null nếu không lọc theo tác giả)
     * @param publisherId - ID nhà xuất bản (null nếu không lọc theo nhà xuất bản)
     * @param sortOrder - Loại sắp xếp (default, name_asc, name_desc, price_asc, price_desc)
     * @param pageNumber - Số trang
     * @param pageSize - Số lượng sách mỗi trang
     * @return Danh sách sách đã được lọc
     */
    public List<Book> filterBooks(Integer categoryId, Double minPrice, Double maxPrice, 
                                   Integer authorId, Integer publisherId, String sortOrder,
                                   int pageNumber, int pageSize) {
        List<Book> bookList = new ArrayList<>();
        StringBuilder query = new StringBuilder();
        
        query.append("SELECT b.*, a.name AS authorName ")
             .append("FROM books b ")
             .append("INNER JOIN authors a ON b.a_id = a.id ")
             .append("WHERE 1=1 ");
        
        // Xây dựng điều kiện WHERE động
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null && categoryId > 0) {
            query.append("AND b.c_id = ? ");
            params.add(categoryId);
        }
        
        if (minPrice != null && minPrice >= 0) {
            query.append("AND b.price >= ? ");
            params.add(minPrice);
        }
        
        if (maxPrice != null && maxPrice > 0) {
            query.append("AND b.price <= ? ");
            params.add(maxPrice);
        }
        
        if (authorId != null && authorId > 0) {
            query.append("AND b.a_id = ? ");
            params.add(authorId);
        }
        
        if (publisherId != null && publisherId > 0) {
            query.append("AND b.p_id = ? ");
            params.add(publisherId);
        }
        
        query.append(getOrderByClause(sortOrder))
             .append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        int offset = (pageNumber - 1) * pageSize;
        
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query.toString());
            
            // Set các tham số
            int paramIndex = 1;
            for (Object param : params) {
                if (param instanceof Integer) {
                    ps.setInt(paramIndex++, (Integer) param);
                } else if (param instanceof Double) {
                    ps.setDouble(paramIndex++, (Double) param);
                }
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);
            
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
    
    /**
     * Đếm tổng số sách sau khi lọc
     * @param categoryId - ID thể loại (null nếu không lọc theo thể loại)
     * @param minPrice - Giá tối thiểu (null nếu không lọc theo giá)
     * @param maxPrice - Giá tối đa (null nếu không lọc theo giá)
     * @param authorId - ID tác giả (null nếu không lọc theo tác giả)
     * @param publisherId - ID nhà xuất bản (null nếu không lọc theo nhà xuất bản)
     * @return Tổng số sách thỏa mãn điều kiện lọc
     */
    public int getTotalFilteredBooks(Integer categoryId, Double minPrice, Double maxPrice, 
                                     Integer authorId, Integer publisherId) {
        StringBuilder query = new StringBuilder();
        
        query.append("SELECT COUNT(*) ")
             .append("FROM books b ")
             .append("WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (categoryId != null && categoryId > 0) {
            query.append("AND b.c_id = ? ");
            params.add(categoryId);
        }
        
        if (minPrice != null && minPrice >= 0) {
            query.append("AND b.price >= ? ");
            params.add(minPrice);
        }
        
        if (maxPrice != null && maxPrice > 0) {
            query.append("AND b.price <= ? ");
            params.add(maxPrice);
        }
        
        if (authorId != null && authorId > 0) {
            query.append("AND b.a_id = ? ");
            params.add(authorId);
        }
        
        if (publisherId != null && publisherId > 0) {
            query.append("AND b.p_id = ? ");
            params.add(publisherId);
        }
        
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query.toString());
            
            int paramIndex = 1;
            for (Object param : params) {
                if (param instanceof Integer) {
                    ps.setInt(paramIndex++, (Integer) param);
                } else if (param instanceof Double) {
                    ps.setDouble(paramIndex++, (Double) param);
                }
            }
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }
    
    /**
     * Lọc sách kết hợp với tìm kiếm theo từ khóa
     * @param searchQuery - Từ khóa tìm kiếm (null hoặc rỗng nếu không tìm kiếm)
     * @param categoryId - ID thể loại (null nếu không lọc theo thể loại)
     * @param minPrice - Giá tối thiểu (null nếu không lọc theo giá)
     * @param maxPrice - Giá tối đa (null nếu không lọc theo giá)
     * @param authorId - ID tác giả (null nếu không lọc theo tác giả)
     * @param publisherId - ID nhà xuất bản (null nếu không lọc theo nhà xuất bản)
     * @param sortOrder - Loại sắp xếp (default, name_asc, name_desc, price_asc, price_desc)
     * @param pageNumber - Số trang
     * @param pageSize - Số lượng sách mỗi trang
     * @return Danh sách sách đã được lọc và tìm kiếm
     */
    public List<Book> searchAndFilterBooks(String searchQuery, Integer categoryId, 
                                           Double minPrice, Double maxPrice, 
                                           Integer authorId, Integer publisherId, String sortOrder,
                                           int pageNumber, int pageSize) {
        List<Book> bookList = new ArrayList<>();
        StringBuilder query = new StringBuilder();
        
        query.append("SELECT b.*, a.name AS authorName ")
             .append("FROM books b ")
             .append("INNER JOIN authors a ON b.a_id = a.id ")
             .append("INNER JOIN publishers p ON b.p_id = p.id ")
             .append("WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        // Điều kiện tìm kiếm
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            query.append("AND (b.b_title LIKE ? OR a.name LIKE ? OR p.name LIKE ? OR b.description LIKE ?) "); // Thêm tìm kiếm theo description
            String searchPattern = "%" + searchQuery.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern); // Thêm tìm kiếm theo description
        }
        
        // Điều kiện lọc
        if (categoryId != null && categoryId > 0) {
            query.append("AND b.c_id = ? ");
            params.add(categoryId);
        }
        
        if (minPrice != null && minPrice >= 0) {
            query.append("AND b.price >= ? ");
            params.add(minPrice);
        }
        
        if (maxPrice != null && maxPrice > 0) {
            query.append("AND b.price <= ? ");
            params.add(maxPrice);
        }
        
        if (authorId != null && authorId > 0) {
            query.append("AND b.a_id = ? ");
            params.add(authorId);
        }
        
        if (publisherId != null && publisherId > 0) {
            query.append("AND b.p_id = ? ");
            params.add(publisherId);
        }
        
        query.append(getOrderByClause(sortOrder))
             .append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        int offset = (pageNumber - 1) * pageSize;
        
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query.toString());
            
            int paramIndex = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    ps.setString(paramIndex++, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(paramIndex++, (Integer) param);
                } else if (param instanceof Double) {
                    ps.setDouble(paramIndex++, (Double) param);
                }
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);
            
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
    
    /**
     * Đếm tổng số sách sau khi tìm kiếm và lọc
     * @param searchQuery - Từ khóa tìm kiếm (null hoặc rỗng nếu không tìm kiếm)
     * @param categoryId - ID thể loại (null nếu không lọc theo thể loại)
     * @param minPrice - Giá tối thiểu (null nếu không lọc theo giá)
     * @param maxPrice - Giá tối đa (null nếu không lọc theo giá)
     * @param authorId - ID tác giả (null nếu không lọc theo tác giả)
     * @param publisherId - ID nhà xuất bản (null nếu không lọc theo nhà xuất bản)
     * @return Tổng số sách thỏa mãn điều kiện
     */
    public int getTotalSearchAndFilterBooks(String searchQuery, Integer categoryId, 
                                            Double minPrice, Double maxPrice, 
                                            Integer authorId, Integer publisherId) {
        StringBuilder query = new StringBuilder();
        
        query.append("SELECT COUNT(*) ")
             .append("FROM books b ")
             .append("INNER JOIN authors a ON b.a_id = a.id ")
             .append("INNER JOIN publishers p ON b.p_id = p.id ")
             .append("WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        // Điều kiện tìm kiếm
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            query.append("AND (b.b_title LIKE ? OR a.name LIKE ? OR p.name LIKE ? OR b.description LIKE ?) "); // Thêm tìm kiếm theo description
            String searchPattern = "%" + searchQuery.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern); // Thêm tìm kiếm theo description
        }
        
        // Điều kiện lọc
        if (categoryId != null && categoryId > 0) {
            query.append("AND b.c_id = ? ");
            params.add(categoryId);
        }
        
        if (minPrice != null && minPrice >= 0) {
            query.append("AND b.price >= ? ");
            params.add(minPrice);
        }
        
        if (maxPrice != null && maxPrice > 0) {
            query.append("AND b.price <= ? ");
            params.add(maxPrice);
        }
        
        if (authorId != null && authorId > 0) {
            query.append("AND b.a_id = ? ");
            params.add(authorId);
        }
        
        if (publisherId != null && publisherId > 0) {
            query.append("AND b.p_id = ? ");
            params.add(publisherId);
        }
        
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query.toString());
            
            int paramIndex = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    ps.setString(paramIndex++, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(paramIndex++, (Integer) param);
                } else if (param instanceof Double) {
                    ps.setDouble(paramIndex++, (Double) param);
                }
            }
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }
    
    /**
     * Lấy giá tối thiểu và tối đa của tất cả sách
     * @return Map chứa "minPrice" và "maxPrice"
     */
    public Map<String, Double> getPriceRange() {
        Map<String, Double> priceRange = new HashMap<>();
        String query = "SELECT MIN(price) AS minPrice, MAX(price) AS maxPrice FROM books";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                priceRange.put("minPrice", rs.getDouble("minPrice"));
                priceRange.put("maxPrice", rs.getDouble("maxPrice"));
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
        return priceRange;
    }
    
    /**
     * Lấy danh sách sách với thông tin đầy đủ (category, publisher)
     */
    public List<Book> getAllBooksWithDetails(int page, int pageSize) {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName, c.name AS categoryName, p.name AS publisherName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN category c ON b.c_id = c.id "
                + "INNER JOIN publishers p ON b.p_id = p.id "
                + "ORDER BY b.b_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            int offset = (page - 1) * pageSize;
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            
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
                book.setCategoryName(rs.getString("categoryName"));
                book.setPublisherName(rs.getString("publisherName"));
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
    
    /**
     * Lấy thông tin chi tiết sách theo ID (có category, publisher)
     */
    public Book getBookWithDetailsById(int bookId) {
        String query = "SELECT b.*, a.name AS authorName, c.name AS categoryName, p.name AS publisherName "
                + "FROM books b "
                + "INNER JOIN authors a ON b.a_id = a.id "
                + "INNER JOIN category c ON b.c_id = c.id "
                + "INNER JOIN publishers p ON b.p_id = p.id "
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
                book.setImageId(rs.getInt("image_id"));
                book.setCId(rs.getInt("c_id"));
                book.setAuthorName(rs.getString("authorName"));
                book.setCategoryName(rs.getString("categoryName"));
                book.setPublisherName(rs.getString("publisherName"));
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
    
    /**
     * Thêm sách mới
     */
    public boolean addBook(String title, String description, int publicationYear, 
                          double price, int stock, int publisherId, int authorId, int categoryId) {
        String query = "INSERT INTO books (b_title, description, publication_year, price, stock, p_id, a_id, c_id, image_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setInt(3, publicationYear);
            ps.setDouble(4, price);
            ps.setInt(5, stock);
            ps.setInt(6, publisherId);
            ps.setInt(7, authorId);
            ps.setInt(8, categoryId);
            
            int result = ps.executeUpdate();
            return result > 0;
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
    
    /**
     * Cập nhật thông tin sách
     */
    public boolean updateBook(int bookId, String title, String description, int publicationYear,
                             double price, int stock, int publisherId, int authorId, int categoryId) {
        String query = "UPDATE books SET b_title = ?, description = ?, publication_year = ?, "
                + "price = ?, stock = ?, p_id = ?, a_id = ?, c_id = ? WHERE b_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setInt(3, publicationYear);
            ps.setDouble(4, price);
            ps.setInt(5, stock);
            ps.setInt(6, publisherId);
            ps.setInt(7, authorId);
            ps.setInt(8, categoryId);
            ps.setInt(9, bookId);
            
            int result = ps.executeUpdate();
            return result > 0;
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
    
    /**
     * Xóa sách
     */
    public boolean deleteBook(int bookId) {
        String query = "DELETE FROM books WHERE b_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
            
            int result = ps.executeUpdate();
            return result > 0;
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
    
    /**
     * Cập nhật tồn kho
     */
    public boolean updateBookStock(int bookId, int newStock) {
        String query = "UPDATE books SET stock = ? WHERE b_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newStock);
            ps.setInt(2, bookId);
            
            int result = ps.executeUpdate();
            return result > 0;
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
    /**
     * Kiểm tra sách có trong đơn hàng không
     */
    public boolean isBookInOrder(int bookId) {
        String query = "SELECT COUNT(*) FROM order_items WHERE b_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
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
        return false;
    }
    
    /**
     * Lấy số lượng sách đã bán
     */
    public int getBooksSoldCount(int bookId) {
        String query = "SELECT ISNULL(SUM(quantity), 0) FROM order_items WHERE b_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
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
    
    /**
     * Lấy số sách tồn kho thấp (< 10)
     */
    public int getLowStockBooksCount() {
        String query = "SELECT COUNT(*) FROM books WHERE stock > 0 AND stock < 10";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
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
    
    /**
     * Lấy số sách hết hàng
     */
    public int getOutOfStockBooksCount() {
        String query = "SELECT COUNT(*) FROM books WHERE stock = 0";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
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
    
    /**
     * Tìm kiếm sách (cho staff management)
     */
    public List<Book> searchBooks(String searchQuery, int page, int pageSize) {
        return searchBooks(searchQuery, page, pageSize, "default");
    }
}
