package DAO;

import model.Author;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuthorDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    
    public List<Author> getAllAuthors() {
        List<Author> list = new ArrayList<>();
        String query = "SELECT * FROM authors";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Author(rs.getInt(1), rs.getString(2), rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return list;
    }
}