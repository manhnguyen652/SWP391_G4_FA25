package Controllers;

import DAO.AccountDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;
import utils.EmailUtility;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khi người dùng nhấn "Quên mật khẩu?" → chuyển đến trang nhập email
        request.getRequestDispatcher("/customer/forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();

        // 🟢 BƯỚC 1: GỬI MÃ KHÔI PHỤC
        if ("send".equals(action)) {
            String email = request.getParameter("email");
            Account acc = dao.getAccountByEmail(email);

            if (acc == null) {
                request.setAttribute("error", "Email này chưa được đăng ký!");
                request.getRequestDispatcher("/customer/forgot_password.jsp").forward(request, response);
                return;
            }

            // Sinh mã OTP
            String code = String.format("%06d", (int) (Math.random() * 1000000));
            dao.updateVerificationCode(email, code);

            try {
                String subject = "Mã khôi phục mật khẩu của bạn";
                String message = "<p>Xin chào " + acc.getF_name() + ",</p>"
                        + "<p>Bạn vừa yêu cầu đặt lại mật khẩu cho tài khoản tại Pustok Bookstore.</p>"
                        + "<h3>Mã khôi phục của bạn là: <strong>" + code + "</strong></h3>"
                        + "<p>Mã có hiệu lực trong 10 phút.</p>";

                EmailUtility.sendEmail(email, subject, message);

                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/verify_reset.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại sau!");
                request.getRequestDispatcher("/customer/forgot_password.jsp").forward(request, response);
            }

        // 🟡 BƯỚC 2: XÁC NHẬN MÃ OTP
        } else if ("verify".equals(action)) {
            String email = request.getParameter("email");
            String code = request.getParameter("code");

            if (dao.verifyAccount(email, code)) {
                // Nếu mã đúng → cho phép đổi mật khẩu
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/reset_password.jsp").forward(request, response);
            } else {
                request.setAttribute("email", email);
                request.setAttribute("error", "Mã xác nhận không đúng hoặc đã hết hạn!");
                request.getRequestDispatcher("/customer/verify_reset.jsp").forward(request, response);
            }

        // 🔵 BƯỚC 3: ĐỔI MẬT KHẨU MỚI
        } else if ("reset".equals(action)) {
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String repass = request.getParameter("repeat_password");

            if (pass == null || repass == null || !pass.equals(repass)) {
                request.setAttribute("email", email);
                request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
                request.getRequestDispatcher("/customer/reset_password.jsp").forward(request, response);
                return;
            }

            boolean updated = dao.changePasswordByEmail(email, pass);
            if (updated) {
                request.setAttribute("success", "Đặt lại mật khẩu thành công! Hãy đăng nhập lại.");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Lỗi khi đặt lại mật khẩu. Vui lòng thử lại!");
                request.getRequestDispatcher("/customer/reset_password.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý quên mật khẩu (gửi mã OTP, xác minh mã, đặt lại mật khẩu)";
    }
}
