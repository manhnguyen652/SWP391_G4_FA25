package DAO;

import model.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {

    public Account checkAccountExist(String email) {
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
                account.setDob(rs.getDate("dob"));
                account.setVerification_code(rs.getString("verification_code"));
                account.setIs_verified(rs.getBoolean("is_verified"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(Account acc) {
        String sql = "INSERT INTO account(u_email, u_pass, f_name, l_name, dob, permission_id, verification_code, is_verified) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, acc.getU_email());
            ps.setString(2, acc.getU_pass());
            ps.setString(3, acc.getF_name());
            ps.setString(4, acc.getL_name());
            ps.setDate(5, acc.getDob());
            ps.setInt(6, acc.getPermission_id());
            ps.setString(7, acc.getVerification_code());
            ps.setBoolean(8, acc.isIs_verified());
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
                account.setDob(rs.getDate("dob"));
                account.setVerification_code(rs.getString("verification_code"));
                account.setIs_verified(rs.getBoolean("is_verified"));
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
                account.setDob(rs.getDate("dob"));
                account.setVerification_code(rs.getString("verification_code"));
                account.setIs_verified(rs.getBoolean("is_verified"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean changePasswordByEmail(String email, String pass) {
        String sql = "UPDATE account SET u_pass = ? WHERE u_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pass);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean verifyAccount(String email, String code) {
        String sql = "UPDATE account SET is_verified = 1 WHERE u_email = ? AND verification_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, code);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateVerificationCode(String email, String code) {
        String sql = "UPDATE account SET verification_code = ? WHERE u_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Account> getAllUsers(int page, int recordsPerPage) {
        List<Account> users = new ArrayList<>();
        String sql = "SELECT * FROM account ORDER BY u_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * recordsPerPage);
            ps.setInt(2, recordsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setU_id(rs.getInt("u_id"));
                account.setU_email(rs.getString("u_email"));
                account.setU_pass(rs.getString("u_pass"));
                account.setF_name(rs.getString("f_name"));
                account.setL_name(rs.getString("l_name"));
                account.setPermission_id(rs.getInt("permission_id"));
                account.setDob(rs.getDate("dob"));
                account.setVerification_code(rs.getString("verification_code"));
                account.setIs_verified(rs.getBoolean("is_verified"));
                account.setCreate_date(rs.getTimestamp("create_date"));
                users.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM account";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean updateUserVerificationStatus(int userId, boolean isVerified) {
        String sql = "UPDATE account SET is_verified = ? WHERE u_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, isVerified);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Account getAccountById(int userId) {
        String sql = "SELECT * FROM account WHERE u_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setU_id(rs.getInt("u_id"));
                account.setU_email(rs.getString("u_email"));
                account.setU_pass(rs.getString("u_pass"));
                account.setF_name(rs.getString("f_name"));
                account.setL_name(rs.getString("l_name"));
                account.setPermission_id(rs.getInt("permission_id"));
                account.setDob(rs.getDate("dob"));
                account.setVerification_code(rs.getString("verification_code"));
                account.setIs_verified(rs.getBoolean("is_verified"));
                account.setCreate_date(rs.getTimestamp("create_date"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(int userId, String email, String password, String firstName, String lastName, String dob, int permissionId) {
        String sql;
        if (password != null && !password.trim().isEmpty()) {
            // Cập nhật cả mật khẩu
            sql = "UPDATE account SET u_email = ?, u_pass = ?, f_name = ?, l_name = ?, dob = ?, permission_id = ? WHERE u_id = ?";
        } else {
            // Không cập nhật mật khẩu
            sql = "UPDATE account SET u_email = ?, f_name = ?, l_name = ?, dob = ?, permission_id = ? WHERE u_id = ?";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (password != null && !password.trim().isEmpty()) {
                ps.setString(1, email);
                ps.setString(2, password);
                ps.setString(3, firstName);
                ps.setString(4, lastName);
                if (dob != null && !dob.isEmpty()) {
                    ps.setDate(5, java.sql.Date.valueOf(dob));
                } else {
                    ps.setNull(5, java.sql.Types.DATE);
                }
                ps.setInt(6, permissionId);
                ps.setInt(7, userId);
            } else {
                ps.setString(1, email);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                if (dob != null && !dob.isEmpty()) {
                    ps.setDate(4, java.sql.Date.valueOf(dob));
                } else {
                    ps.setNull(4, java.sql.Types.DATE);
                }
                ps.setInt(5, permissionId);
                ps.setInt(6, userId);
            }
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM account WHERE u_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Account> getUsersWithFilter(String search, String role, String status, int page, int recordsPerPage) {
        List<Account> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM account WHERE 1=1");
        List<Object> parameters = new ArrayList<>();
        
        // Thêm điều kiện search
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u_email LIKE ? OR f_name LIKE ? OR l_name LIKE ?)");
            String searchPattern = "%" + search + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }
        
        // Thêm điều kiện role
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND permission_id = ?");
            parameters.add(Integer.parseInt(role));
        }
        
        // Thêm điều kiện status
        if (status != null && !status.trim().isEmpty()) {
            if ("verified".equals(status)) {
                sql.append(" AND is_verified = 1");
            } else if ("unverified".equals(status)) {
                sql.append(" AND is_verified = 0");
            }
        }
        
        sql.append(" ORDER BY u_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        parameters.add((page - 1) * recordsPerPage);
        parameters.add(recordsPerPage);
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setU_id(rs.getInt("u_id"));
                account.setU_email(rs.getString("u_email"));
                account.setU_pass(rs.getString("u_pass"));
                account.setF_name(rs.getString("f_name"));
                account.setL_name(rs.getString("l_name"));
                account.setPermission_id(rs.getInt("permission_id"));
                account.setDob(rs.getDate("dob"));
                account.setVerification_code(rs.getString("verification_code"));
                account.setIs_verified(rs.getBoolean("is_verified"));
                account.setCreate_date(rs.getTimestamp("create_date"));
                users.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public int getTotalUsersWithFilter(String search, String role, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM account WHERE 1=1");
        List<Object> parameters = new ArrayList<>();
        
        // Thêm điều kiện search
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u_email LIKE ? OR f_name LIKE ? OR l_name LIKE ?)");
            String searchPattern = "%" + search + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }
        
        // Thêm điều kiện role
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND permission_id = ?");
            parameters.add(Integer.parseInt(role));
        }
        
        // Thêm điều kiện status
        if (status != null && !status.trim().isEmpty()) {
            if ("verified".equals(status)) {
                sql.append(" AND is_verified = 1");
            } else if ("unverified".equals(status)) {
                sql.append(" AND is_verified = 0");
            }
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getVerifiedUsersCount() {
        String sql = "SELECT COUNT(*) FROM account WHERE is_verified = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getNewUsersTodayCount() {
        String sql = "SELECT COUNT(*) FROM account WHERE CAST(create_date AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}