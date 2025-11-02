package Controllers;

import DAO.OrderDAO;
import model.Account;
import model.Order;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "MyOrdersController", urlPatterns = {"/my-account/orders"})
public class MyOrdersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            System.out.println(">>> account = null");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByUserId2(acc.getU_id());

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/customer/my-account-orders.jsp").forward(request, response);   
    }

}
