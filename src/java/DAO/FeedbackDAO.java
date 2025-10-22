package DAO;

import Model.Feedback;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    public List<Feedback> getAllFeedback(String search, String sort, String filter) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE 1=1";

        // Tìm kiếm
        if (search != null && !search.isEmpty()) {
            sql += " AND content LIKE ?";
        }

        // Lọc theo trạng thái
        if (filter != null && !filter.isEmpty()) {
            sql += " AND status = ?";
        }

        // Sắp xếp
        if (sort != null) {
            switch (sort) {
                case "date_desc": sql += " ORDER BY createdDate DESC"; break;
                case "date_asc": sql += " ORDER BY createdDate ASC"; break;
                case "name_asc": sql += " ORDER BY userName ASC"; break;
                case "name_desc": sql += " ORDER BY userName DESC"; break;
            }
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;
            if (search != null && !search.isEmpty()) ps.setString(index++, "%" + search + "%");
            if (filter != null && !filter.isEmpty()) ps.setString(index++, filter);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Feedback(
                        rs.getInt("id"),
                        rs.getString("userName"),
                        rs.getString("content"),
                        rs.getDate("createdDate"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteFeedback(int id) {
        String sql = "DELETE FROM Feedback WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateStatus(int id, String status) {
        String sql = "UPDATE Feedback SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
