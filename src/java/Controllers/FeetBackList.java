package Controllers;

//import DAO.FeedbackDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
//import model.Feedback;

public class FeetBackList extends HttpServlet {

//    private final FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String q = request.getParameter("q");
        String sort = request.getParameter("sort");
        String filter = request.getParameter("filter");

//        List<Feedback> list;

//        if (q != null && !q.trim().isEmpty()) {
//            list = feedbackDAO.searchFeedback(q, sort);
//        } else {
//            list = feedbackDAO.getAllFeedback();
//        }
//
//        if (filter != null && !filter.isEmpty()) {
//            list.removeIf(f -> !f.getStatus().equalsIgnoreCase(filter));
//        }

//        request.setAttribute("feedback_list", list);
        request.getRequestDispatcher("/customer/feedback_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));

//        if ("delete".equals(action)) {
//            feedbackDAO.deleteFeedback(id);
//        } else if ("reject".equals(action)) {
//            feedbackDAO.updateStatus(id, "rejected");
//        }

        response.sendRedirect("feedback");
    }
}
