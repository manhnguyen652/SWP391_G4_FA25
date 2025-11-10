package Controllers;

import DAO.OrderDAO;
import DAO.ShippingDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Shipping;

@WebServlet(name = "ShippingController", urlPatterns = {"/shipping"})
public class ShippingController extends HttpServlet {

    private static final int ORDERS_PER_PAGE = 10;

    private final ShippingDAO shippingDAO = new ShippingDAO();
    private final OrderDAO orderDAO = new OrderDAO();

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

        String filter = request.getParameter("filter");
        String normalizedFilter = normalizeStatus(filter);
        String search = request.getParameter("q");
        String sort = request.getParameter("sort");
        String pageStr = request.getParameter("page");

        int currentPage;
        try {
            currentPage = (pageStr == null) ? 1 : Math.max(Integer.parseInt(pageStr), 1);
        } catch (NumberFormatException ex) {
            currentPage = 1;
        }

        List<Shipping> shipments = shippingDAO.getAllShipping(
                account.getU_id(),
                currentPage,
                ORDERS_PER_PAGE,
                normalizedFilter,
                search,
                sort
        );

        int totalRecords = shippingDAO.getTotalRecords(account.getU_id(), normalizedFilter, search);
        int totalPages = (int) Math.ceil(totalRecords / (double) ORDERS_PER_PAGE);
        if (totalPages == 0) {
            totalPages = 1;
        }

        Map<String, Integer> statusCounters = shippingDAO.getStatusCounters(account.getU_id());

        String flash = (String) session.getAttribute("shippingFlash");
        String flashType = (String) session.getAttribute("shippingFlashType");
        session.removeAttribute("shippingFlash");
        session.removeAttribute("shippingFlashType");

        request.setAttribute("shipments", shipments);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("filter", filter);
        request.setAttribute("q", search);
        request.setAttribute("sort", sort);
        request.setAttribute("pageSize", ORDERS_PER_PAGE);
        request.setAttribute("statusCounters", statusCounters);
        request.setAttribute("flash", flash);
        request.setAttribute("flashType", flashType);

        request.getRequestDispatcher("/customer/shipping.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        try {
            int shippingId = Integer.parseInt(idStr);
            Shipping shipment = shippingDAO.getShippingById(shippingId);

            if (shipment == null || shipment.getShipperId() != account.getU_id()) {
                setFlash(session, "Không tìm thấy đơn giao hàng hoặc bạn không có quyền truy cập.", "error");
                response.sendRedirect("shipping");
                return;
            }

            String currentStatus = shipment.getStatus();
            String targetStatus = resolveTargetStatus(action);

            if (targetStatus == null) {
                setFlash(session, "Thao tác không hợp lệ.", "error");
                response.sendRedirect("shipping");
                return;
            }

            if (!isValidTransition(currentStatus, targetStatus)) {
                setFlash(session, "Không thể chuyển trạng thái từ " + currentStatus + " sang " + targetStatus + ".", "error");
                response.sendRedirect("shipping");
                return;
            }

            boolean updated = shippingDAO.updateStatus(shippingId, account.getU_id(), targetStatus);

            if (updated) {
                updateOrderStatus(shipment.getOrderId(), targetStatus);
                setFlash(session, "Cập nhật trạng thái đơn hàng thành công.", "success");
            } else {
                setFlash(session, "Cập nhật trạng thái thất bại. Vui lòng thử lại.", "error");
            }
        } catch (NumberFormatException ex) {
            setFlash(session, "Mã đơn hàng không hợp lệ.", "error");
        }

        response.sendRedirect("shipping");
    }

    private void updateOrderStatus(int orderId, String targetStatus) {
        switch (targetStatus) {
            case "Shipping":
                orderDAO.updateOrderStatus(orderId, 3); // Đang giao hàng
                break;
            case "Delivered":
                orderDAO.updateOrderStatus(orderId, 4); // Đã giao hàng
                break;
            case "Canceled":
                orderDAO.updateOrderStatus(orderId, 5); // Đã hủy
                break;
            default:
                orderDAO.updateOrderStatus(orderId, 2); // Đã xác nhận
                break;
        }
    }

    private String normalizeStatus(String filter) {
        if (filter == null || filter.trim().isEmpty()) {
            return null;
        }
        String trimmed = filter.trim().toLowerCase();
        return Character.toUpperCase(trimmed.charAt(0)) + trimmed.substring(1);
    }

    private String resolveTargetStatus(String action) {
        if ("start".equalsIgnoreCase(action)) {
            return "Shipping";
        }
        if ("complete".equalsIgnoreCase(action)) {
            return "Delivered";
        }
        if ("cancel".equalsIgnoreCase(action)) {
            return "Canceled";
        }
        return null;
    }

    private boolean isValidTransition(String currentStatus, String targetStatus) {
        if (currentStatus == null || targetStatus == null) {
            return false;
        }

        if (currentStatus.equals(targetStatus)) {
            return false;
        }

        switch (currentStatus) {
            case "Pending":
            case "Confirmed":
                return "Shipping".equals(targetStatus) || "Canceled".equals(targetStatus);
            case "Shipping":
                return "Delivered".equals(targetStatus) || "Canceled".equals(targetStatus);
            case "Delivered":
            case "Canceled":
                return false;
            default:
                return false;
        }
    }

    private void setFlash(HttpSession session, String message, String type) {
        session.setAttribute("shippingFlash", message);
        session.setAttribute("shippingFlashType", type);
    }
}