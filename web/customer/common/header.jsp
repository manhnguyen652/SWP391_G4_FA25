
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                        <input type="text" placeholder="Tìm theo tên, nhà xuất bản, tác giả">
                        <button>Tìm kiếm</button>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="main-navigation flex-lg-right">
                        <div class="cart-widget">
                            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

                            <div class="header-links">
                                <ul class="nav align-items-center">
                                    <li class="item">
                                        <c:choose>
                                            <%-- TRƯỜNG HỢP: Người dùng ĐÃ đăng nhập --%>
                                            <c:when test="${not empty sessionScope.account}">
                                                <div class="dropdown">
                                                    <a href="#" class="dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                        Hello, ${sessionScope.account.l_name} ${sessionScope.account.f_name}
                                                    </a>
                                                    <ul class="dropdown-menu" aria-labelledby="userDropdown">
                                                        <li><a class="dropdown-item" href="my-account">Tài khoản của tôi</a></li>
                                                        <li><hr class="dropdown-divider"></li>
                                                            <%-- Link này sẽ gọi đến LogoutController bạn vừa tạo --%>
                                                        <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                                                    </ul>
                                                </div>
                                            </c:when>

                                            <%-- TRƯỜNG HỢP: Người dùng CHƯA đăng nhập --%>
                                            <c:otherwise>

                                                <a href="login-register" class="font-weight-bold">Đăng nhập</a> <br>
                                                <span> </span><a href="login-register.html" class="font-weight-bold">Đăng kí</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                            </div>
                            <div class="cart-block">
                                <div class="cart-total">
                                    <span class="font-weight-bold" >
                                        Giỏ hàng
                                    </span>
                                </div>
                                <div class="cart-dropdown-block">
                                    <div class=" single-cart-block ">
                                        <div class="cart-product">
                                            <a href="home?state=detail" class="image">
                                                <img src="${pageContext.request.contextPath}/customer/image/products/cart-product-1.jpg" alt="">
                                            </a>
                                            <div class="content">
                                                <h3 class="title"><a href="home?state=detail">Đắc Nhân Tâm</a></h3>
                                                <p class="price"><span class="qty">1 ×</span> 140.000 VND</p>
                                                <button class="cross-btn"><i class="fas fa-times"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class=" single-cart-block ">
                                        <div class="btn-block">
                                            <a href="cart.html" class="btn">Xem giỏ hàng <i
                                                    class="fas fa-chevron-right"></i></a>
                                            <a href="checkout.html" class="btn btn--primary">Thanh toán <i
                                                    class="fas fa-chevron-right"></i></a>
                                        </div>
                                    </div>
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