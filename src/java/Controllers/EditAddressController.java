package Controllers;

import DAO.UserInformationDAO;
import model.Account;
import model.UserInformation;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "EditAddressController", urlPatterns = {"/edit-address"})
public class EditAddressController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login_register.jsp");
            return;
        }

        UserInformationDAO dao = new UserInformationDAO();
        UserInformation info = dao.getUserInfoByUserId(acc.getU_id());
        request.setAttribute("info", info);

        request.getRequestDispatcher("customer/edit-address.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/customer/login_register.jsp");
            return;
        }

        String address = request.getParameter("address");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");

        UserInformationDAO dao = new UserInformationDAO();
        boolean success = dao.updateUserInfo(acc.getU_id(), address, country, phone);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/my-account?section=address");
        } else {
            request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại!");
            request.getRequestDispatcher("customer/edit-address.jsp").forward(request, response);
        }
    }
}
