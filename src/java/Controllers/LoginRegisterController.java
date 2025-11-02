package Controllers;

import java.io.IOException;
import java.time.Instant;
import java.util.Hashtable;
import java.util.Set;
import javax.naming.directory.*;
import javax.naming.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import DAO.AccountDAO;
import model.Account;
import utils.EmailUtility;
import javax.mail.MessagingException;
import javax.mail.SendFailedException;

@WebServlet("/login-register")
public class LoginRegisterController extends HttpServlet {

    // 🔹 KIỂM TRA ĐỊNH DẠNG EMAIL
    private boolean isValidEmailFormat(String email) {
        if (email == null) {
            return false;
        }
        String regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(regex);
    }

    // 🔹 KIỂM TRA EMAIL THẬT SỰ TỒN TẠI BẰNG KICKBOX API
    private boolean verifyWithKickbox(String email) {
        try {
            String apiKey = "live_ca9344c306539653d66ee48421ad7e383f9cfd538f32f72b8f10713575bd8bb8"; // ⚠️ Thay bằng API Key thật của bạn
            String apiUrl = "https://api.kickbox.com/v2/verify?email=" + email + "&apikey=" + apiKey;

            java.net.URL url = new java.net.URL(apiUrl);
            java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.connect();

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                System.out.println("Kickbox API error: " + responseCode);
                return true; // Không chặn khi API lỗi
            }

            java.io.BufferedReader reader = new java.io.BufferedReader(
                    new java.io.InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            reader.close();

            String json = sb.toString().toLowerCase();
            // Nếu kết quả trả về là undeliverable => email không tồn tại
            return !(json.contains("\"result\":\"undeliverable\"") || json.contains("\"reason\":\"invalid_email\""));

        } catch (Exception e) {
            e.printStackTrace();
            return true; // Không chặn khi lỗi mạng hoặc API
        }
    }

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
        HttpSession session = request.getSession();

        // 🟢 ĐĂNG NHẬP
        if ("login".equals(action)) {
            String email = request.getParameter("login_email");
            String password = request.getParameter("login_password");

            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("loginError", "Email và mật khẩu không được để trống!");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }

            Account acc = dao.login(email, password);
            if (acc != null) {
                session.setAttribute("account", acc);

                int role = acc.getPermission_id();
                String url = "home"; 

                switch (role) {
                    case 1: // Admin
                        url = "staff-dashboard"; 
                        break;
                    case 2: // Customer
                        url = "home";
                        break;
                    case 3: // Staff
                        url = "staff/book-management"; 
                        break;
                    case 4: // Shipper
                        url = "/customer/shipping.jsp"; 
                        break;
                    default:
                        url = "home"; 
                }
                response.sendRedirect(url);
            } else {
                request.setAttribute("loginError", "Sai email hoặc mật khẩu, hoặc tài khoản chưa xác thực!");
                request.setAttribute("login_email", email);
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
            }

            // 🟡 ĐĂNG KÝ
        } else if ("register".equals(action)) {
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String repass = request.getParameter("repeat_password");

            // Kiểm tra rỗng
            if (fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || pass == null || pass.trim().isEmpty()
                    || repass == null || repass.trim().isEmpty()) {
                request.setAttribute("registerError", "Vui lòng điền đầy đủ thông tin!");
                request.setAttribute("fullname", fullName);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra định dạng email
            if (!isValidEmailFormat(email)) {
                request.setAttribute("registerError", "Email không hợp lệ! (vd: example@gmail.com)");
                request.setAttribute("fullname", fullName);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }
            // 🔹 Kiểm tra email tồn tại thật qua Kickbox
            if (!verifyWithKickbox(email)) {
                request.setAttribute("registerError", "Email không tồn tại hoặc không thể nhận thư!");
                request.setAttribute("fullname", fullName);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu khớp
            if (!pass.equals(repass)) {
                request.setAttribute("registerError", "Mật khẩu nhập lại không khớp!");
                request.setAttribute("fullname", fullName);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra email đã tồn tại
            if (dao.checkAccountExist(email) != null) {
                request.setAttribute("registerError", "Email đã được sử dụng!");
                request.setAttribute("fullname", fullName);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }

            // Tạo tài khoản mới
            Account newAcc = new Account();
            newAcc.setU_email(email);
            newAcc.setU_pass(pass);
            newAcc.setF_name(fullName);
            newAcc.setPermission_id(2);

            if (dao.register(newAcc)) {
                String code = String.format("%06d", (int) (Math.random() * 1000000));
                dao.updateVerificationCode(email, code);

                try {
                    String subject = "Xác thực tài khoản của bạn";
                    String message = "<h3>Mã xác thực của bạn là:</h3><h2>" + code + "</h2>"
                            + "<p>Vui lòng nhập mã này trên trang xác thực để kích hoạt tài khoản.</p>";

                    // 🔴 Gửi email xác thực và bắt lỗi gửi
                    EmailUtility.sendEmail(email, subject, message);

                } catch (SendFailedException e) {
                    request.setAttribute("registerError", "Email không tồn tại hoặc không thể nhận thư!");
                    request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                    return;
                } catch (MessagingException e) {
                    String msg = e.getMessage();
                    if (msg != null && msg.contains("550 5.1.1")) {
                        request.setAttribute("registerError", "Email không tồn tại hoặc bị từ chối!");
                    } else {
                        request.setAttribute("registerError", "Không thể gửi email xác thực. Vui lòng thử lại sau!");
                    }
                    request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                    return;
                } catch (Exception e) {
                    request.setAttribute("registerError", "Gửi email xác thực thất bại!");
                    request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                    return;
                }

                session.setAttribute("lastResendTime", Instant.now());
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/verify.jsp").forward(request, response);

            } else {
                request.setAttribute("registerError", "Đăng ký thất bại, thử lại sau!");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
            }

            // 🔵 XÁC THỰC TÀI KHOẢN
        } else if ("verify".equals(action)) {
            String email = request.getParameter("email");
            String code = request.getParameter("code");

            if (dao.verifyAccount(email, code)) {
                request.setAttribute("success", "Xác thực thành công! Hãy đăng nhập.");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Mã xác thực không đúng hoặc đã hết hạn!");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/customer/verify.jsp").forward(request, response);
            }

            // 🟠 GỬI LẠI MÃ
        } else if ("resend".equals(action)) {
            String email = request.getParameter("email");
            Instant lastResendTime = (Instant) session.getAttribute("lastResendTime");
            Instant now = Instant.now();

            if (lastResendTime != null && now.isBefore(lastResendTime.plusSeconds(60))) {
                long remaining = 60 - (now.getEpochSecond() - lastResendTime.getEpochSecond());
                request.setAttribute("email", email);
                request.setAttribute("error", "Vui lòng chờ " + remaining + " giây trước khi gửi lại mã.");
                request.getRequestDispatcher("/customer/verify.jsp").forward(request, response);
                return;
            }

            String code = String.format("%06d", (int) (Math.random() * 1000000));
            dao.updateVerificationCode(email, code);

            try {
                String subject = "Mã xác thực mới của bạn";
                String message = "<p>Bạn vừa yêu cầu gửi lại mã xác thực tài khoản.</p>"
                        + "<h2>" + code + "</h2>"
                        + "<p>Nếu bạn không yêu cầu, vui lòng bỏ qua email này.</p>";
                EmailUtility.sendEmail(email, subject, message);
            } catch (Exception e) {
                request.setAttribute("error", "Không thể gửi lại mã xác thực, vui lòng thử lại sau!");
            }

            session.setAttribute("lastResendTime", now);
            request.setAttribute("email", email);
            request.setAttribute("resendMsg", "Mã xác thực mới đã được gửi đến email của bạn!");
            request.getRequestDispatcher("/customer/verify.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập, đăng ký, xác thực và kiểm tra email thực qua Kickbox";
    }
}
