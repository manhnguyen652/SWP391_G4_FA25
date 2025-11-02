package DAO;

import model.UserInformation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserInformationDAO {

    public List<UserInformation> getAllUserInfo(int u_id) {
        List<UserInformation> list = new ArrayList<>();
        String sql = "SELECT * FROM user_information WHERE u_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, u_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserInformation info = new UserInformation();
                    info.setId(rs.getInt("id"));
                    info.setPhone(rs.getString("phone"));
                    info.setCountry(rs.getString("country"));
                    info.setAddress(rs.getString("addr"));
                    info.setU_id(rs.getInt("u_id"));
                    list.add(info);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public UserInformation getSingleUserInfo(int infoId) {
        String sql = "SELECT * FROM user_information WHERE id = ?";
        UserInformation info = null;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, infoId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    info = new UserInformation();
                    info.setId(rs.getInt("id"));
                    info.setPhone(rs.getString("phone"));
                    info.setCountry(rs.getString("country"));
                    info.setAddress(rs.getString("addr"));
                    info.setU_id(rs.getInt("u_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return info;
    }

    public void addUserInfo(UserInformation info) {
        String sql = "INSERT INTO user_information (phone, country, addr, u_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, info.getPhone());
            ps.setString(2, info.getCountry());
            ps.setString(3, info.getAddress());
            ps.setInt(4, info.getU_id());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public UserInformation getUserInfoByUserId(int userId) {
        UserInformation info = null;
        String sql = "SELECT * FROM user_information WHERE u_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                info = new UserInformation();
                info.setId(rs.getInt("id"));
                info.setU_id(rs.getInt("u_id"));
                info.setAddress(rs.getString("addr"));
                info.setCountry(rs.getString("country"));
                info.setPhone(rs.getString("phone"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return info;
    }

    public boolean updateUserInfo(int userId, String address, String country, String phone) {
        String sql = "UPDATE user_information SET addr = ?, country = ?, phone = ? WHERE u_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, address);
            ps.setString(2, country);
            ps.setString(3, phone);
            ps.setInt(4, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
