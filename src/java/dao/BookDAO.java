package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Book;

public class BookDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<Book> getAllBooks() {
        List<Book> bookList = new ArrayList<>();
        String query = "SELECT b.*, a.name AS authorName "
                     + "FROM books b "
                     + "INNER JOIN authors a ON b.a_id = a.id";

        try {

            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setBId(rs.getInt("b_id"));
                book.setBTitle(rs.getString("b_title"));
                book.setDescription(rs.getString("description"));
                book.setPublicationYear(rs.getInt("publication_year"));
                book.setPrice(rs.getDouble("price"));
                book.setStock(rs.getInt("stock"));
                book.setPId(rs.getInt("p_id"));
                book.setAId(rs.getInt("a_id"));
                book.setImageId(rs.getInt("image_id"));
                book.setCId(rs.getInt("c_id"));
                book.setAuthorName(rs.getString("authorName"));
                bookList.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookList;
    }
   
    public static void main(String[] args) {
    BookDAO bookDAO = new BookDAO();
    // Lấy danh sách tất cả các cuốn sách
    List<Book> bookList = bookDAO.getAllBooks();

    // Kiểm tra xem danh sách có rỗng không
    if (bookList.isEmpty()) {
        System.out.println("Không tìm thấy cuốn sách nào.");
    } else {
        System.out.println("Đã tìm thấy " + bookList.size() + " cuốn sách. Đang kiểm tra title...");
        // Lặp qua từng cuốn sách và in ra title của nó
        for (Book book : bookList) {
            // Cách 1: In toàn bộ thông tin (nhờ có toString() ở Bước 1)
            System.out.println(book.toString());

            // Cách 2: Chỉ in ra title để kiểm tra (rõ ràng hơn)
            // System.out.println("ID: " + book.getBId() + " | Title: " + book.getBTitle());
        }
    }
}
}
