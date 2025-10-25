<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> <%-- Make sure you have the opening html tag --%>
    <head> <%-- Add the style block inside the head --%>
        <%-- Other head elements like meta tags, title, links to CSS/JS --%>

        <style>
            /* >>>>>>>>>> Header - Cart Alignment for two lines <<<<<<<<< */

            .cart-block {
                display: flex !important; /* Keep main container flex */
                align-items: center !important; /* Vertically align icon and text block */
                position: relative !important;
                cursor: pointer !important; /* Make the whole block clickable for dropdown */
            }

            /* Adjust the icon's position */
            .cart-block::before {
                margin-right: 10px !important; /* Space between icon and text */
                font-size: 30px !important; /* Adjust icon size */
                line-height: 1 !important;
            }

            .cart-total {
                /* This will now contain two lines of text */
                display: flex !important;
                flex-direction: column !important; /* Stack items vertically */
                align-items: flex-start !important; /* Align text to the left within this block */
                position: relative !important;
                padding-right: 0 !important;
            }

            .cart-total .top-line {
                display: flex !important; /* Make the top line a flex container */
                align-items: center !important; /* Vertically align "Shopping Cart" and count */
                margin-bottom: 2px !important; /* Small space between lines */
            }

            .cart-total .text-item {
                order: 1 !important; /* "Shopping Cart" first */
                font-size: 14px !important; /* Adjust font size */
                font-weight: 600 !important; /* Make it a bit bolder */
                color: #333 !important; /* Darker text */
                margin-right: 8px !important; /* Space before the count */
                line-height: 1.2 !important;
                white-space: nowrap; /* Prevent "Shopping Cart" from wrapping */
            }

            .cart-total .text-number {
                order: 2 !important; /* Count second */
                position: static !important;
                width: auto !important;
                height: auto !important;
                line-height: 1 !important;
                padding: 2px 6px !important;
                font-size: 11px !important; /* Smaller count font */
                margin-right: 0 !important; /* Remove margin here */
                border-radius: 4px !important;
                background: #bd0018 !important;
                color: #fff !important;
                font-weight: 700 !important;
                text-align: center !important;
            }

            .cart-total .price {
                order: 3 !important; /* Price on the bottom line */
                font-size: 15px !important; /* Larger price font */
                font-weight: 600 !important; /* Make price bolder */
                color: #62ab00 !important; /* Green price */
                line-height: 1.2 !important;
                margin-left: 0 !important; /* Remove left margin */
                white-space: nowrap; /* Prevent price from wrapping */
            }

            /* Ensure the dropdown arrow aligns */
            .cart-total .price i {
                margin-left: 5px !important; /* Space before the dropdown arrow */
                font-size: 10px !important; /* Smaller arrow icon */
                color: #777 !important; /* Muted arrow color */
            }

            /* Keep dropdown positioning relative to cart-block */
            .cart-dropdown-block {
                top: calc(100% + 5px) !important;
                right: 0 !important;
                left: auto !important; /* Ensure it aligns to the right */
            }

            /* Ensure the user dropdown aligns correctly if needed */
            .header-links .dropdown {
                margin-right: 20px !important; /* Add space between user name and cart */
            }

        </style>

    </head>
    <div class="site-header header-2 mb--20 d-none d-lg-block">
        <div class="header-middle pt--10 pb--10">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-3">
                        <a href="home" class="site-brand">
                            <img src="${pageContext.request.contextPath}/customer/image/logo.png" alt="">
                        </a>
                    </div>
                    <div class="col-lg-5">
                        <div class="header-search-block">
                            <form action="search" method="get" class="header-search-block">
                                <input type="text" 
                                       name="searchQuery" 
                                       placeholder="Tìm theo tên, nhà xuất bản, tác giả" 
                                       value="${searchQuery}">
                                <button type="submit">Tìm kiếm</button>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="main-navigation flex-lg-right">
                            <div class="cart-widget">


                                <div class="header-links">
                                    <ul class="nav align-items-center">
                                        <li class="item">
                                            <c:choose>

                                                <c:when test="${not empty sessionScope.account}">
                                                    <div class="dropdown">
                                                        <a href="#" class="dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                            Hello, ${sessionScope.account.l_name} ${sessionScope.account.f_name}
                                                        </a>
                                                        <ul class="dropdown-menu" aria-labelledby="userDropdown">
                                                            <li><a class="dropdown-item" href="my-account">Tài khoản của tôi</a></li>
                                                            <li><hr class="dropdown-divider"></li>

                                                            <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                                                        </ul>
                                                    </div>
                                                </c:when>


                                                <c:otherwise>

                                                    <div class="login-block">
                                                        <a href="login-register" class="font-weight-bold">Đăng nhập</a> <br>
                                                        <span>hoặc</span><a href="login-register">Đăng kí</a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
                                </div>
                                <div class="cart-block">
                                    <div class="cart-total"> 
                                        <div class="top-line">
                                            <span class="text-item">
                                                Giỏ hàng
                                            </span>
                                            <span class="text-number">
                                                ${cartItemCount > 0 ? cartItemCount : 0}
                                            </span>
                                        </div>
                                        <span class="price">
                                            <c:if test="${not empty subTotalHeader}">
                                                <fmt:formatNumber value="${subTotalHeader}" type="number" pattern="#,##0"/> VND
                                            </c:if>
                                            <c:if test="${empty subTotalHeader}">
                                                0 VND
                                            </c:if>
                                            <i class="fas fa-chevron-down"></i>
                                        </span>

                                    </div>
                                    <div class="cart-dropdown-block">
                                        <c:choose>
                                            <c:when test="${not empty cartItemsHeader}">
                                                <div class="single-cart-block">
                                                    <c:forEach var="item" items="${cartItemsHeader}">
                                                        <div class="cart-product">
                                                            <a href="home?state=detail&bookId=${item.bookId}" class="image">
                                                                <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.title}">
                                                            </a>
                                                            <div class="content">
                                                                <h3 class="title"><a href="home?state=detail&bookId=${item.bookId}">${item.title}</a></h3>
                                                                <p class="price"><span class="qty">${item.quantity} ×</span> <fmt:formatNumber value="${item.price}" type="number" pattern="#,##0"/> VND</p>
                                                                <a href="cart?action=delete&itemId=${item.cartItemId}" class="cross-btn"><i class="fas fa-times"></i></a>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <div class="single-cart-block">
                                                    <div class="btn-block">
                                                        <a href="cart" class="btn">Xem giỏ hàng <i class="fas fa-chevron-right"></i></a>
                                                        <a href="checkout" class="btn btn--primary">Thanh toán <i class="fas fa-chevron-right"></i></a>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="single-cart-block">
                                                    <p class="text-center p-4">Giỏ hàng của bạn đang trống.</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="header-bottom bg-primary">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-3">
                        <nav class="category-nav white-nav  ">
                            <div>
                                <a href="javascript:void(0)" class="category-trigger"><i
                                        class="fa fa-bars"></i>Thể loại</a>
                                <ul class="category-menu">
                                    <li class="cat-item has-children">
                                        <a href="#">Giáo Dục & Học Tập</a>
                                        <ul class="sub-menu">
                                            <li><a href="#">Sách Tham Khảo</a></li>
                                            <li><a href="#">Sách Luyện Thi</a></li>
                                            <li><a href="#">Ngoại Ngữ</a></li>
                                            <li><a href="#">Phát Triển Bản Thân</a></li>
                                        </ul>
                                    </li>
                                    <li class="cat-item has-children mega-menu"><a href="#">Tiểu Sử</a>
                                        <ul class="sub-menu">
                                            <li class="single-block">
                                                <h3 class="title">Nhân Vật Nổi Tiếng</h3>
                                                <ul>
                                                    <li><a href="#">Doanh Nhân & Lãnh Đạo</a></li>
                                                    <li><a href="#">Chính Trị Gia</a></li>
                                                    <li><a href="#">Nhà Khoa Học</a></li>
                                                    <li><a href="#">Nghệ Sĩ & Diễn Viên</a></li>
                                                    <li><a href="#">Nhà Văn & Nhà Thơ</a></li>
                                                </ul>
                                            </li>
                                            <li class="single-block">
                                                <h3 class="title">Tiểu Sử Truyền Cảm Hứng</h3>
                                                <ul>
                                                    <li><a href="#">Vượt Lên Nghịch Cảnh</a></li>
                                                    <li><a href="#">Câu Chuyện Thành Công</a></li>
                                                    <li><a href="#">Những Người Truyền Cảm Hứng</a></li>
                                                    <li><a href="#">Sách Về Cuộc Sống</a></li>
                                                </ul>
                                            </li>
                                            <li class="single-block">
                                                <h3 class="title">Tiểu Sử Lịch Sử</h3>
                                                <ul>
                                                    <li><a href="#">Anh Hùng Dân Tộc</a></li>
                                                    <li><a href="#">Nhà Cải Cách & Cách Mạng</a></li>
                                                    <li><a href="#">Danh Nhân Văn Hóa</a></li>
                                                    <li><a href="#">Lịch Sử Các Triều Đại</a></li>
                                                </ul>
                                            </li>
                                            <li class="single-block">
                                                <h3 class="title">Quốc Tế</h3>
                                                <ul>
                                                    <li><a href="#">Lãnh Đạo Toàn Cầu</a></li>
                                                    <li><a href="#">Nhà Tư Tưởng & Triết Gia</a></li>
                                                    <li><a href="#">Nhân Vật Ảnh Hưởng Trong Công Nghệ</a></li>
                                                    <li><a href="#">Nhân Vật Nổi Tiếng Thế Giới</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="cat-item has-children"><a href="#">Kinh Doanh & Tài Chính</a>
                                        <ul class="sub-menu">
                                            <li><a href="#">Quản Trị & Lãnh Đạo</a></li>
                                            <li><a href="#">Khởi Nghiệp & Đổi Mới</a></li>
                                            <li><a href="#">Đầu Tư & Chứng Khoán</a></li>
                                            <li><a href="#">Kỹ Năng Làm Việc & Tư Duy</a></li>
                                        </ul>
                                    </li>
                                    <li class="cat-item has-children"><a href="#">Lịch & Kế Hoạch</a>
                                        <ul class="sub-menu">
                                            <li><a href="#">Lịch Năm & Lịch Để Bàn</a></li>
                                            <li><a href="#">Planner Cá Nhân</a></li>
                                            <li><a href="#">Sổ Tay Ghi Chú</a></li>
                                            <li><a href="#">Bullet Journal & Học Tập</a></li>
                                        </ul>
                                    </li>
                                    <li class="cat-item has-children"><a href="#">Sách Thiếu Nhi</a>
                                        <ul class="sub-menu">
                                            <li><a href="#">Truyện Cổ Tích</a></li>
                                            <li><a href="#">Truyện Tranh Thiếu Nhi</a></li>
                                            <li><a href="#">Sách Kỹ Năng Sống</a></li>
                                            <li><a href="#">Sách Tô Màu & Học Chữ</a></li>
                                        </ul>
                                    </li>
                                    <li class="cat-item has-children"><a href="#">Truyện Tranh</a>
                                        <ul class="sub-menu">
                                            <li><a href="#">Manga Nhật Bản</a></li>
                                            <li><a href="#">Truyện Tranh Việt Nam</a></li>
                                            <li><a href="#">Học Đường</a></li>
                                            <li><a href="#">Truyện Hài & Phiêu Lưu</a></li>
                                        </ul>
                                    </li>
                                    <li class="cat-item has-children"><a href="#">Sách Nấu Ăn</a>
                                        <ul class="sub-menu">
                                            <li><a href="#">Món Ăn Gia Đình</a></li>
                                            <li><a href="#">Ẩm Thực Chay</a></li>
                                            <li><a href="#">Bánh Ngọt & Tráng Miệng</a></li>
                                            <li><a href="#">Ẩm Thực Thế Giới</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div class="col-lg-3">
                        <div class="header-phone color-white">
                            <div class="icon">
                                <i class="fas fa-headphones-alt"></i>
                            </div>
                            <div class="text">
                                <p>Liên hệ 24/7</p>
                                <p class="font-weight-bold number">+84-999-999-999</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="main-navigation flex-lg-right">
                            <ul class="main-menu menu-right main-menu--white li-last-0">
                                <li class="menu-item has-children">
                                    <a href="home">Trang chủ</a>
                                </li>
                                <!-- Shop -->
                                <!--                            <li class="menu-item has-children mega-menu">
                                                                <a href="javascript:void(0)">shop <i
                                                                        class="fas fa-chevron-down dropdown-arrow"></i></a>
                                                                <ul class="sub-menu four-column">
                                                                    <li class="cus-col-25">
                                                                        <h3 class="menu-title"><a href="javascript:void(0)">Shop Grid </a></h3>
                                                                        <ul class="mega-single-block">
                                                                            <li><a href="shop-grid.html">Fullwidth</a></li>
                                                                            <li><a href="shop-grid-left-sidebar.html">left Sidebar</a></li>
                                                                            <li><a href="shop-grid-right-sidebar.html">Right Sidebar</a></li>
                                                                        </ul>
                                                                    </li>
                                                                    <li class="cus-col-25">
                                                                        <h3 class="menu-title"> <a href="javascript:void(0)">Shop List</a></h3>
                                                                        <ul class="mega-single-block">
                                                                            <li><a href="shop-list.html">Fullwidth</a></li>
                                                                            <li><a href="shop-list-left-sidebar.html">left Sidebar</a></li>
                                                                            <li><a href="shop-list-right-sidebar.html">Right Sidebar</a></li>
                                                                        </ul>
                                                                    </li>
                                                                    <li class="cus-col-25">
                                                                        <h3 class="menu-title"> <a href="javascript:void(0)">Product Details
                                                                                1</a></h3>
                                                                        <ul class="mega-single-block">
                                                                            <li><a href="product-details.html">Product Details Page</a></li>
                                                                            <li><a href="product-details-affiliate.html">Product Details
                                                                                    Affiliate</a></li>
                                                                            <li><a href="product-details-group.html">Product Details Group</a>
                                                                            </li>
                                                                            <li><a href="product-details-variable.html">Product Details
                                                                                    Variables</a></li>
                                                                        </ul>
                                                                    </li>
                                                                    <li class="cus-col-25">
                                                                        <h3 class="menu-title"><a href="javascript:void(0)">Product Details
                                                                                2</a></h3>
                                                                        <ul class="mega-single-block">
                                                                            <li><a href="product-details-left-thumbnail.html">left Thumbnail</a>
                                                                            </li>
                                                                            <li><a href="product-details-right-thumbnail.html">Right
                                                                                    Thumbnail</a></li>
                                                                            <li><a href="product-details-left-gallery.html">Left Gallery</a>
                                                                            </li>
                                                                            <li><a href="product-details-right-gallery.html">Right Gallery</a>
                                                                            </li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>
                                                            </li>-->
                                <!-- Pages -->
                                <!--                            <li class="menu-item has-children">
                                                                <a href="javascript:void(0)">Pages <i
                                                                        class="fas fa-chevron-down dropdown-arrow"></i></a>
                                                                <ul class="sub-menu">
                                                                    <li><a href="cart.html">Cart</a></li>
                                                                    <li><a href="checkout.html">Checkout</a></li>
                                                                    <li><a href="compare.html">Compare</a></li>
                                                                    <li><a href="wishlist.html">Wishlist</a></li>
                                                                    <li><a href="login_register.jsp">Login Register</a></li>
                                                                    <li><a href="my-account.html">My Account</a></li>
                                                                    <li><a href="order-complete.html">Order Complete</a></li>
                                                                    <li><a href="faq.html">Faq</a></li>
                                                                    <li><a href="contact-2.html">contact 02</a></li>
                                                                </ul>
                                                            </li>-->
                                <!-- Blog -->
                                <li class="menu-item has-children mega-menu">
                                    <a href="javascript:void(0)">Blog</a>
                                </li>
                                <li class="menu-item">
                                    <a href="contact.html">Liên hệ</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>