package Controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutController", urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession(false); 
        
        // Nếu session tồn tại, hủy nó đi
        if (session != null) {
            session.invalidate();
        }
        
        // Chuyển hướng người dùng về trang chủ
        response.sendRedirect(request.getContextPath() + "/home");
    }
}