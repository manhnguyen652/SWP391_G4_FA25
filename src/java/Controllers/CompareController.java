package Controllers;

import DAO.CompareDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections; // Import Collections
import java.util.List;
import model.Account;
import model.Book;

@WebServlet(name = "CompareController", urlPatterns = {"/compare"})
public class CompareController extends HttpServlet {

     private static final int MAX_COMPARE_ITEMS = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        String action = request.getParameter("action");

        if (account == null) {
            response.sendRedirect("login-register");
            return;
        }

        CompareDAO compareDAO = new CompareDAO();
        int userId = account.getU_id();

        if ("add".equals(action)) {
             // ... Code xử lý add ...
            String bookIdStr = request.getParameter("bookId");
            String referer = request.getHeader("Referer");
            String redirectUrl = (referer != null && !referer.isEmpty()) ? referer : "home";

            if (bookIdStr == null) {
                 response.sendRedirect(redirectUrl + (redirectUrl.contains("?") ? "&" : "?") + "compare_add=error_invalid");
                 return;
            }

            try {
                int bookId = Integer.parseInt(bookIdStr);
                boolean added = compareDAO.addToCompare(userId, bookId);

                String paramPrefix = redirectUrl.contains("?") ? "&" : "?";
                if (added) {
                     redirectUrl += paramPrefix + "compare_add=success";
                } else {
                     int currentCount = compareDAO.getCompareItemCount(userId);
                     if(currentCount >= MAX_COMPARE_ITEMS) {
                         redirectUrl += paramPrefix + "compare_add=error_full";
                     } else {
                         redirectUrl += paramPrefix + "compare_add=error_exists";
                     }
                }
                response.sendRedirect(redirectUrl);
                return;

            } catch (NumberFormatException e) {
                 response.sendRedirect(redirectUrl + (redirectUrl.contains("?") ? "&" : "?") + "compare_add=error_invalid");
                 return;
            } catch (Exception e) {
                e.printStackTrace();
                 response.sendRedirect(redirectUrl + (redirectUrl.contains("?") ? "&" : "?") + "compare_add=error_general");
                 return;
            }

        } else if ("remove".equals(action)) {
            // ... Code xử lý remove ...
            String itemIdStr = request.getParameter("itemId");
             if(itemIdStr == null){
                 response.sendRedirect("compare?error=invalid_remove");
                 return;
             }
            try {
                 int compareItemId = Integer.parseInt(itemIdStr);
                 compareDAO.removeFromCompare(compareItemId);
                 response.sendRedirect("compare?remove=success");
                 return;
            } catch (NumberFormatException e){
                 response.sendRedirect("compare?error=invalid_remove");
                 return;
            } catch (Exception e) {
                 e.printStackTrace();
                 response.sendRedirect("compare?error=remove_failed");
                 return;
            }
        }
        else {
             // ---> BỌC TRONG TRY-CATCH <---
            try {
                System.out.println("CompareController: Fetching compare items for user ID: " + userId);
                List<Book> compareItems = compareDAO.getCompareItems(userId);
                // Đảm bảo compareItems không bao giờ null, trả về list rỗng nếu có lỗi
                if (compareItems == null) {
                     compareItems = Collections.emptyList(); // Sử dụng list rỗng
                     System.err.println("CompareController: getCompareItems returned null, using empty list.");
                }
                System.out.println("CompareController: Found " + compareItems.size() + " items.");

                request.setAttribute("compareItems", compareItems);
                request.setAttribute("MAX_COMPARE_ITEMS", MAX_COMPARE_ITEMS);

                System.out.println("CompareController: Forwarding to /customer/compare.jsp");
                request.getRequestDispatcher("/customer/compare.jsp").forward(request, response);

            } catch (Exception e) {
                System.err.println("!!! ERROR in CompareController while displaying list !!!");
                e.printStackTrace();
                 // Gửi lỗi hoặc chuyển đến trang lỗi
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải trang so sánh sản phẩm.");
            }
            // ---> KẾT THÚC TRY-CATCH <---
        }
    }

     @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}