package Controllers;

import DAO.AccountDAO;
import model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }
        
        // Lấy thông tin account mới nhất từ database
        Account currentAccount = accountDAO.getAccountById(account.getU_id());
        if (currentAccount != null) {
            session.setAttribute("account", currentAccount);
            request.setAttribute("account", currentAccount);
        } else {
            request.setAttribute("account", account);
        }
        
        request.getRequestDispatcher("/customer/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(request, response, account);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, account);
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, Account account) 
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");
        
        // Validate input
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            doGet(request, response);
            return;
        }
        
        // Check if email is already used by another account
        Account existingAccount = accountDAO.getAccountByEmail(email);
        if (existingAccount != null && existingAccount.getU_id() != account.getU_id()) {
            request.setAttribute("error", "Email này đã được sử dụng bởi tài khoản khác!");
            doGet(request, response);
            return;
        }
        
        // Update account
        boolean success = accountDAO.updateUser(
            account.getU_id(),
            email,
            null, // Don't change password
            firstName,
            lastName,
            dob,
            account.getPermission_id()
        );
        
        if (success) {
            // Update session
            Account updatedAccount = accountDAO.getAccountById(account.getU_id());
            if (updatedAccount != null) {
                request.getSession().setAttribute("account", updatedAccount);
            }
            request.setAttribute("success", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("error", "Cập nhật thông tin thất bại!");
        }
        
        doGet(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, Account account) 
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            doGet(request, response);
            return;
        }
        
        // Check current password
        if (!account.getU_pass().equals(currentPassword)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            doGet(request, response);
            return;
        }
        
        // Check new password confirmation
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            doGet(request, response);
            return;
        }
        
        // Check password length
        if (newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            doGet(request, response);
            return;
        }
        
        // Update password
        boolean success = accountDAO.changePassword(account.getU_id(), newPassword);
        
        if (success) {
            // Update session
            Account updatedAccount = accountDAO.getAccountById(account.getU_id());
            if (updatedAccount != null) {
                request.getSession().setAttribute("account", updatedAccount);
            }
            request.setAttribute("success", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("error", "Đổi mật khẩu thất bại!");
        }
        
        doGet(request, response);
    }
}
