package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
import java.sql.Connection;

public class OrderDetailDAO {

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();

        String sql = """
            SELECT od.*, b.name AS book_name, b.image AS book_image
            FROM [order_details] od
            JOIN [books] b ON od.b_id = b.id
            WHERE od.order_id = ?
        """;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setId(rs.getInt("id"));
                od.setOrderId(rs.getInt("order_id"));
                od.setBId(rs.getInt("b_id"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPricePerItem(rs.getDouble("price_per_item"));

                // Gán thêm thuộc tính mở rộng (sách)
                od.setBookName(rs.getString("book_name"));
                od.setBookImage(rs.getString("book_image"));

                list.add(od);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
