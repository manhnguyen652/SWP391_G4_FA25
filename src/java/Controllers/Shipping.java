
package Controllers;

// import DAL.DAO;
import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class Shipping extends HttpServlet {

   

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       
       request.getRequestDispatcher("Shipping.jsp").forward(request, response);
   
   }

   
   
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
        request.getRequestDispatcher("Shipping.jsp").forward(request, response);
   }


   @Override
   public String getServletInfo() {
       return "Short description";
   }// </editor-fold>

}
