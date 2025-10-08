package dao; 

import java.sql.*;
import model.Account;
import dao.DBConnection; 

public class AccountDAO {
    // đăng kí
    public boolean register(Account acc) {
        String sql = "INSERT INTO account(u_email, u_pass, f_name, l_name, dob, permission_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, acc.getU_email());
            ps.setString(2, acc.getU_pass());
            ps.setString(3, acc.getF_name());
            ps.setString(4, acc.getL_name());
            ps.setDate(5, acc.getDob());
            ps.setInt(6, acc.getPermission_id());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // đăng nhập
    public Account login(String email, String password) {
        String sql = "SELECT * FROM account WHERE u_email = ? AND u_pass = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Account acc = new Account();
                acc.setU_id(rs.getInt("u_id"));
                acc.setU_email(rs.getString("u_email"));
                acc.setF_name(rs.getString("f_name"));
                acc.setL_name(rs.getString("l_name"));
                acc.setPermission_id(rs.getInt("permission_id"));
                return acc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
