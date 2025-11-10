package DAO;

import java.sql.*;
import java.util.*;
import model.Shipping;

public class ShippingDAO {

    public List<Shipping> getAllShipping(int shipperId, int page, int pageSize, String filter, String search, String sort) {
        List<Shipping> list = new ArrayList<>();
        String sql = """
            SELECT s.id, s.order_id, s.shipper_id, s.delivery_address, s.status, s.shipping_fee, s.payment_status,
                   o.create_date AS order_date, a.f_name + ' ' + a.l_name AS customer_name, s.delivery_date
            FROM shipping s
            JOIN [order] o ON s.order_id = o.id
            JOIN account a ON o.u_id = a.u_id
            WHERE 1=1
            """;

        if (shipperId > 0) {
            sql += " AND s.shipper_id = ?";
        }
        if (filter != null && !filter.isEmpty()) {
            sql += " AND s.status = ?";
            filter = filter.substring(0, 1).toUpperCase() + filter.substring(1).toLowerCase();
        }
        if (search != null && !search.isEmpty()) {
            sql += " AND (a.f_name LIKE ? OR a.l_name LIKE ?)";
        }
        if ("date_desc".equals(sort)) {
            sql += " ORDER BY o.create_date DESC";
        } else if ("date_asc".equals(sort)) {
            sql += " ORDER BY o.create_date ASC";
        } else if ("name_asc".equals(sort)) {
            sql += " ORDER BY customer_name ASC";
        } else if ("name_desc".equals(sort)) {
            sql += " ORDER BY customer_name DESC";
        } else {
            sql += " ORDER BY s.id DESC";
        }

        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            int index = 1;
            if (shipperId > 0) {
                ps.setInt(index++, shipperId);
            }
            if (filter != null && !filter.isEmpty()) {
                ps.setString(index++, filter);
            }
            if (search != null && !search.isEmpty()) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Shipping s = new Shipping();
                s.setId(rs.getInt("id"));
                s.setOrderId(rs.getInt("order_id"));
                s.setShipperId(rs.getInt("shipper_id"));
                s.setDeliveryAddress(rs.getString("delivery_address"));
                s.setStatus(rs.getString("status"));
                s.setShippingFee(rs.getDouble("shipping_fee"));
                s.setPaymentStatus(rs.getString("payment_status"));
                s.setCustomerName(rs.getString("customer_name"));
                s.setOrderDate(rs.getTimestamp("order_date"));
                s.setDeliveryDate(rs.getTimestamp("delivery_date"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Shipping getShippingById(int shippingId) {
        String sql = """
            SELECT s.id, s.order_id, s.shipper_id, s.delivery_address, s.status, s.shipping_fee, s.payment_status,
                   s.delivery_date, o.create_date AS order_date, a.f_name + ' ' + a.l_name AS customer_name
            FROM shipping s
            JOIN [order] o ON s.order_id = o.id
            JOIN account a ON o.u_id = a.u_id
            WHERE s.id = ?
        """;

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, shippingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Shipping s = new Shipping();
                s.setId(rs.getInt("id"));
                s.setOrderId(rs.getInt("order_id"));
                s.setShipperId(rs.getInt("shipper_id"));
                s.setDeliveryAddress(rs.getString("delivery_address"));
                s.setStatus(rs.getString("status"));
                s.setShippingFee(rs.getDouble("shipping_fee"));
                s.setPaymentStatus(rs.getString("payment_status"));
                s.setDeliveryDate(rs.getTimestamp("delivery_date"));
                s.setCustomerName(rs.getString("customer_name"));
                s.setOrderDate(rs.getTimestamp("order_date"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStatus(int shippingId, int shipperId, String newStatus) {
        String sql = """
            UPDATE shipping
            SET status = ?, delivery_date = CASE WHEN ? = 'Delivered' THEN GETDATE() ELSE delivery_date END
            WHERE id = ? AND shipper_id = ?
        """;
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, newStatus);
            ps.setInt(3, shippingId);
            ps.setInt(4, shipperId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalRecords(int shipperId, String filter, String search) {
        String sql = "SELECT COUNT(*) FROM shipping s JOIN [order] o ON s.order_id = o.id JOIN account a ON o.u_id = a.u_id WHERE 1=1";
        if (shipperId > 0) {
            sql += " AND s.shipper_id = ?";
        }
        if (filter != null && !filter.isEmpty()) {
            sql += " AND s.status = ?";
        }
        if (search != null && !search.isEmpty()) {
            sql += " AND (a.f_name LIKE ? OR a.l_name LIKE ?)";
        }

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            int index = 1;
            if (shipperId > 0) {
                ps.setInt(index++, shipperId);
            }
            if (filter != null && !filter.isEmpty()) {
                ps.setString(index++, filter);
            }
            if (search != null && !search.isEmpty()) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<String, Integer> getStatusCounters(int shipperId) {
        Map<String, Integer> counters = new HashMap<>();
        String sql = """
            SELECT status, COUNT(*) AS total
            FROM shipping
            WHERE shipper_id = ?
            GROUP BY status
        """;
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, shipperId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                counters.put(rs.getString("status"), rs.getInt("total"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return counters;
    }
    
}
