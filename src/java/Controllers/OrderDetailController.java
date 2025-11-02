package Controllers;

import DAO.OrderDetailDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.OrderDetail;

@WebServlet(name = "OrderDetailController", urlPatterns = {"/my-account-order-detail"})
public class OrderDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/my-account/orders");
            return;
        }

        int orderId = Integer.parseInt(idStr);

        OrderDetailDAO dao = new OrderDetailDAO();
        List<OrderDetail> details = dao.getOrderDetailsByOrderId(orderId);

        System.out.println(">>> order details size: " + details.size()); // debug

        request.setAttribute("orderDetails", details);
        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("/customer/my-account-order-detail.jsp").forward(request, response);
    }
}
