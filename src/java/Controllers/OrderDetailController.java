package Controllers;

import DAO.OrderDetailDAO;
import model.OrderDetail;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "OrderDetailController", urlPatterns = {"/my-account-order-detail"})
public class OrderDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/my-account/orders");
            return;
        }

        int orderId = Integer.parseInt(idParam);

        OrderDetailDAO dao = new OrderDetailDAO();
        List<OrderDetail> details = dao.getOrderDetailsByOrderId(orderId);

        // Gửi dữ liệu sang JSP
        request.setAttribute("orderDetails", details);
        request.setAttribute("orderId", orderId);

        request.getRequestDispatcher("/customer/my-account-order-detail.jsp").forward(request, response);
    }
}
