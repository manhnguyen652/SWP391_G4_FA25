package Controllers;

import model.Account;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/staff-dashboard", "/staff/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();
        
        // Kiểm tra xem người dùng đã đăng nhập chưa
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            // Chưa đăng nhập, chuyển hướng đến trang đăng nhập
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login-register");
            return;
        }
        
        // Kiểm tra quyền truy cập (chỉ Admin và Staff)
        int permissionId = account.getPermission_id();
        if (permissionId != 1 && permissionId != 3) {
            // Không có quyền, chuyển hướng về trang chủ
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
            return;
        }
        
        // Có quyền, cho phép truy cập
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup filter
    }
}
