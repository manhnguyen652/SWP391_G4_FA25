package Controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // Thêm import này
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String state = request.getParameter("state");
        if (state == null) {
            
            request.getRequestDispatcher("/customer/home.jsp").forward(request, response);
        } else if ("detail".equals(state)) {
            
            request.getRequestDispatcher("/customer/book_detail.jsp").forward(request, response);
        }else if("cart".equals(state)){
            
            request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
        }else{
            
            
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
}