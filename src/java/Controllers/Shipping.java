
package Controllers;

import DAL.DAO;
import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class Shipping extends HttpServlet {

    DAO dao;

    @Override
    public void init() throws ServletException {
        dao = new DAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        dao.Ins.loadOrdersForShipper(account.getAccountId());

        if (request.getParameter("subpageIndex") == null) {
            request.setAttribute("clickedSubpageIndex", 1);
        }

        request.setAttribute("dao", dao.Ins);
        request.getRequestDispatcher("Shipping.jsp").forward(request, response);
    
    }

    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
