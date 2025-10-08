package Controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.AccountDAO;
import Models.Account;
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
        // Sét đặt encoding UTF-8 để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();

        // Luồng xử lý cho ĐĂNG NHẬP
        if ("login".equals(action)) {
            String email = request.getParameter("login_email");
            String password = request.getParameter("login_password");

            Account acc = dao.login(email, password);
            if (acc != null) {
                // Đăng nhập thành công, lưu tài khoản vào session
                request.getSession().setAttribute("account", acc);
                // Chuyển hướng về trang chủ (giả sử là "/home")
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                // Đăng nhập thất bại, gửi thông báo lỗi lại trang login
                request.setAttribute("loginError", "Sai email hoặc mật khẩu!");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
            }

            // Luồng xử lý cho ĐĂNG KÝ
        } else if ("register".equals(action)) {
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String repass = request.getParameter("repeat_password");
            String dobString = request.getParameter("dob"); // Lấy ngày sinh từ form

            // 1. KIỂM TRA EMAIL ĐÃ TỒN TẠI CHƯA
            if (dao.checkAccountExist(email) != null) {
                request.setAttribute("registerError", "Email này đã được sử dụng!");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return; // Dừng thực thi
            }

            // 2. Kiểm tra mật khẩu nhập lại
            if (!pass.equals(repass)) {
                request.setAttribute("registerError", "Mật khẩu nhập lại không khớp!");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }

            // 3. Tách fullName thành f_name (tên) và l_name (họ)
            String firstName = "";
            String lastName = "";
            if (fullName != null && !fullName.trim().isEmpty()) {
                int lastSpaceIndex = fullName.trim().lastIndexOf(" ");
                if (lastSpaceIndex != -1) {
                    firstName = fullName.trim().substring(lastSpaceIndex + 1);
                    lastName = fullName.trim().substring(0, lastSpaceIndex);
                } else {
                    firstName = fullName.trim(); // Trường hợp chỉ có tên
                }
            }

            // 4. Chuyển đổi String ngày sinh sang java.sql.Date
            Date dob = null;
            try {
                if (dobString != null && !dobString.isEmpty()) {
                    dob = Date.valueOf(dobString);
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("registerError", "Định dạng ngày sinh không hợp lệ!");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
                return;
            }

            // 5. Tạo đối tượng Account và set giá trị
            Account newAcc = new Account();
            newAcc.setU_email(email);
            newAcc.setU_pass(pass);
            newAcc.setF_name(firstName);
            newAcc.setL_name(lastName);
            newAcc.setDob((java.sql.Date) dob);
            newAcc.setPermission_id(2); // Mặc định là khách hàng (customer)

            // 6. Thực hiện đăng ký
            if (dao.register(newAcc)) {
                // Đăng ký thành công, tự động đăng nhập và chuyển về trang chủ
                Account registeredUser = dao.login(email, pass);
                request.getSession().setAttribute("account", registeredUser);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                // Đăng ký thất bại do lỗi CSDL khác
                request.setAttribute("registerError", "Đã có lỗi xảy ra, vui lòng thử lại!");
                request.getRequestDispatcher("/customer/login_register.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập và đăng ký người dùng";
    }
}
