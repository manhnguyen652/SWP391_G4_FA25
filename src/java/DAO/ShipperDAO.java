package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.ShipperProfile;

public class ShipperDAO {

    public ShipperProfile getProfileByAccountId(int accountId) {
        String sql = """
            SELECT id, u_id, phone, vehicle_number, region
            FROM shipper_profile
            WHERE u_id = ?
        """;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ShipperProfile profile = new ShipperProfile();
                profile.setId(rs.getInt("id"));
                profile.setAccountId(rs.getInt("u_id"));
                profile.setPhone(rs.getString("phone"));
                profile.setVehicleNumber(rs.getString("vehicle_number"));
                profile.setRegion(rs.getString("region"));
                return profile;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean upsertProfile(ShipperProfile profile) {
        String sql = """
            IF EXISTS (SELECT 1 FROM shipper_profile WHERE u_id = ?)
                UPDATE shipper_profile
                SET phone = ?, vehicle_number = ?, region = ?
                WHERE u_id = ?
            ELSE
                INSERT INTO shipper_profile (u_id, phone, vehicle_number, region)
                VALUES (?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, profile.getAccountId());
            ps.setString(2, profile.getPhone());
            ps.setString(3, profile.getVehicleNumber());
            ps.setString(4, profile.getRegion());
            ps.setInt(5, profile.getAccountId());
            ps.setInt(6, profile.getAccountId());
            ps.setString(7, profile.getPhone());
            ps.setString(8, profile.getVehicleNumber());
            ps.setString(9, profile.getRegion());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
}

