package DAO;

import model.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountDAO {

    public Account checkAccountExist(String email) {
        String sql = "SELECT * FROM account WHERE u_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Account login(String email, String password) {
        String sql = "SELECT * FROM account WHERE u_email = ? AND u_pass = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setU_id(rs.getInt("u_id"));
                account.setU_email(rs.getString("u_email"));
                account.setU_pass(rs.getString("u_pass"));
                account.setF_name(rs.getString("f_name"));
                account.setL_name(rs.getString("l_name"));
                account.setPermission_id(rs.getInt("permission_id"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE account SET u_pass = ? WHERE u_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Account getAccountByEmail(String email) {
        String sql = "SELECT * FROM account WHERE u_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setU_id(rs.getInt("u_id"));
                account.setU_email(rs.getString("u_email"));
                account.setU_pass(rs.getString("u_pass"));
                account.setF_name(rs.getString("f_name"));
                account.setL_name(rs.getString("l_name"));
                account.setPermission_id(rs.getInt("permission_id"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}