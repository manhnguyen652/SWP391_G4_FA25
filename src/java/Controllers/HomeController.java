package Controllers;

import dao.BookDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Book;

public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String state = request.getParameter("state");
        if (state == null) {
            BookDAO bookDAO = new BookDAO();
            List<Book> bookList = bookDAO.getAllBooks();
            request.setAttribute("bookList", bookList);
            request.getRequestDispatcher("/customer/home.jsp").forward(request, response);
        } else if ("detail".equals(state)) {
            
            request.getRequestDispatcher("/customer/book_detail.jsp").forward(request, response);
        }else if("cart".equals(state)){
            
            request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
        }else{
            
            
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
}