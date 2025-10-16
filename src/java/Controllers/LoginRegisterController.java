package Controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.AccountDAO;
import model.Account;
import java.sql.Date;

/**
 */
@WebServlet("/login-register")
public class LoginRegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String action = request.getParameter("action");
    AccountDAO dao = new AccountDAO();

    if ("login".equals(action)) {
        String email = request.getParameter("login_email");
        String password = request.getParameter("login_password");

        model.Account acc = dao.login(email, password);
        if (acc != null) {
            request.getSession().setAttribute("account", acc);
            response.sendRedirect("home");
            return; // 
        } else {
            request.setAttribute("loginError", "Sai email hoặc mật khẩu!");
            request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
        }

    } else if ("register".equals(action)) {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String repass = request.getParameter("repeat_password");

        if (!pass.equals(repass)) {
            request.setAttribute("registerError", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
            return;
        }

        Account newAcc = new Account();
        newAcc.setU_email(email);
        newAcc.setU_pass(pass);
        newAcc.setF_name(fullName);
        newAcc.setPermission_id(2); 

        if (dao.register(newAcc)) {
            request.getSession().setAttribute("account", newAcc);
            response.sendRedirect("home");
            return; // 
        } else {
            request.setAttribute("registerError", "Đăng ký thất bại, thử lại sau!");
            request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
        }
    }
}

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập và đăng ký người dùng";
    }
}
