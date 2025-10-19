package Controllers;

//import DAO.ShippingDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

public class Shipping extends HttpServlet {

    private static final int ORDERS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filter = request.getParameter("filter");
        String search = request.getParameter("q");
        String sort = request.getParameter("sort");
        String pageStr = request.getParameter("page");

        int currentPage = (pageStr == null) ? 1 : Integer.parseInt(pageStr);

//        ShippingDAO dao = new ShippingDAO();
//        int totalOrders = dao.getTotalOrders(filter, search);
//        int totalPages = (int) Math.ceil((double) totalOrders / ORDERS_PER_PAGE);
//
//        List<Order> orderList = dao.getOrders(filter, search, sort, currentPage, ORDERS_PER_PAGE);

//        request.setAttribute("orderList", orderList);
//        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("filter", filter);
        request.setAttribute("q", search);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("/customer/shipping.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        try {
            int orderId = Integer.parseInt(idStr);
//            ShippingDAO dao = new ShippingDAO();

//            if ("start".equals(action)) {
//                dao.updateOrderStatus(orderId, "Shipping");
//            } else if ("cancel".equals(action)) {
//                dao.updateOrderStatus(orderId, "Canceled");
//            }

            response.sendRedirect("shipping");
        } catch (NumberFormatException e) {
            response.sendRedirect("shipping");
        }
    }
}