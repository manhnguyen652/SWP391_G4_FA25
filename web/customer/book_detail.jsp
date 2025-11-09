
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">


    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pustok - Book Store</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Use Minified Plugins Version For Fast Page Load -->
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
    </head>

    <body>
        <div class="site-wrapper" id="top">
            <jsp:include page="./common/header.jsp"></jsp:include>
                <section class="breadcrumb-section">
                    <h2 class="sr-only">Site Breadcrumb</h2>
                    <div class="container">
                        <div class="breadcrumb-contents">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                                    <li class="breadcrumb-item active">Product Details</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>
                <main class="inner-page-sec-padding-bottom">
                    <div class="container">
                        <div class="row  mb--60">
                            <div class="col-lg-5 mb--30">
                                <!-- Product Details Slider Big Image-->
                                <div class="product-details-slider sb-slick-slider arrow-type-two" data-slick-setting='{
                                     "slidesToShow": 1,
                                     "arrows": false,
                                     "fade": true,
                                     "draggable": false,
                                     "swipe": false,
                                     "asNavFor": ".product-slider-nav"
                                     }'>
                                    <div class="single-slide">
                                        <img src="${pageContext.request.contextPath}/customer/image/products/product-details-1.jpg" alt="">
                                    </div>
                                    <div class="single-slide">
                                        <img src="${pageContext.request.contextPath}/customer/image/products/product-details-2.jpg" alt="">
                                    </div>
                                    <div class="single-slide">
                                        <img src="${pageContext.request.contextPath}/customer/image/products/product-details-3.jpg" alt="">
                                    </div>
                                    <div class="single-slide">
                                        <img src="${pageContext.request.contextPath}/customer/image/products/product-details-4.jpg" alt="">
                                    </div>
                                    <div class="single-slide">
                                        <img src="${pageContext.request.contextPath}/customer/image/products/product-details-5.jpg" alt="">
                                    </div>
                                </div>
                                <!-- Product Details Slider Nav -->
                                <div class="mt--30 product-slider-nav sb-slick-slider arrow-type-two" data-slick-setting='{
                                     "infinite":true,
                                     "autoplay": true,
                                     "autoplaySpeed": 8000,
                                     "slidesToShow": 4,
                                     "arrows": true,
                                     "prevArrow":{"buttonClass": "slick-prev","iconClass":"fa fa-chevron-left"},
                                     "nextArrow":{"buttonClass": "slick-next","iconClass":"fa fa-chevron-right"},
                                     "asNavFor": ".product-details-slider",
                                     "focusOnSelect": true
                                     }'>
                                    <div class="single-slide">
                                        <img src="${pageContext.request.contextPath}/customer/image/products/product-details-1.jpg" alt="">
                                </div>
                                <div class="single-slide">
                                    <img src="${pageContext.request.contextPath}/customer/image/products/product-details-2.jpg" alt="">
                                </div>
                                <div class="single-slide">
                                    <img src="${pageContext.request.contextPath}/customer/image/products/product-details-3.jpg" alt="">
                                </div>
                                <div class="single-slide">
                                    <img src="${pageContext.request.contextPath}/customer/image/products/product-details-4.jpg" alt="">
                                </div>
                                <div class="single-slide">
                                    <img src="${pageContext.request.contextPath}/customer/image/products/product-details-5.jpg" alt="">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <div class="product-details-info pl-lg--30 ">
                                <p class="tag-block">Tags: <a href="#">Phép thuật</a>, <a href="#">Phiêu lưu</a></p>
                                <h3 class="product-title">${bookDetail.BTitle}</h3>
                                <ul class="list-unstyled">
                                    <!--                                    <li>Ex Tax: <span class="list-value"> £60.24</span></li>-->
                                    <li>Tác giả: <span class="list-value"> ${bookDetail.authorName}</span></li>
                                    <li>Nhà xuất bản: <a href="#" class="list-value font-weight-bold">Mặt trời</a></li>
                                    <li>Năm xuất bản: <span class="list-value"> 200</span></li>
                                    <li>Trong kho: <span class="list-value"> Còn hàng</span></li>
                                </ul>
                                <div class="price-block">
                                    <span class="price-new">${bookDetail.price}VND</span>
                                    <del class="price-old">£91.86</del>
                                </div>
                                <div class="rating-widget">
                                    <div class="rating-block">
                                        <%
                                            Object avgRatingObj = request.getAttribute("averageRating");
                                            Object reviewCountObj = request.getAttribute("reviewCount");
                                            double avgRating = (avgRatingObj != null) ? (Double) avgRatingObj : 0.0;
                                            int reviewCount = (reviewCountObj != null) ? (Integer) reviewCountObj : 0;
                                            int fullStars = (int) Math.floor(avgRating);
                                            boolean hasHalfStar = (avgRating - fullStars) >= 0.5;
                                            
                                            for (int i = 1; i <= 5; i++) {
                                                if (i <= fullStars) {
                                                    out.print("<span class=\"fas fa-star star_on\"></span>");
                                                } else if (i == fullStars + 1 && hasHalfStar) {
                                                    out.print("<span class=\"fas fa-star-half-alt star_on\"></span>");
                                                } else {
                                                    out.print("<span class=\"fas fa-star\"></span>");
                                                }
                                            }
                                        %>
                                    </div>
                                    <div class="review-widget">
                                        <a href="#tab-2">(${reviewCount} Reviews)</a> <span>|</span>
                                        <a href="#tab-2">Write a review</a>
                                    </div>
                                </div>
                                <article class="product-details-article">
                                    <h4 class="sr-only">Product Summery</h4>
                                    <p>${bookDetail.description}</p>
                                </article>
                                <form action="home?state=cart&action=cart" method="GET">
                                    <input type="hidden" name="bookId" value="${bookDetail.BId}">

                                    <div class="add-to-cart-row">
                                        <div class="count-input-block">
                                            <span class="widget-label">Số lượng</span>
                                            <input type="number" name="quantity" class="form-control text-center" value="1" min="1">
                                        </div>
                                        <div class="add-cart-btn">

                                            <button type="submit" class="btn btn-outlined--primary">
                                                <span class="plus-icon">+</span>Thêm vào giỏ
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                <div class="compare-wishlist-row">
                                    <a href="wishlist?action=add&bookId=${bookDetail.BId}" class="add-link"><i class="fas fa-heart"></i> Add to Wish List</a>
                                    <a href="#" class="add-link"><i class="fas fa-random"></i>Add to Compare</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sb-custom-tab review-tab section-padding">
                        <ul class="nav nav-tabs nav-style-2" id="myTab2" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="tab1" data-bs-toggle="tab" href="#tab-1" role="tab"
                                   aria-controls="tab-1" aria-selected="true">
                                    DESCRIPTION
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="tab2" data-bs-toggle="tab" href="#tab-2" role="tab"
                                   aria-controls="tab-2" aria-selected="true">
                                    REVIEWS (${reviewCount})
                                </a>
                            </li>
                        </ul>
                        <div class="tab-content space-db--20" id="myTabContent">
                            <div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="tab1">
                                <article class="review-article">
                                    <h1 class="sr-only">Tab Article</h1>
                                    <p>${bookDetail.description}</p>
                                </article>
                            </div>
                            <div class="tab-pane fade" id="tab-2" role="tabpanel" aria-labelledby="tab2">
                                <div class="review-wrapper">
                                    <%@page import="java.util.List, model.Review, java.text.SimpleDateFormat, model.Account"%>
                                    <%
                                        List<Review> reviewList = (List<Review>) request.getAttribute("reviewList");
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
                                        Account accountCheck = (Account) session.getAttribute("account");
                                    %>
                                    <h2 class="title-lg mb--20">${reviewCount} REVIEW${reviewCount != 1 ? 'S' : ''} FOR ${bookDetail.BTitle}</h2>
                                    
                                    <% 
                                        String error = request.getParameter("error");
                                        String success = request.getParameter("review");
                                        String updateSuccess = request.getParameter("update");
                                        String deleteSuccess = request.getParameter("delete");
                                        
                                        if (success != null && "success".equals(success)) {
                                    %>
                                        <div class="alert alert-success mb--20" role="alert">
                                            Cảm ơn bạn đã đánh giá! Đánh giá của bạn đã được gửi thành công.
                                        </div>
                                    <% } %>
                                    <% if (updateSuccess != null && "success".equals(updateSuccess)) { %>
                                        <div class="alert alert-success mb--20" role="alert">
                                            Đánh giá của bạn đã được cập nhật thành công!
                                        </div>
                                    <% } %>
                                    <% if (deleteSuccess != null && "success".equals(deleteSuccess)) { %>
                                        <div class="alert alert-success mb--20" role="alert">
                                            Đánh giá đã được xóa thành công!
                                        </div>
                                    <% } %>
                                    <% if (error != null) { %>
                                        <div class="alert alert-danger mb--20" role="alert">
                                            <% 
                                                if ("already_reviewed".equals(error)) {
                                                    out.print("Bạn đã đánh giá sách này rồi!");
                                                } else if ("missing_fields".equals(error)) {
                                                    out.print("Vui lòng điền đầy đủ thông tin!");
                                                } else if ("invalid_rating".equals(error)) {
                                                    out.print("Đánh giá không hợp lệ!");
                                                } else if ("update_failed".equals(error)) {
                                                    out.print("Cập nhật đánh giá thất bại. Vui lòng thử lại!");
                                                } else if ("delete_failed".equals(error)) {
                                                    out.print("Xóa đánh giá thất bại. Vui lòng thử lại!");
                                                } else if ("unauthorized".equals(error)) {
                                                    out.print("Bạn không có quyền thực hiện thao tác này!");
                                                } else {
                                                    out.print("Có lỗi xảy ra. Vui lòng thử lại!");
                                                }
                                            %>
                                        </div>
                                    <% } %>
                                    
                                    <% if (reviewList != null && !reviewList.isEmpty()) { %>
                                        <% for (Review review : reviewList) { %>
                                            <%
                                                Review editReview = (Review) request.getAttribute("editReview");
                                                boolean isEditing = (editReview != null && editReview.getReviewId() == review.getReviewId());
                                                boolean isOwner = (accountCheck != null && accountCheck.getU_id() == review.getUserId());
                                            %>
                                            <div class="review-comment mb--20" id="review-<%= review.getReviewId() %>">
                                                <div class="avatar">
                                                    <img src="${pageContext.request.contextPath}/customer/image/icon/author-logo.png" alt="">
                                                </div>
                                                <div class="text">
                                                    <!-- View Mode -->
                                                    <div class="review-view-mode" id="view-<%= review.getReviewId() %>">
                                                        <div class="rating-block mb--15">
                                                            <% 
                                                                int rating = review.getRating();
                                                                for (int i = 1; i <= 5; i++) {
                                                                    if (i <= rating) {
                                                                        out.print("<span class=\"fas fa-star star_on\"></span>");
                                                                    } else {
                                                                        out.print("<span class=\"fas fa-star\"></span>");
                                                                    }
                                                                }
                                                            %>
                                                        </div>
                                                        <h6 class="author">
                                                            <%= review.getUserName() != null ? review.getUserName() : "Anonymous" %> – 
                                                            <span class="font-weight-400">
                                                                <%= review.getCreatedDate() != null ? dateFormat.format(review.getCreatedDate()) : "" %>
                                                            </span>
                                                            <% if (isOwner) { %>
                                                                <div class="review-actions" style="float: right; position: relative;">
                                                                    <button class="review-menu-btn" onclick="toggleReviewMenu(<%= review.getReviewId() %>)" style="background: none; border: none; cursor: pointer; font-size: 18px; color: #666; padding: 0 5px;">
                                                                        <i class="fas fa-ellipsis-v"></i>
                                                                    </button>
                                                                    <div class="review-menu" id="menu-<%= review.getReviewId() %>" style="display: none; position: absolute; right: 0; top: 25px; background: white; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); z-index: 1000; min-width: 120px;">
                                                                        <a href="javascript:void(0)" 
                                                                           onclick="showEditForm(<%= review.getReviewId() %>, <%= review.getRating() %>)" 
                                                                           data-comment="<%= review.getComment() != null ? review.getComment().replace("\"", "&quot;").replace("\n", "\\n").replace("\r", "").replace("'", "&#39;") : "" %>"
                                                                           id="edit-link-<%= review.getReviewId() %>"
                                                                           class="review-menu-item" 
                                                                           style="display: block; padding: 10px 15px; color: #333; text-decoration: none; border-bottom: 1px solid #eee; cursor: pointer;">
                                                                            <i class="fas fa-edit" style="margin-right: 8px;"></i> Sửa
                                                                        </a>
                                                                        <a href="home?state=deleteReview&reviewId=<%= review.getReviewId() %>" 
                                                                           class="review-menu-item" 
                                                                           style="display: block; padding: 10px 15px; color: #d32f2f; text-decoration: none;"
                                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?');">
                                                                            <i class="fas fa-trash" style="margin-right: 8px;"></i> Xóa
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            <% } %>
                                                        </h6>
                                                        <p><%= review.getComment() != null ? review.getComment() : "" %></p>
                                                    </div>
                                                    
                                                    <!-- Edit Mode (Hidden by default) -->
                                                    <div class="review-edit-mode" id="edit-<%= review.getReviewId() %>" style="display: none;">
                                                        <h2 class="title-lg mb--20">CHỈNH SỬA ĐÁNH GIÁ</h2>
                                                        <form action="home" method="POST" class="mt--15 site-form" onsubmit="return validateEditForm(<%= review.getReviewId() %>)">
                                                            <input type="hidden" name="state" value="updateReview">
                                                            <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                                                            <div class="rating-row pt-2" style="text-align: left !important; display: block !important;">
                                                                <p class="d-block" style="text-align: left !important; margin-bottom: 10px; float: none !important; display: block !important;">Your Rating</p>
                                                                <span class="rating-widget-block" style="display: flex !important; flex-direction: row !important; gap: 5px !important; justify-content: flex-start !important; align-items: center !important; transform: none !important; -webkit-transform: none !important; float: none !important; margin: 0 !important; padding: 0 !important;">
                                                                    <input type="radio" name="rating" id="edit-star<%= review.getReviewId() %>-1" value="1" required>
                                                                    <label for="edit-star<%= review.getReviewId() %>-1"></label>
                                                                    <input type="radio" name="rating" id="edit-star<%= review.getReviewId() %>-2" value="2" required>
                                                                    <label for="edit-star<%= review.getReviewId() %>-2"></label>
                                                                    <input type="radio" name="rating" id="edit-star<%= review.getReviewId() %>-3" value="3" required>
                                                                    <label for="edit-star<%= review.getReviewId() %>-3"></label>
                                                                    <input type="radio" name="rating" id="edit-star<%= review.getReviewId() %>-4" value="4" required>
                                                                    <label for="edit-star<%= review.getReviewId() %>-4"></label>
                                                                    <input type="radio" name="rating" id="edit-star<%= review.getReviewId() %>-5" value="5" required>
                                                                    <label for="edit-star<%= review.getReviewId() %>-5"></label>
                                                                </span>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <div class="form-group">
                                                                        <label for="edit-comment-<%= review.getReviewId() %>">Comment *</label>
                                                                        <textarea name="comment" id="edit-comment-<%= review.getReviewId() %>" cols="30" rows="10"
                                                                                  class="form-control" required></textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-4">
                                                                    <div class="submit-btn">
                                                                        <button type="submit" class="btn btn-black">Cập nhật</button>
                                                                        <button type="button" onclick="cancelEdit(<%= review.getReviewId() %>)" class="btn btn-outline-secondary" style="margin-left: 10px;">Hủy</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    <% } else { %>
                                        <p class="mb--20">Chưa có đánh giá nào cho sách này. Hãy là người đầu tiên đánh giá!</p>
                                    <% } %>
                                    
                                    <%
                                        Boolean hasReviewed = (Boolean) request.getAttribute("hasReviewed");
                                        if (hasReviewed == null) hasReviewed = false;
                                    %>
                                    
                                    <% if (accountCheck != null && !hasReviewed) { %>
                                        <h2 class="title-lg mb--20 pt--15">ADD A REVIEW</h2>
                                        
                                        <div class="rating-row pt-2" style="text-align: left !important; display: block !important;">
                                            <p class="d-block" style="text-align: left !important; margin-bottom: 10px; float: none !important; display: block !important;">Your Rating</p>
                                            <form action="home" method="POST" class="mt--15 site-form">
                                                <input type="hidden" name="state" value="review">
                                                <input type="hidden" name="bookId" value="${bookDetail.BId}">
                                                <span class="rating-widget-block" style="display: flex !important; flex-direction: row !important; gap: 5px !important; justify-content: flex-start !important; align-items: center !important; transform: none !important; -webkit-transform: none !important; float: none !important; margin: 0 !important; padding: 0 !important;">
                                                    <input type="radio" name="rating" id="star1" value="1" required>
                                                    <label for="star1"></label>
                                                    <input type="radio" name="rating" id="star2" value="2" required>
                                                    <label for="star2"></label>
                                                    <input type="radio" name="rating" id="star3" value="3" required>
                                                    <label for="star3"></label>
                                                    <input type="radio" name="rating" id="star4" value="4" required>
                                                    <label for="star4"></label>
                                                    <input type="radio" name="rating" id="star5" value="5" required>
                                                    <label for="star5"></label>
                                                </span>
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="form-group">
                                                            <label for="comment">Comment *</label>
                                                            <textarea name="comment" id="comment" cols="30" rows="10"
                                                                      class="form-control" required></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <div class="submit-btn">
                                                            <button type="submit" class="btn btn-black">Post Comment</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    <% } else if (hasReviewed) { %>
                                        <div class="alert alert-info mb--20" role="alert">
                                            Bạn đã đánh giá sách này rồi. Cảm ơn bạn!
                                        </div>
                                    <% } else { %>
                                        <div class="alert alert-warning mb--20" role="alert">
                                            Vui lòng <a href="login-register">đăng nhập</a> để đánh giá sách này.
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--=================================
        RELATED PRODUCTS BOOKS
    ===================================== -->
                <section class="">
                    <div class="container">
                        <div class="section-title section-title--bordered">
                            <h2>RELATED PRODUCTS</h2>
                        </div>
                        <div class="product-slider sb-slick-slider slider-border-single-row" data-slick-setting='{
                             "autoplay": true,
                             "autoplaySpeed": 8000,
                             "slidesToShow": 4,
                             "dots":true
                             }' data-slick-responsive='[
                             {"breakpoint":1200, "settings": {"slidesToShow": 4} },
                             {"breakpoint":992, "settings": {"slidesToShow": 3} },
                             {"breakpoint":768, "settings": {"slidesToShow": 2} },
                             {"breakpoint":480, "settings": {"slidesToShow": 1} }
                             ]'>
                            <div class="single-slide">
                                <div class="product-card">
                                    <div class="product-header">
                                        <a href="#" class="author">
                                            Lpple
                                        </a>
                                        <h3><a href="product-details.html">Revolutionize Your BOOK With</a></h3>
                                    </div>
                                    <div class="product-card--body">
                                        <div class="card-image">
                                            <img src="image/products/product-10.jpg" alt="">
                                            <div class="hover-contents">
                                                <a href="product-details.html" class="hover-image">
                                                    <img src="image/products/product-1.jpg" alt="">
                                                </a>
                                                <div class="hover-btns">
                                                    <a href="cart.html" class="single-btn">
                                                        <i class="fas fa-shopping-basket"></i>
                                                    </a>
                                                    <a href="wishlist.html" class="single-btn">
                                                        <i class="fas fa-heart"></i>
                                                    </a>
                                                    <a href="compare.html" class="single-btn">
                                                        <i class="fas fa-random"></i>
                                                    </a>
                                                    <a href="#" data-bs-toggle="modal" data-bs-target="#quickModal"
                                                       class="single-btn">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="price-block">
                                            <span class="price">£51.20</span>
                                            <del class="price-old">£51.20</del>
                                            <span class="price-discount">20%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-slide">
                                <div class="product-card">
                                    <div class="product-header">
                                        <a href="#" class="author">
                                            Jpple
                                        </a>
                                        <h3><a href="product-details.html">Turn Your BOOK Into High Machine</a>
                                        </h3>
                                    </div>
                                    <div class="product-card--body">s
                                        <div class="card-image">
                                            <img src="image/products/product-2.jpg" alt="">
                                            <div class="hover-contents">
                                                <a href="product-details.html" class="hover-image">
                                                    <img src="image/products/product-1.jpg" alt="">
                                                </a>
                                                <div class="hover-btns">
                                                    <a href="cart.html" class="single-btn">
                                                        <i class="fas fa-shopping-basket"></i>
                                                    </a>
                                                    <a href="wishlist.html" class="single-btn">
                                                        <i class="fas fa-heart"></i>
                                                    </a>
                                                    <a href="compare.html" class="single-btn">
                                                        <i class="fas fa-random"></i>
                                                    </a>
                                                    <a href="#" data-bs-toggle="modal" data-bs-target="#quickModal"
                                                       class="single-btn">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="price-block">
                                            <span class="price">£51.20</span>
                                            <del class="price-old">£51.20</del>
                                            <span class="price-discount">20%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-slide">
                                <div class="product-card">
                                    <div class="product-header">
                                        <a href="#" class="author">
                                            Wpple
                                        </a>
                                        <h3><a href="product-details.html">3 Ways Create Better BOOK With</a></h3>
                                    </div>
                                    <div class="product-card--body">
                                        <div class="card-image">
                                            <img src="image/products/product-3.jpg" alt="">
                                            <div class="hover-contents">
                                                <a href="product-details.html" class="hover-image">
                                                    <img src="image/products/product-2.jpg" alt="">
                                                </a>
                                                <div class="hover-btns">
                                                    <a href="cart.html" class="single-btn">
                                                        <i class="fas fa-shopping-basket"></i>
                                                    </a>
                                                    <a href="wishlist.html" class="single-btn">
                                                        <i class="fas fa-heart"></i>
                                                    </a>
                                                    <a href="compare.html" class="single-btn">
                                                        <i class="fas fa-random"></i>
                                                    </a>
                                                    <a href="#" data-bs-toggle="modal" data-bs-target="#quickModal"
                                                       class="single-btn">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="price-block">
                                            <span class="price">£51.20</span>
                                            <del class="price-old">£51.20</del>
                                            <span class="price-discount">20%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-slide">
                                <div class="product-card">
                                    <div class="product-header">
                                        <a href="#" class="author">
                                            Epple
                                        </a>
                                        <h3><a href="product-details.html">What You Can Learn From Bill Gates</a>
                                        </h3>
                                    </div>
                                    <div class="product-card--body">
                                        <div class="card-image">
                                            <img src="image/products/product-5.jpg" alt="">
                                            <div class="hover-contents">
                                                <a href="product-details.html" class="hover-image">
                                                    <img src="image/products/product-4.jpg" alt="">
                                                </a>
                                                <div class="hover-btns">
                                                    <a href="cart.html" class="single-btn">
                                                        <i class="fas fa-shopping-basket"></i>
                                                    </a>
                                                    <a href="wishlist.html" class="single-btn">
                                                        <i class="fas fa-heart"></i>
                                                    </a>
                                                    <a href="compare.html" class="single-btn">
                                                        <i class="fas fa-random"></i>
                                                    </a>
                                                    <a href="#" data-bs-toggle="modal" data-bs-target="#quickModal"
                                                       class="single-btn">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="price-block">
                                            <span class="price">£51.20</span>
                                            <del class="price-old">£51.20</del>
                                            <span class="price-discount">20%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="single-slide">
                                <div class="product-card">
                                    <div class="product-header">
                                        <a href="#" class="author">
                                            Hpple
                                        </a>
                                        <h3><a href="product-details.html">a Half Very Simple Things You To</a></h3>
                                    </div>
                                    <div class="product-card--body">
                                        <div class="card-image">
                                            <img src="image/products/product-6.jpg" alt="">
                                            <div class="hover-contents">
                                                <a href="product-details.html" class="hover-image">
                                                    <img src="image/products/product-4.jpg" alt="">
                                                </a>
                                                <div class="hover-btns">
                                                    <a href="cart.html" class="single-btn">
                                                        <i class="fas fa-shopping-basket"></i>
                                                    </a>
                                                    <a href="wishlist.html" class="single-btn">
                                                        <i class="fas fa-heart"></i>
                                                    </a>
                                                    <a href="compare.html" class="single-btn">
                                                        <i class="fas fa-random"></i>
                                                    </a>
                                                    <a href="#" data-bs-toggle="modal" data-bs-target="#quickModal"
                                                       class="single-btn">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="price-block">
                                            <span class="price">£51.20</span>
                                            <del class="price-old">£51.20</del>
                                            <span class="price-discount">20%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Modal -->
                <div class="modal fade modal-quick-view" id="quickModal" tabindex="-1" role="dialog"
                     aria-labelledby="quickModal" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            <div class="product-details-modal">
                                <div class="row">
                                    <div class="col-lg-5">
                                        <!-- Product Details Slider Big Image-->
                                        <div class="product-details-slider sb-slick-slider arrow-type-two" data-slick-setting='{
                                             "slidesToShow": 1,
                                             "arrows": false,
                                             "fade": true,
                                             "draggable": false,
                                             "swipe": false,
                                             "asNavFor": ".product-slider-nav"
                                             }'>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-1.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-2.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-3.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-4.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-5.jpg" alt="">
                                            </div>
                                        </div>
                                        <!-- Product Details Slider Nav -->
                                        <div class="mt--30 product-slider-nav sb-slick-slider arrow-type-two"
                                             data-slick-setting='{
                                             "infinite":true,
                                             "autoplay": true,
                                             "autoplaySpeed": 8000,
                                             "slidesToShow": 4,
                                             "arrows": true,
                                             "prevArrow":{"buttonClass": "slick-prev","iconClass":"fa fa-chevron-left"},
                                             "nextArrow":{"buttonClass": "slick-next","iconClass":"fa fa-chevron-right"},
                                             "asNavFor": ".product-details-slider",
                                             "focusOnSelect": true
                                             }'>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-1.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-2.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-3.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-4.jpg" alt="">
                                            </div>
                                            <div class="single-slide">
                                                <img src="image/products/product-details-5.jpg" alt="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-7 mt--30 mt-lg--30">
                                        <div class="product-details-info pl-lg--30 ">
                                            <p class="tag-block">Tags: <a href="#">Movado</a>, <a href="#">Omega</a></p>
                                            <h3 class="product-title">Beats EP Wired On-Ear Headphone-Black</h3>
                                            <ul class="list-unstyled">
                                                <li>Ex Tax: <span class="list-value"> £60.24</span></li>
                                                <li>Brands: <a href="#" class="list-value font-weight-bold"> Canon</a></li>
                                                <li>Product Code: <span class="list-value"> model1</span></li>
                                                <li>Reward Points: <span class="list-value"> 200</span></li>
                                                <li>Availability: <span class="list-value"> In Stock</span></li>
                                            </ul>
                                            <div class="price-block">
                                                <span class="price-new">£73.79</span>
                                                <del class="price-old">£91.86</del>
                                            </div>
                                            <div class="rating-widget">
                                                <div class="rating-block">
                                                    <span class="fas fa-star star_on"></span>
                                                    <span class="fas fa-star star_on"></span>
                                                    <span class="fas fa-star star_on"></span>
                                                    <span class="fas fa-star star_on"></span>
                                                    <span class="fas fa-star "></span>
                                                </div>
                                                <div class="review-widget">
                                                    <a href="#">(1 Reviews)</a> <span>|</span>
                                                    <a href="#">Write a review</a>
                                                </div>
                                            </div>
                                            <article class="product-details-article">
                                                <h4 class="sr-only">Product Summery</h4>
                                                <p>Long printed dress with thin adjustable straps. V-neckline and wiring under
                                                    the Dust with ruffles
                                                    at the bottom
                                                    of the
                                                    dress.</p>
                                            </article>
                                            <div class="add-to-cart-row">
                                                <div class="count-input-block">
                                                    <span class="widget-label">Qty</span>
                                                    <input type="number" class="form-control text-center" value="1">
                                                </div>
                                                <div class="add-cart-btn">
                                                    <a href="#" class="btn btn-outlined--primary"><span
                                                            class="plus-icon">+</span>Add to Cart</a>
                                                </div>
                                            </div>
                                            <div class="compare-wishlist-row">
                                                <a href="#" class="add-link"><i class="fas fa-heart"></i>Add to Wish List</a>
                                                <a href="#" class="add-link"><i class="fas fa-random"></i>Add to Compare</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="widget-social-share">
                                    <span class="widget-label">Share:</span>
                                    <div class="modal-social-share">
                                        <a href="#" class="single-icon"><i class="fab fa-facebook-f"></i></a>
                                        <a href="#" class="single-icon"><i class="fab fa-twitter"></i></a>
                                        <a href="#" class="single-icon"><i class="fab fa-youtube"></i></a>
                                        <a href="#" class="single-icon"><i class="fab fa-google-plus-g"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <jsp:include page="./common/brand_slider.jsp"></jsp:include>
        <jsp:include page="./common/footer.jsp"></jsp:include>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/ajax-mail.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
        <script>
            function toggleReviewMenu(reviewId) {
                var menu = document.getElementById('menu-' + reviewId);
                var allMenus = document.querySelectorAll('.review-menu');
                
                // Đóng tất cả các menu khác
                allMenus.forEach(function(m) {
                    if (m.id !== 'menu-' + reviewId) {
                        m.style.display = 'none';
                    }
                });
                
                // Toggle menu hiện tại
                if (menu.style.display === 'none' || menu.style.display === '') {
                    menu.style.display = 'block';
                } else {
                    menu.style.display = 'none';
                }
            }
            
            // Đóng menu khi click ra ngoài
            document.addEventListener('click', function(event) {
                if (!event.target.closest('.review-actions')) {
                    var allMenus = document.querySelectorAll('.review-menu');
                    allMenus.forEach(function(menu) {
                        menu.style.display = 'none';
                    });
                }
            });
            
            // Hover effect cho menu items
            document.addEventListener('DOMContentLoaded', function() {
                var menuItems = document.querySelectorAll('.review-menu-item');
                menuItems.forEach(function(item) {
                    item.addEventListener('mouseenter', function() {
                        this.style.backgroundColor = '#f5f5f5';
                    });
                    item.addEventListener('mouseleave', function() {
                        this.style.backgroundColor = 'white';
                    });
                });
            });
            
            // Hiển thị form edit
            function showEditForm(reviewId, rating) {
                // Đóng menu
                var menu = document.getElementById('menu-' + reviewId);
                if (menu) {
                    menu.style.display = 'none';
                }
                
                // Lấy comment từ data attribute
                var editLink = document.getElementById('edit-link-' + reviewId);
                var comment = '';
                if (editLink && editLink.getAttribute('data-comment')) {
                    comment = editLink.getAttribute('data-comment')
                        .replace(/&quot;/g, '"')
                        .replace(/&#39;/g, "'")
                        .replace(/\\n/g, '\n');
                }
                
                // Ẩn view mode
                var viewMode = document.getElementById('view-' + reviewId);
                if (viewMode) {
                    viewMode.style.display = 'none';
                }
                
                // Hiển thị edit mode
                var editMode = document.getElementById('edit-' + reviewId);
                if (editMode) {
                    editMode.style.display = 'block';
                    
                    // Set rating
                    var ratingInput = document.getElementById('edit-star' + reviewId + '-' + rating);
                    if (ratingInput) {
                        ratingInput.checked = true;
                    }
                    
                    // Set comment
                    var commentTextarea = document.getElementById('edit-comment-' + reviewId);
                    if (commentTextarea) {
                        commentTextarea.value = comment;
                    }
                    
                    // Scroll to form
                    editMode.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                }
            }
            
            // Hủy edit
            function cancelEdit(reviewId) {
                // Ẩn edit mode
                var editMode = document.getElementById('edit-' + reviewId);
                if (editMode) {
                    editMode.style.display = 'none';
                }
                
                // Hiển thị view mode
                var viewMode = document.getElementById('view-' + reviewId);
                if (viewMode) {
                    viewMode.style.display = 'block';
                }
            }
            
            // Validate form before submit
            function validateEditForm(reviewId) {
                var form = document.querySelector('#edit-' + reviewId + ' form');
                var rating = form.querySelector('input[name="rating"]:checked');
                var comment = document.getElementById('edit-comment-' + reviewId);
                
                if (!rating) {
                    alert('Vui lòng chọn đánh giá!');
                    return false;
                }
                
                if (!comment || !comment.value.trim()) {
                    alert('Vui lòng nhập bình luận!');
                    return false;
                }
                
                return true;
            }
        </script>
    </body>
</html>