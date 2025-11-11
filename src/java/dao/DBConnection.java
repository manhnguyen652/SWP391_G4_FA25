package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    // !!! QUAN TRỌNG: Hãy chắc chắn các thông tin này là chính xác !!!
    private static final String URL = "jdbc:sqlserver://ADMIN\\SQLEXPRESS:1433;databaseName=BookStoreDB;encrypt=false";
    private static final String USER = "sa";
    private static final String PASS = "123";

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("!!! LỖI KẾT NỐI DATABASE !!!");
            e.printStackTrace();
            return null;
        }
    }
}