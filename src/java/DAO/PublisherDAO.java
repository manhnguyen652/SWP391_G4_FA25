package dao;

import model.Publisher;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PublisherDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<Publisher> getAllPublishers() {
        List<Publisher> list = new ArrayList<>();
        String query = "SELECT * FROM publishers";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Publisher(rs.getInt(1), rs.getString(2), rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return list;
    }
}