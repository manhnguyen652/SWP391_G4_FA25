
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
                            <div class="login-block">
                                <a href="login-register" class="font-weight-bold">Đăng nhập</a> <br>
                                <span>hoặc</span><a href="login-register">Đăng kí</a>
                            </div>
                            <div class="cart-block">
                                <div class="cart-total">
                                    <span class="text-number">
                                        1
                                    </span>
                                    <span class="text-item">
                                        Giỏ hàng
                                    </span>
                                    <span class="price">
                                        VND 0.00
                                        <i class="fas fa-chevron-down"></i>
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
                                    <a href="#">Arts & Photography</a>
                                    <ul class="sub-menu">
                                        <li><a href="#">Bags & Cases</a></li>
                                        <li><a href="#">Binoculars & Scopes</a></li>
                                        <li><a href="#">Digital Cameras</a></li>
                                        <li><a href="#">Film Photography</a></li>
                                        <li><a href="#">Lighting & Studio</a></li>
                                    </ul>
                                </li>
                                <li class="cat-item has-children mega-menu"><a href="#">Biographies</a>
                                    <ul class="sub-menu">
                                        <li class="single-block">
                                            <h3 class="title">WHEEL SIMULATORS</h3>
                                            <ul>
                                                <li><a href="#">Bags & Cases</a></li>
                                                <li><a href="#">Binoculars & Scopes</a></li>
                                                <li><a href="#">Digital Cameras</a></li>
                                                <li><a href="#">Film Photography</a></li>
                                                <li><a href="#">Lighting & Studio</a></li>
                                            </ul>
                                        </li>
                                        <li class="single-block">
                                            <h3 class="title">WHEEL SIMULATORS</h3>
                                            <ul>
                                                <li><a href="#">Bags & Cases</a></li>
                                                <li><a href="#">Binoculars & Scopes</a></li>
                                                <li><a href="#">Digital Cameras</a></li>
                                                <li><a href="#">Film Photography</a></li>
                                                <li><a href="#">Lighting & Studio</a></li>
                                            </ul>
                                        </li>
                                        <li class="single-block">
                                            <h3 class="title">WHEEL SIMULATORS</h3>
                                            <ul>
                                                <li><a href="#">Bags & Cases</a></li>
                                                <li><a href="#">Binoculars & Scopes</a></li>
                                                <li><a href="#">Digital Cameras</a></li>
                                                <li><a href="#">Film Photography</a></li>
                                                <li><a href="#">Lighting & Studio</a></li>
                                            </ul>
                                        </li>
                                        <li class="single-block">
                                            <h3 class="title">WHEEL SIMULATORS</h3>
                                            <ul>
                                                <li><a href="#">Bags & Cases</a></li>
                                                <li><a href="#">Binoculars & Scopes</a></li>
                                                <li><a href="#">Digital Cameras</a></li>
                                                <li><a href="#">Film Photography</a></li>
                                                <li><a href="#">Lighting & Studio</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li class="cat-item has-children"><a href="#">Business & Money</a>
                                    <ul class="sub-menu">
                                        <li><a href="#">Brake Tools</a></li>
                                        <li><a href="#">Driveshafts</a></li>
                                        <li><a href="#">Emergency Brake</a></li>
                                        <li><a href="#">Spools</a></li>
                                    </ul>
                                </li>
                                <li class="cat-item has-children"><a href="#">Calendars</a>
                                    <ul class="sub-menu">
                                        <li><a href="#">Brake Tools</a></li>
                                        <li><a href="#">Driveshafts</a></li>
                                        <li><a href="#">Emergency Brake</a></li>
                                        <li><a href="#">Spools</a></li>
                                    </ul>
                                </li>
                                <li class="cat-item has-children"><a href="#">Children's Books</a>
                                    <ul class="sub-menu">
                                        <li><a href="#">Brake Tools</a></li>
                                        <li><a href="#">Driveshafts</a></li>
                                        <li><a href="#">Emergency Brake</a></li>
                                        <li><a href="#">Spools</a></li>
                                    </ul>
                                </li>
                                <li class="cat-item has-children"><a href="#">Comics</a>
                                    <ul class="sub-menu">
                                        <li><a href="#">Brake Tools</a></li>
                                        <li><a href="#">Driveshafts</a></li>
                                        <li><a href="#">Emergency Brake</a></li>
                                        <li><a href="#">Spools</a></li>
                                    </ul>
                                </li>
                                <li class="cat-item"><a href="#">Perfomance Filters</a></li>
                                <li class="cat-item has-children"><a href="#">Cookbooks</a>
                                    <ul class="sub-menu">
                                        <li><a href="#">Brake Tools</a></li>
                                        <li><a href="#">Driveshafts</a></li>
                                        <li><a href="#">Emergency Brake</a></li>
                                        <li><a href="#">Spools</a></li>
                                    </ul>
                                </li>
                                <li class="cat-item "><a href="#">Accessories</a></li>
                                <li class="cat-item "><a href="#">Education</a></li>
                                <li class="cat-item hidden-menu-item"><a href="#">Indoor Living</a></li>
                                <li class="cat-item"><a href="#" class="js-expand-hidden-menu">More
                                        Categories</a></li>
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