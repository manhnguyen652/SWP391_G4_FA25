package Controllers;

import DAO.AuthorDAO;
import DAO.BookDAO;
import DAO.CartDAO;
import DAO.CategoryDAO;
import DAO.PublisherDAO;
import DAO.ReviewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Author;
import model.Book;
import model.Category;
import model.Publisher;
import model.Review;

public class HomeController extends HttpServlet {

    private static final int BOOKS_PER_PAGE = 9;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String state = request.getParameter("state");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        CategoryDAO categoryDAO = new CategoryDAO();
        AuthorDAO authorDAO = new AuthorDAO();
        PublisherDAO publisherDAO = new PublisherDAO();

        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Author> authorList = authorDAO.getAllAuthors();
        List<Publisher> publisherList = publisherDAO.getAllPublishers();

        request.setAttribute("categoryList", categoryList);
        request.setAttribute("authorList", authorList);
        request.setAttribute("publisherList", publisherList);

        BookDAO bookDAO = new BookDAO();

        if (state == null) {
            String pageStr = request.getParameter("page");
            String sortOrder = request.getParameter("sortOrder");
            if (sortOrder == null || sortOrder.isEmpty()) {
                sortOrder = "default";
            }
            int currentPage = (pageStr == null) ? 1 : Integer.parseInt(pageStr);

            int totalBooks = bookDAO.getTotalBooks();
            int totalPages = (int) Math.ceil((double) totalBooks / BOOKS_PER_PAGE);

            List<Book> bookList = bookDAO.getBooksByPage(currentPage, BOOKS_PER_PAGE, sortOrder);
            
            // Lấy khoảng giá min/max cho slider
            java.util.Map<String, Double> priceRange = bookDAO.getPriceRange();

            request.setAttribute("bookList", bookList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("priceRange", priceRange);
            request.setAttribute("selectedSortOrder", sortOrder);

            request.getRequestDispatcher("/customer/home.jsp").forward(request, response);

        } else if ("detail".equals(state)) {
            String bookIdStr = request.getParameter("bookId");
            try {
                int bookId = Integer.parseInt(bookIdStr);
                Book book = bookDAO.getBookById(bookId);
                
                // Lấy danh sách reviews
                ReviewDAO reviewDAO = new ReviewDAO();
                List<Review> reviewList = reviewDAO.getReviewsByBookId(bookId);
                double averageRating = reviewDAO.getAverageRating(bookId);
                int reviewCount = reviewDAO.getReviewCount(bookId);
                
                // Kiểm tra xem user đã review chưa
                Account account = (Account) session.getAttribute("account");
                boolean hasReviewed = false;
                if (account != null) {
                    hasReviewed = reviewDAO.hasUserReviewed(bookId, account.getU_id());
                }
                
                request.setAttribute("bookDetail", book);
                request.setAttribute("reviewList", reviewList);
                request.setAttribute("averageRating", averageRating);
                request.setAttribute("reviewCount", reviewCount);
                request.setAttribute("hasReviewed", hasReviewed);
                request.getRequestDispatcher("/customer/book_detail.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }

        } else if ("cart".equals(state)) {
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login-register");
                return;
            }
            if ("add".equals(action)) {

                try {
                    int bookId = Integer.parseInt(request.getParameter("bookId"));
                    int accountId = account.getU_id();

                    CartDAO cartDAO = new CartDAO();
                    cartDAO.addToCart(accountId, bookId, 1);

                    String currentPage = request.getParameter("page");
                    currentPage = (currentPage == null || currentPage.isEmpty()) ? "1" : currentPage;
                    response.sendRedirect("home?page=" + currentPage + "&add=success");
                    return; // Dừng lại sau khi xử lý xong
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("home");
                    return;
                }
            } else {
                request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
            }
        } else if ("review".equals(state)) {
            // Xử lý submit review
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login-register");
                return;
            }
            
            String bookIdStr = request.getParameter("bookId");
            try {
                int bookId = Integer.parseInt(bookIdStr);
                ReviewDAO reviewDAO = new ReviewDAO();
                
                // Kiểm tra xem user đã review chưa
                if (reviewDAO.hasUserReviewed(bookId, account.getU_id())) {
                    response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=already_reviewed");
                    return;
                }
                
                // Lấy thông tin từ form
                String ratingStr = request.getParameter("rating");
                String comment = request.getParameter("comment");
                
                if (ratingStr != null && !ratingStr.isEmpty() && comment != null && !comment.trim().isEmpty()) {
                    int rating = Integer.parseInt(ratingStr);
                    if (rating >= 1 && rating <= 5) {
                        Review review = new Review(bookId, account.getU_id(), rating, comment.trim());
                        if (reviewDAO.addReview(review)) {
                            response.sendRedirect("home?state=detail&bookId=" + bookId + "&review=success");
                        } else {
                            response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=review_failed");
                        }
                    } else {
                        response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=invalid_rating");
                    }
                } else {
                    response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=missing_fields");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        } else if ("editReview".equals(state)) {
            // Xử lý edit review - GET để hiển thị form
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login-register");
                return;
            }
            
            String reviewIdStr = request.getParameter("reviewId");
            try {
                int reviewId = Integer.parseInt(reviewIdStr);
                ReviewDAO reviewDAO = new ReviewDAO();
                
                // Kiểm tra quyền sở hữu
                if (!reviewDAO.isReviewOwner(reviewId, account.getU_id())) {
                    response.sendRedirect("home?error=unauthorized");
                    return;
                }
                
                Review review = reviewDAO.getReviewById(reviewId);
                if (review != null) {
                    request.setAttribute("editReview", review);
                    Book book = bookDAO.getBookById(review.getBookId());
                    request.setAttribute("bookDetail", book);
                    
                    // Lấy danh sách reviews
                    List<Review> reviewList = reviewDAO.getReviewsByBookId(review.getBookId());
                    double averageRating = reviewDAO.getAverageRating(review.getBookId());
                    int reviewCount = reviewDAO.getReviewCount(review.getBookId());
                    boolean hasReviewed = reviewDAO.hasUserReviewed(review.getBookId(), account.getU_id());
                    
                    request.setAttribute("reviewList", reviewList);
                    request.setAttribute("averageRating", averageRating);
                    request.setAttribute("reviewCount", reviewCount);
                    request.setAttribute("hasReviewed", hasReviewed);
                    
                    request.getRequestDispatcher("/customer/book_detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect("home?error=review_not_found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        } else if ("deleteReview".equals(state)) {
            // Xử lý delete review
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login-register");
                return;
            }
            
            String reviewIdStr = request.getParameter("reviewId");
            try {
                int reviewId = Integer.parseInt(reviewIdStr);
                ReviewDAO reviewDAO = new ReviewDAO();
                
                // Kiểm tra quyền sở hữu
                if (!reviewDAO.isReviewOwner(reviewId, account.getU_id())) {
                    response.sendRedirect("home?error=unauthorized");
                    return;
                }
                
                Review review = reviewDAO.getReviewById(reviewId);
                if (review != null) {
                    int bookId = review.getBookId();
                    if (reviewDAO.deleteReview(reviewId)) {
                        response.sendRedirect("home?state=detail&bookId=" + bookId + "&delete=success");
                    } else {
                        response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=delete_failed");
                    }
                } else {
                    response.sendRedirect("home?error=review_not_found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        } else {

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String state = request.getParameter("state");
        HttpSession session = request.getSession();
        
        if ("review".equals(state)) {
            // Xử lý submit review từ POST
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login-register");
                return;
            }
            
            String bookIdStr = request.getParameter("bookId");
            try {
                int bookId = Integer.parseInt(bookIdStr);
                ReviewDAO reviewDAO = new ReviewDAO();
                
                // Kiểm tra xem user đã review chưa
                if (reviewDAO.hasUserReviewed(bookId, account.getU_id())) {
                    response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=already_reviewed");
                    return;
                }
                
                // Lấy thông tin từ form
                String ratingStr = request.getParameter("rating");
                String comment = request.getParameter("comment");
                
                if (ratingStr != null && !ratingStr.isEmpty() && comment != null && !comment.trim().isEmpty()) {
                    int rating = Integer.parseInt(ratingStr);
                    if (rating >= 1 && rating <= 5) {
                        Review review = new Review(bookId, account.getU_id(), rating, comment.trim());
                        if (reviewDAO.addReview(review)) {
                            response.sendRedirect("home?state=detail&bookId=" + bookId + "&review=success");
                        } else {
                            response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=review_failed");
                        }
                    } else {
                        response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=invalid_rating");
                    }
                } else {
                    response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=missing_fields");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        } else if ("updateReview".equals(state)) {
            // Xử lý cập nhật review từ POST
            Account account = (Account) session.getAttribute("account");
            if (account == null) {
                response.sendRedirect("login-register");
                return;
            }
            
            String reviewIdStr = request.getParameter("reviewId");
            try {
                int reviewId = Integer.parseInt(reviewIdStr);
                ReviewDAO reviewDAO = new ReviewDAO();
                
                // Kiểm tra quyền sở hữu
                if (!reviewDAO.isReviewOwner(reviewId, account.getU_id())) {
                    response.sendRedirect("home?error=unauthorized");
                    return;
                }
                
                Review review = reviewDAO.getReviewById(reviewId);
                if (review != null) {
                    int bookId = review.getBookId();
                    String ratingStr = request.getParameter("rating");
                    String comment = request.getParameter("comment");
                    
                    if (ratingStr != null && !ratingStr.isEmpty() && comment != null && !comment.trim().isEmpty()) {
                        int rating = Integer.parseInt(ratingStr);
                        if (rating >= 1 && rating <= 5) {
                            if (reviewDAO.updateReview(reviewId, rating, comment.trim())) {
                                response.sendRedirect("home?state=detail&bookId=" + bookId + "&update=success");
                            } else {
                                response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=update_failed");
                            }
                        } else {
                            response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=invalid_rating");
                        }
                    } else {
                        response.sendRedirect("home?state=detail&bookId=" + bookId + "&error=missing_fields");
                    }
                } else {
                    response.sendRedirect("home?error=review_not_found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        }
    }

}
