package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Review;

public class ReviewDAO {
    
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    
    // Lấy tất cả reviews của một cuốn sách
    public List<Review> getReviewsByBookId(int bookId) {
        List<Review> reviewList = new ArrayList<>();
        String query = "SELECT r.*, a.f_name + ' ' + a.l_name AS userName "
                + "FROM reviews r "
                + "INNER JOIN account a ON r.u_id = a.u_id "
                + "WHERE r.b_id = ? "
                + "ORDER BY r.created_date DESC";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("id"));
                review.setBookId(rs.getInt("b_id"));
                review.setUserId(rs.getInt("u_id"));
                review.setUserName(rs.getString("userName"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setCreatedDate(rs.getDate("created_date"));
                reviewList.add(review);
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
        return reviewList;
    }
    
    // Thêm review mới
    public boolean addReview(Review review) {
        String query = "INSERT INTO reviews (b_id, u_id, rating, comment, created_date) "
                + "VALUES (?, ?, ?, ?, GETDATE())";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, review.getBookId());
            ps.setInt(2, review.getUserId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            
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
    
    // Kiểm tra xem user đã review sách này chưa
    public boolean hasUserReviewed(int bookId, int userId) {
        String query = "SELECT COUNT(*) FROM reviews WHERE b_id = ? AND u_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
            ps.setInt(2, userId);
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
    
    // Tính điểm rating trung bình của sách
    public double getAverageRating(int bookId) {
        String query = "SELECT AVG(CAST(rating AS FLOAT)) FROM reviews WHERE b_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble(1);
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
        return 0.0;
    }
    
    // Đếm số lượng reviews của sách
    public int getReviewCount(int bookId) {
        String query = "SELECT COUNT(*) FROM reviews WHERE b_id = ?";
        
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
    
    // Lấy review theo ID
    public Review getReviewById(int reviewId) {
        String query = "SELECT r.*, a.f_name + ' ' + a.l_name AS userName "
                + "FROM reviews r "
                + "INNER JOIN account a ON r.u_id = a.u_id "
                + "WHERE r.id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, reviewId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("id"));
                review.setBookId(rs.getInt("b_id"));
                review.setUserId(rs.getInt("u_id"));
                review.setUserName(rs.getString("userName"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setCreatedDate(rs.getDate("created_date"));
                return review;
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
    
    // Cập nhật review
    public boolean updateReview(int reviewId, int rating, String comment) {
        String query = "UPDATE reviews SET rating = ?, comment = ? WHERE id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, rating);
            ps.setString(2, comment);
            ps.setInt(3, reviewId);
            
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
    
    // Xóa review
    public boolean deleteReview(int reviewId) {
        String query = "DELETE FROM reviews WHERE id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, reviewId);
            
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
    
    // Kiểm tra xem user có phải chủ sở hữu review không
    public boolean isReviewOwner(int reviewId, int userId) {
        String query = "SELECT COUNT(*) FROM reviews WHERE id = ? AND u_id = ?";
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, reviewId);
            ps.setInt(2, userId);
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
}

