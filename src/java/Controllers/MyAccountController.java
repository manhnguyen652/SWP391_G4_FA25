package Controllers;

import dao.AccountDAO;
import model.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "MyAccountController", urlPatterns = {"/my-account"})
public class MyAccountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("customer/my-account.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String currentPass = request.getParameter("current_password");
        String newPass = request.getParameter("new_password");
        String reNewPass = request.getParameter("repeat_password");

        // Kiểm tra mật khẩu hiện tại
        if (!acc.getU_pass().equals(currentPass)) {
            request.setAttribute("error", "Mật khẩu hiện tại không chính xác!");
            request.getRequestDispatcher("customer/my-account.jsp").forward(request, response);
        } // Kiểm tra mật khẩu mới
        else if (!newPass.equals(reNewPass)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("customer/my-account.jsp").forward(request, response);
        } // Nếu mọi thứ đều ổn
        else {
            AccountDAO dao = new AccountDAO();
            boolean success = dao.changePassword(acc.getU_id(), newPass);

            if (success) {
                // Cập nhật lại mật khẩu mới trong session
                acc.setU_pass(newPass);
                session.setAttribute("account", acc);

                // THAY ĐỔI Ở ĐÂY: Chuyển hướng về trang chủ thay vì ở lại trang
                response.sendRedirect(request.getContextPath() + "/home");

            } else {
                // Nếu có lỗi, vẫn ở lại trang và báo lỗi
                request.setAttribute("error", "Đã có lỗi xảy ra, vui lòng thử lại!");
                request.getRequestDispatcher("customer/my-account.jsp").forward(request, response);
            }
        }
    }
}
