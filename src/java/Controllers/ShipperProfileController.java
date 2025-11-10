package Controllers;

import DAO.ShipperDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.ShipperProfile;

@WebServlet(name = "ShipperProfileController", urlPatterns = {"/shipperProfile"})
public class ShipperProfileController extends HttpServlet {

    private final ShipperDAO shipperDAO = new ShipperDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account account = session != null ? (Account) session.getAttribute("account") : null;

        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        if (account.getPermission_id() != 4) {
            response.sendRedirect("home");
            return;
        }

        ShipperProfile profile = shipperDAO.getProfileByAccountId(account.getU_id());
        if (profile == null) {
            profile = new ShipperProfile();
            profile.setAccountId(account.getU_id());
        }

        String flash = (String) session.getAttribute("shipperProfileFlash");
        String flashType = (String) session.getAttribute("shipperProfileFlashType");
        session.removeAttribute("shipperProfileFlash");
        session.removeAttribute("shipperProfileFlashType");

        request.setAttribute("shipper", profile);
        request.setAttribute("flash", flash);
        request.setAttribute("flashType", flashType);

        request.getRequestDispatcher("/customer/shipperProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account account = session != null ? (Account) session.getAttribute("account") : null;

        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        if (account.getPermission_id() != 4) {
            response.sendRedirect("home");
            return;
        }

        String phone = request.getParameter("phone");
        String vehicle = request.getParameter("vehicle");
        String region = request.getParameter("region");

        if (isBlank(phone) || isBlank(vehicle) || isBlank(region)) {
            setFlash(session, "Vui lòng điền đầy đủ thông tin.", "error");
            response.sendRedirect("shipperProfile");
            return;
        }

        ShipperProfile profile = new ShipperProfile();
        profile.setAccountId(account.getU_id());
        profile.setPhone(phone.trim());
        profile.setVehicleNumber(vehicle.trim());
        profile.setRegion(region.trim());

        boolean success = shipperDAO.upsertProfile(profile);
        if (success) {
            setFlash(session, "Cập nhật thông tin thành công.", "success");
        } else {
            setFlash(session, "Không thể lưu thông tin. Vui lòng thử lại.", "error");
        }

        response.sendRedirect("shipperProfile");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void setFlash(HttpSession session, String message, String type) {
        session.setAttribute("shipperProfileFlash", message);
        session.setAttribute("shipperProfileFlashType", type);
    }
}

