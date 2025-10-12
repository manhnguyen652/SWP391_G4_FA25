<%-- 
    Document   : home_register
    Created on : Oct 3, 2025, 9:34:05 PM
    Author     : admin123
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
            <div class="site-header d-none d-lg-block">
                <div class="header-middle pt--10 pb--10">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-3 ">
                                <a href="index.html" class="site-brand">
                                    <img src="image/logo.png" alt="">
                                </a>
                            </div>
                            <div class="col-lg-3">
                                <div class="header-phone ">
                                    <div class="icon">
                                        <i class="fas fa-headphones-alt"></i>
                                    </div>
                                    <div class="text">
                                        <p>Free Support 24/7</p>
                                        <p class="font-weight-bold number">+01-202-555-0181</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="main-navigation flex-lg-right">
                                    <ul class="main-menu menu-right ">
                                        <li class="menu-item has-children">
                                            <a href="javascript:void(0)">Trang chủ <i class="fas fa-chevron-down dropdown-arrow"></i></a>
<!--                                            <ul class="sub-menu">
                                                <li> <a href="index.html">Home One</a></li>
                                                <li> <a href="index-2.html">Home Two</a></li>
                                                <li> <a href="index-3.html">Home Three</a></li>
                                                <li> <a href="index-4.html">Home Four</a></li>
                                            </ul>-->
                                        </li>
                                        <!-- Shop -->
<!--                                        <li class="menu-item has-children mega-menu">-->
<!--                                            <a href="javascript:void(0)">Cửa hàng <i class="fas fa-chevron-down dropdown-arrow"></i></a>-->
<!--                                            <ul class="sub-menu four-column">
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
                                            </ul>-->
<!--                                        </li>-->
                                        <!-- Pages -->
                                        <li class="menu-item has-children">
                                            <a href="javascript:void(0)">Trang <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                            <ul class="sub-menu">
                                                <li><a href="cart.html">Giỏ hàng</a></li>
                                                <li><a href="checkout.html">Thanh toán</a></li>
                                                <li><a href="wishlist.html">Yêu thích</a></li>
                                                <li><a href="orders.html">Đơn hàng của tôi</a></li>
                                                <li><a href="reviews.html">Đánh giá sách</a></li>
                                                <li><a href="my-account.html">Tài khoản</a></li>
                                                <li><a href="faq.html">Câu hỏi thường gặp</a></li>
                                                <li><a href="contact.html">Liên hệ</a></li>
                                            </ul>
                                        </li>
                                        <!-- Blog -->
                                        <li class="menu-item has-children mega-menu">
                                            <a href="javascript:void(0)">Bài viết <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                            <ul class="sub-menu three-column">
                                                <li class="cus-col-33">
                                                    <h3 class="menu-title"><a href="javascript:void(0)">Giới thiệu & Tin tức</a></h3>
                                                    <ul class="mega-single-block">
                                                        <li><a href="blog.html">Tin tức sách mới</a></li>
                                                        <li><a href="blog-left-sidebar.html">Sự kiện & Hội sách</a></li>
                                                        <li><a href="blog-right-sidebar.html">Tác giả nổi bật</a></li>
                                                    </ul>
                                                </li>
                                                <li class="cus-col-33">
                                                    <h3 class="menu-title"><a href="javascript:void(0)">Review & Cảm nhận </a></h3>
                                                    <ul class="mega-single-block">
                                                        <!-- <li><a href="blog-list.html">Full Widh (Default)</a></li> -->
                                                        <li><a href="book-reviews.html">Đánh giá sách</a></li>
                                                        <li><a href="reader-opinions.html">Cảm nhận độc giả</a></li>
                                                        <li><a href="top-books.html">Top sách nên đọc</a></li>
                                                    </ul>
                                                </li>
                                                <li class="cus-col-33">
                                                    <h3 class="menu-title"><a href="javascript:void(0)">Hướng dẫn & Kiến thức</a>
                                                    </h3>
                                                    <ul class="mega-single-block">
                                                        <li><a href="reading-tips.html">Mẹo đọc sách hiệu quả</a></li>
                                                        <li><a href="genres-guide.html">Hướng dẫn chọn thể loại</a></li>
                                                        <li><a href="faq.html">Câu hỏi thường gặp</a></li>
                                                    </ul>
                                                </li>
                                            </ul>
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
                <div class="header-bottom pb--10">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-3">
                                <nav class="category-nav   ">
                                    <div>
                                        <a href="javascript:void(0)" class="category-trigger"><i class="fa fa-bars"></i>Danh mục</a>
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
                            <div class="col-lg-5">
                                <div class="header-search-block">
                                    <input type="text" placeholder="Tìm kiếm sách...">
                                    <button>Search</button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="main-navigation flex-lg-right">
                                    <div class="cart-widget">
                                        <div class="login-block">
                                            <a href="login-register.html" class="font-weight-bold">Đăng nhập</a> <br>
                                            <span>  </span><a href="login-register.html">Đăng ký</a>
                                        </div>
                                        <div class="cart-block">
                                            <div class="cart-total">
<!--                                                <span class="text-number">
                                                    1
                                                </span>-->
                                                <span class="text-item">
                                                    Giỏ hàng 
                                                </span>
<!--                                                <span class="price">
                                                    £0.00
                                                    <i class="fas fa-chevron-down"></i>
                                                </span>-->
                                            </div>
                                            <div class="cart-dropdown-block">
                                                <div class=" single-cart-block ">
                                                    <div class="cart-product">
                                                        <a href="product-details.html" class="image">
                                                            <img src="image/products/cart-product-1.jpg" alt="">
                                                        </a>
                                                        <div class="content">
                                                            <h3 class="title"><a href="product-details.html">Kodak PIXPRO
                                                                    Astro Zoom AZ421 16 MP</a></h3>
                                                            <p class="price"><span class="qty">1 ×</span> £87.34</p>
                                                            <button class="cross-btn"><i class="fas fa-times"></i></button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class=" single-cart-block ">
                                                    <div class="btn-block">
                                                        <a href="cart.html" class="btn">Xem sách <i class="fas fa-chevron-right"></i></a>
                                                        <a href="checkout.html" class="btn btn--primary">Kiểm tra <i class="fas fa-chevron-right"></i></a>
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
            </div>
<!--   
            <!--=============================================
=            Login Register page content         =
=============================================-->
            <main class="page-section inner-page-sec-padding-bottom">
  <div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="col-sm-12 col-md-8 col-lg-6">
      <form action="login-register" method="post">
        <input type="hidden" name="action" value="register">
        <div class="login-form text-center p-4 shadow rounded bg-white">
          <h4 class="login-title mb-3">Tạo Tài Khoản</h4>
          <p><span class="font-weight-bold text-danger">Tôi là khách hàng mới!!!</span></p>
          <div class="row">            
            <div class="col-12 mb-3 text-start">
              <label for="email">Email</label>
              <input class="form-control" type="email" name="email" id="email" placeholder="abc123@gmail.com">
            </div>
            <div class="col-lg-6 mb-3 text-start">
              <label for="password">Mật khẩu</label>
              <input class="form-control" type="password" name="password" id="password" placeholder="Mật khẩu của bạn là...">
            </div>
            <div class="col-md-12">
              <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</main>

        </div>
        <!--=================================
  Brands Slider
===================================== -->
        <section class="section-margin">
            <h2 class="sr-only">Brand Slider</h2>
            <div class="container">
                <div class="brand-slider sb-slick-slider border-top border-bottom slick-initialized slick-slider" data-slick-setting="{
                     &quot;autoplay&quot;: true,
                     &quot;autoplaySpeed&quot;: 8000,
                     &quot;slidesToShow&quot;: 6
                     }" data-slick-responsive="[
                     {&quot;breakpoint&quot;:992, &quot;settings&quot;: {&quot;slidesToShow&quot;: 4} },
                     {&quot;breakpoint&quot;:768, &quot;settings&quot;: {&quot;slidesToShow&quot;: 3} },
                     {&quot;breakpoint&quot;:575, &quot;settings&quot;: {&quot;slidesToShow&quot;: 3} },
                     {&quot;breakpoint&quot;:480, &quot;settings&quot;: {&quot;slidesToShow&quot;: 2} },
                     {&quot;breakpoint&quot;:320, &quot;settings&quot;: {&quot;slidesToShow&quot;: 1} }
                     ]"><div class="slick-list draggable"><div class="slick-track" style="opacity: 1; width: 1360px; transform: translate3d(-850px, 0px, 0px);"><div class="slick-slide" data-slick-index="0" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-1.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="1" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-2.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="2" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-3.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="3" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-4.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="4" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-5.jpg" alt="">
                                    </div></div></div><div class="slick-slide slick-current slick-active" data-slick-index="5" aria-hidden="false" style="width: 170px;"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-6.jpg" alt="">
                                    </div></div></div><div class="slick-slide slick-active" data-slick-index="6" aria-hidden="false" style="width: 170px;"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-1.jpg" alt="">
                                    </div></div></div><div class="slick-slide slick-active" data-slick-index="7" aria-hidden="false" style="width: 170px;"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-2.jpg" alt="">
                                    </div></div></div></div></div></div>
            </div>
        </section>
        <!--=================================
    Footer Area
===================================== -->
        <footer class="site-footer">
            <div class="container">
                <div class="row justify-content-between  section-padding">
                    <div class=" col-xl-3 col-lg-4 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="brand-footer footer-title">
                                <img src="image/logo--footer.png" alt="">
                            </div>
                            <div class="footer-contact">
                                <p><span class="label">Địa chỉ:</span><span class="text">FPT, Thạch Thất, Hà Nội</span></p>
                                <p><span class="label">Phone:</span><span class="text">+18088 234 5678</span></p>
                                <p><span class="label">Email:</span><span class="text">cskh@pustok.com</span></p>
                            </div>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-2 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="footer-title">
                                <h3>Thông tin</h3>
                            </div>
                            <ul class="footer-list normal-list">
                                <li><a href="">Khuyến mại</a></li>
                                <li><a href="">Giới thiệu</a></li>
                                <li><a href="">Liên hệ đặt quảng cáo</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-2 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="footer-title">
                                <h3>Pustok</h3>
                            </div>
                            <ul class="footer-list normal-list">
                                <li><a href="">Chính sách bảo mật</a></li>
                                <li><a href="">Điều khoản</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-4 col-sm-6">
                        <div class="footer-title">
                            <h3>Đăng ký nhận thông tin</h3>
                        </div>
                        <div class="newsletter-form mb--30">
                            <form action="./php/mail.php">
                                <input type="email" class="form-control" placeholder="Vui lòng nhập Email tại đây...">
                                <button class="btn btn--primary w-100">Đăng ký</button>
                            </form>
                        </div>
                        <div class="social-block">
                            <h3 class="title">Thông tin của Pustok</h3>
                            <ul class="social-list list-inline">
                                <li class="single-social facebook"><a href=""><i class="ion ion-social-facebook"></i></a>
                                </li>
                                <li class="single-social twitter"><a href=""><i class="ion ion-social-twitter"></i></a></li>
                                <li class="single-social google"><a href=""><i class="ion ion-social-googleplus-outline"></i></a></li>
                                <li class="single-social youtube"><a href=""><i class="ion ion-social-youtube"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <h2 class="font-weight-bold" style="color:white">Miễn trừ trách nhiệm </h2>
                    <p class="copyright-heading">Trang web này cung cấp nội dung sách chỉ với mục đích giải trí và không chịu trách nhiệm về bất kỳ nội dung quảng cáo, liên kết của bên thứ ba hiển thị trên trang web của chúng tôi.
Tất cả thông tin và hình ảnh trên website đều được thu thập từ internet. Chúng tôi không chịu trách nhiệm về bất kỳ nội dung nào. Nếu bạn hoặc tổ chức của bạn có vấn đề gì liên quan đến nội dung hiển thị trên website, vui lòng liên hệ với chúng tôi để được giải quyết.</p>
                    <a href="#" class="payment-block">
                        <img src="image/icon/payment.png" alt="">
                    </a>
                    <p class="copyright-text">Copyright © 2022 <a href="#" class="author">Pustok</a>. All Right Reserved.
                        <br>
                        Design By Pustok</p>
                </div>
            </div>
        </footer>
        <!-- Use Minified Plugins Version For Fast Page Load -->
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/ajax-mail.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>

</html>

