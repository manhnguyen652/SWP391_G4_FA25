//package Controllers;
//
////import DAO.FeedbackDAO;
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.util.List;
//import DAO.FeedbackDAO;
//import Model.Feedback;
//import jakarta.servlet.annotation.WebServlet;
////import model.Feedback;
//
//@WebServlet("/feedback")
//public class FeedbackList extends HttpServlet {
//    FeedbackDAO dao = new FeedbackDAO();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String search = request.getParameter("q");
//        String sort = request.getParameter("sort");
//        String filter = request.getParameter("filter");
//
//        List<Feedback> list = dao.getAllFeedback(search, sort, filter);
//
//        request.setAttribute("feedback_list", list);
//        request.getRequestDispatcher("/customer/feedback_list.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        String action = request.getParameter("action");
//
//        switch (action) {
//            case "delete":
//                dao.deleteFeedback(id);
//                break;
//            case "reject":
//                dao.updateStatus(id, "rejected");
//                break;
//        }
//
//        response.sendRedirect("feedback");
//    }
//}