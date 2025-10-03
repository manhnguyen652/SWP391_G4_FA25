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
                                            <a href="javascript:void(0)">Home <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                            <ul class="sub-menu">
                                                <li> <a href="index.html">Home One</a></li>
                                                <li> <a href="index-2.html">Home Two</a></li>
                                                <li> <a href="index-3.html">Home Three</a></li>
                                                <li> <a href="index-4.html">Home Four</a></li>
                                            </ul>
                                        </li>
                                        <!-- Shop -->
                                        <li class="menu-item has-children mega-menu">
                                            <a href="javascript:void(0)">shop <i class="fas fa-chevron-down dropdown-arrow"></i></a>
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
                                        </li>
                                        <!-- Pages -->
                                        <li class="menu-item has-children">
                                            <a href="javascript:void(0)">Pages <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                            <ul class="sub-menu">
                                                <li><a href="cart.html">Cart</a></li>
                                                <li><a href="checkout.html">Checkout</a></li>
                                                <li><a href="compare.html">Compare</a></li>
                                                <li><a href="wishlist.html">Wishlist</a></li>
                                                <li><a href="login-register.html">Login Register</a></li>
                                                <li><a href="my-account.html">My Account</a></li>
                                                <li><a href="order-complete.html">Order Complete</a></li>
                                                <li><a href="faq.html">Faq</a></li>
                                                <li><a href="contact-2.html">contact 02</a></li>
                                            </ul>
                                        </li>
                                        <!-- Blog -->
                                        <li class="menu-item has-children mega-menu">
                                            <a href="javascript:void(0)">Blog <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                            <ul class="sub-menu three-column">
                                                <li class="cus-col-33">
                                                    <h3 class="menu-title"><a href="javascript:void(0)">Blog Grid</a></h3>
                                                    <ul class="mega-single-block">
                                                        <li><a href="blog.html">Full Widh (Default)</a></li>
                                                        <li><a href="blog-left-sidebar.html">left Sidebar</a></li>
                                                        <li><a href="blog-right-sidebar.html">Right Sidebar</a></li>
                                                    </ul>
                                                </li>
                                                <li class="cus-col-33">
                                                    <h3 class="menu-title"><a href="javascript:void(0)">Blog List </a></h3>
                                                    <ul class="mega-single-block">
                                                        <!-- <li><a href="blog-list.html">Full Widh (Default)</a></li> -->
                                                        <li><a href="blog-list-left-sidebar.html">left Sidebar</a></li>
                                                        <li><a href="blog-list-right-sidebar.html">Right Sidebar</a></li>
                                                    </ul>
                                                </li>
                                                <li class="cus-col-33">
                                                    <h3 class="menu-title"><a href="javascript:void(0)">Blog Details</a>
                                                    </h3>
                                                    <ul class="mega-single-block">
                                                        <li><a href="blog-details.html">Image Format (Default)</a></li>
                                                        <li><a href="blog-details-gallery.html">Gallery Format</a></li>
                                                        <li><a href="blog-details-audio.html">Audio Format</a></li>
                                                        <li><a href="blog-details-video.html">Video Format</a></li>
                                                        <li><a href="blog-details-left-sidebar.html">left Sidebar</a></li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="menu-item">
                                            <a href="contact.html">Contact</a>
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
                                        <a href="javascript:void(0)" class="category-trigger"><i class="fa fa-bars"></i>Browse
                                            categories</a>
                                        <ul class="category-menu">
                                            <li class="cat-item has-children">
                                                <a href="#">Arts &amp; Photography</a>
                                                <ul class="sub-menu">
                                                    <li><a href="#">Bags &amp; Cases</a></li>
                                                    <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                    <li><a href="#">Digital Cameras</a></li>
                                                    <li><a href="#">Film Photography</a></li>
                                                    <li><a href="#">Lighting &amp; Studio</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children mega-menu"><a href="#">Biographies</a>
                                                <ul class="sub-menu">
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Business &amp; Money</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Calendars</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Children's Books</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Comics</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item"><a href="#">Perfomance Filters</a></li>
                                            <li class="cat-item has-children"><a href="#">Cookbooks</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item "><a href="#">Accessories</a></li>
                                            <li class="cat-item "><a href="#">Education</a></li>
                                            <li class="cat-item hidden-menu-item" style="display: none;"><a href="#">Indoor Living</a></li>
                                            <li class="cat-item"><a href="#" class="js-expand-hidden-menu">More
                                                    Categories</a></li>
                                        </ul>
                                    </div>
                                </nav>
                            </div>
                            <div class="col-lg-5">
                                <div class="header-search-block">
                                    <input type="text" placeholder="Search entire store here">
                                    <button>Search</button>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="main-navigation flex-lg-right">
                                    <div class="cart-widget">
                                        <div class="login-block">
                                            <a href="login-register.html" class="font-weight-bold">Login</a> <br>
                                            <span>or</span><a href="login-register.html">Register</a>
                                        </div>
                                        <div class="cart-block">
                                            <div class="cart-total">
                                                <span class="text-number">
                                                    1
                                                </span>
                                                <span class="text-item">
                                                    Shopping Cart
                                                </span>
                                                <span class="price">
                                                    £0.00
                                                    <i class="fas fa-chevron-down"></i>
                                                </span>
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
                                                        <a href="cart.html" class="btn">View Cart <i class="fas fa-chevron-right"></i></a>
                                                        <a href="checkout.html" class="btn btn--primary">Check Out <i class="fas fa-chevron-right"></i></a>
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
            <div class="site-mobile-menu">
                <header class="mobile-header d-block d-lg-none pt--10 pb-md--10">
                    <div class="container">
                        <div class="row align-items-sm-end align-items-center">
                            <div class="col-md-4 col-7">
                                <a href="index.html" class="site-brand">
                                    <img src="image/logo.png" alt="">
                                </a>
                            </div>
                            <div class="col-md-5 order-3 order-md-2">
                                <nav class="category-nav   ">
                                    <div>
                                        <a href="javascript:void(0)" class="category-trigger"><i class="fa fa-bars"></i>Browse
                                            categories</a>
                                        <ul class="category-menu">
                                            <li class="cat-item has-children">
                                                <a href="#">Arts &amp; Photography</a>
                                                <ul class="sub-menu">
                                                    <li><a href="#">Bags &amp; Cases</a></li>
                                                    <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                    <li><a href="#">Digital Cameras</a></li>
                                                    <li><a href="#">Film Photography</a></li>
                                                    <li><a href="#">Lighting &amp; Studio</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children mega-menu"><a href="#">Biographies</a>
                                                <ul class="sub-menu">
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="single-block">
                                                        <h3 class="title">WHEEL SIMULATORS</h3>
                                                        <ul>
                                                            <li><a href="#">Bags &amp; Cases</a></li>
                                                            <li><a href="#">Binoculars &amp; Scopes</a></li>
                                                            <li><a href="#">Digital Cameras</a></li>
                                                            <li><a href="#">Film Photography</a></li>
                                                            <li><a href="#">Lighting &amp; Studio</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Business &amp; Money</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Calendars</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Children's Books</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item has-children"><a href="#">Comics</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item"><a href="#">Perfomance Filters</a></li>
                                            <li class="cat-item has-children"><a href="#">Cookbooks</a>
                                                <ul class="sub-menu">
                                                    <li><a href="">Brake Tools</a></li>
                                                    <li><a href="">Driveshafts</a></li>
                                                    <li><a href="">Emergency Brake</a></li>
                                                    <li><a href="">Spools</a></li>
                                                </ul>
                                            </li>
                                            <li class="cat-item "><a href="#">Accessories</a></li>
                                            <li class="cat-item "><a href="#">Education</a></li>
                                            <li class="cat-item hidden-menu-item" style="display: none;"><a href="#">Indoor Living</a></li>
                                            <li class="cat-item"><a href="#" class="js-expand-hidden-menu">More
                                                    Categories</a></li>
                                        </ul>
                                    </div>
                                </nav>
                            </div>
                            <div class="col-md-3 col-5  order-md-3 text-right">
                                <div class="mobile-header-btns header-top-widget">
                                    <ul class="header-links">
                                        <li class="sin-link">
                                            <a href="cart.html" class="cart-link link-icon"><i class="ion-bag"></i></a>
                                        </li>
                                        <li class="sin-link">
                                            <a href="javascript:" class="link-icon hamburgur-icon off-canvas-btn"><i class="ion-navicon"></i></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </header>
                <!--Off Canvas Navigation Start-->
                <aside class="off-canvas-wrapper">
                    <div class="btn-close-off-canvas">
                        <i class="ion-android-close"></i>
                    </div>
                    <div class="off-canvas-inner">
                        <!-- search box start -->
                        <div class="search-box offcanvas">
                            <form>
                                <input type="text" placeholder="Search Here">
                                <button class="search-btn"><i class="ion-ios-search-strong"></i></button>
                            </form>
                        </div>
                        <!-- search box end -->
                        <!-- mobile menu start -->
                        <div class="mobile-navigation">
                            <!-- mobile menu navigation start -->
                            <nav class="off-canvas-nav">
                                <ul class="mobile-menu main-mobile-menu">
                                    <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                        <a href="#">Home</a>
                                        <ul class="sub-menu" style="display: none;">
                                            <li> <a href="index.html">Home One</a></li>
                                            <li> <a href="index-2.html">Home Two</a></li>
                                            <li> <a href="index-3.html">Home Three</a></li>
                                            <li> <a href="index-4.html">Home Four</a></li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                        <a href="#">Blog</a>
                                        <ul class="sub-menu" style="display: none;">
                                            <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                                <a href="#">Blog Grid</a>
                                                <ul class="sub-menu" style="display: none;">
                                                    <li><a href="blog.html">Full Widh (Default)</a></li>
                                                    <li><a href="blog-left-sidebar.html">left Sidebar</a></li>
                                                    <li><a href="blog-right-sidebar.html">Right Sidebar</a></li>
                                                </ul>
                                            </li>
                                            <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                                <a href="#">Blog List</a>
                                                <ul class="sub-menu" style="display: none;">
                                                    <li><a href="blog-list.html">Full Widh (Default)</a></li>
                                                    <li><a href="blog-list-left-sidebar.html">left Sidebar</a></li>
                                                    <li><a href="blog-list-right-sidebar.html">Right Sidebar</a></li>
                                                </ul>
                                            </li>
                                            <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                                <a href="#">Blog Details</a>
                                                <ul class="sub-menu" style="display: none;">
                                                    <li><a href="blog-details.html">Image Format (Default)</a></li>
                                                    <li><a href="blog-details-gallery.html">Gallery Format</a></li>
                                                    <li><a href="blog-details-audio.html">Audio Format</a></li>
                                                    <li><a href="blog-details-video.html">Video Format</a></li>
                                                    <li><a href="blog-details-left-sidebar.html">left Sidebar</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                        <a href="#">Shop</a>
                                        <ul class="sub-menu" style="display: none;">
                                            <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                                <a href="#">Shop Grid</a>
                                                <ul class="sub-menu" style="display: none;">
                                                    <li><a href="shop-grid.html">Fullwidth</a></li>
                                                    <li><a href="shop-grid-left-sidebar.html">left Sidebar</a></li>
                                                    <li><a href="shop-grid-right-sidebar.html">Right Sidebar</a></li>
                                                </ul>
                                            </li>
                                            <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                                <a href="#">Shop List</a>
                                                <ul class="sub-menu" style="display: none;">
                                                    <li><a href="shop-list.html">Fullwidth</a></li>
                                                    <li><a href="shop-list-left-sidebar.html">left Sidebar</a></li>
                                                    <li><a href="shop-list-right-sidebar.html">Right Sidebar</a></li>
                                                </ul>
                                            </li>
                                            <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                                <a href="#">Product Details 1</a>
                                                <ul class="sub-menu" style="display: none;">
                                                    <li><a href="product-details.html">Product Details Page</a></li>
                                                    <li><a href="product-details-affiliate.html">Product Details
                                                            Affiliate</a></li>
                                                    <li><a href="product-details-group.html">Product Details Group</a></li>
                                                    <li><a href="product-details-variable.html">Product Details
                                                            Variables</a></li>
                                                </ul>
                                            </li>
                                            <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                                <a href="#">Product Details 2</a>
                                                <ul class="sub-menu" style="display: none;">
                                                    <li><a href="product-details-left-thumbnail.html">left Thumbnail</a>
                                                    </li>
                                                    <li><a href="product-details-right-thumbnail.html">Right Thumbnail</a>
                                                    </li>
                                                    <li><a href="product-details-left-gallery.html">Left Gallery</a></li>
                                                    <li><a href="product-details-right-gallery.html">Right Gallery</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                        <a href="#">Pages</a>
                                        <ul class="sub-menu" style="display: none;">
                                            <li><a href="cart.html">Cart</a></li>
                                            <li><a href="checkout.html">Checkout</a></li>
                                            <li><a href="compare.html">Compare</a></li>
                                            <li><a href="wishlist.html">Wishlist</a></li>
                                            <li><a href="login-register.html">Login Register</a></li>
                                            <li><a href="my-account.html">My Account</a></li>
                                            <li><a href="order-complete.html">Order Complete</a></li>
                                            <li><a href="faq.html">Faq</a></li>
                                            <li><a href="contact-2.html">contact 02</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="contact.html">Contact</a></li>
                                </ul>
                            </nav>
                            <!-- mobile menu navigation end -->
                        </div>
                        <!-- mobile menu end -->
                        <nav class="off-canvas-nav">
                            <ul class="mobile-menu menu-block-2">
                                <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                    <a href="#">Currency - USD $ <i class="fas fa-angle-down"></i></a>
                                    <ul class="sub-menu" style="display: none;">
                                        <li> <a href="cart.html">USD $</a></li>
                                        <li> <a href="checkout.html">EUR €</a></li>
                                    </ul>
                                </li>
                                <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                    <a href="#">Lang - Eng<i class="fas fa-angle-down"></i></a>
                                    <ul class="sub-menu" style="display: none;">
                                        <li>Eng</li>
                                        <li>Ban</li>
                                    </ul>
                                </li>
                                <li class="menu-item-has-children"><span class="menu-expand"><i class="fas fa-chevron-down"></i></span>
                                    <a href="#">My Account <i class="fas fa-angle-down"></i></a>
                                    <ul class="sub-menu" style="display: none;">
                                        <li><a href="">My Account</a></li>
                                        <li><a href="">Order History</a></li>
                                        <li><a href="">Transactions</a></li>
                                        <li><a href="">Downloads</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                        <div class="off-canvas-bottom">
                            <div class="contact-list mb--10">
                                <a href="" class="sin-contact"><i class="fas fa-mobile-alt"></i>(12345) 78790220</a>
                                <a href="" class="sin-contact"><i class="fas fa-envelope"></i>examle@handart.com</a>
                            </div>
                            <div class="off-canvas-social">
                                <a href="#" class="single-icon"><i class="fab fa-facebook-f"></i></a>
                                <a href="#" class="single-icon"><i class="fab fa-twitter"></i></a>
                                <a href="#" class="single-icon"><i class="fas fa-rss"></i></a>
                                <a href="#" class="single-icon"><i class="fab fa-youtube"></i></a>
                                <a href="#" class="single-icon"><i class="fab fa-google-plus-g"></i></a>
                                <a href="#" class="single-icon"><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </aside>
                <!--Off Canvas Navigation End-->
            </div>
            <div class="sticky-init common-sticky">
                <div class="container d-none d-lg-block">
                    <div class="row align-items-center">
                        <div class="col-lg-4">
                            <a href="index.html" class="site-brand">
                                <img src="image/logo.png" alt="">
                            </a>
                        </div>
                        <div class="col-lg-8">
                            <div class="main-navigation flex-lg-right">
                                <ul class="main-menu menu-right ">
                                    <li class="menu-item has-children">
                                        <a href="javascript:void(0)">Home <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                        <ul class="sub-menu">
                                            <li> <a href="index.html">Home One</a></li>
                                            <li> <a href="index-2.html">Home Two</a></li>
                                            <li> <a href="index-3.html">Home Three</a></li>
                                            <li> <a href="index-4.html">Home Four</a></li>
                                        </ul>
                                    </li>
                                    <!-- Shop -->
                                    <li class="menu-item has-children mega-menu">
                                        <a href="javascript:void(0)">shop <i class="fas fa-chevron-down dropdown-arrow"></i></a>
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
                                                <h3 class="menu-title"> <a href="javascript:void(0)">Product Details 1</a>
                                                </h3>
                                                <ul class="mega-single-block">
                                                    <li><a href="product-details.html">Product Details Page</a></li>
                                                    <li><a href="product-details-affiliate.html">Product Details
                                                            Affiliate</a></li>
                                                    <li><a href="product-details-group.html">Product Details Group</a></li>
                                                    <li><a href="product-details-variable.html">Product Details
                                                            Variables</a></li>
                                                </ul>
                                            </li>
                                            <li class="cus-col-25">
                                                <h3 class="menu-title"><a href="javascript:void(0)">Product Details 2</a>
                                                </h3>
                                                <ul class="mega-single-block">
                                                    <li><a href="product-details-left-thumbnail.html">left Thumbnail</a>
                                                    </li>
                                                    <li><a href="product-details-right-thumbnail.html">Right Thumbnail</a>
                                                    </li>
                                                    <li><a href="product-details-left-gallery.html">Left Gallery</a></li>
                                                    <li><a href="product-details-right-gallery.html">Right Gallery</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <!-- Pages -->
                                    <li class="menu-item has-children">
                                        <a href="javascript:void(0)">Pages <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="cart.html">Cart</a></li>
                                            <li><a href="checkout.html">Checkout</a></li>
                                            <li><a href="compare.html">Compare</a></li>
                                            <li><a href="wishlist.html">Wishlist</a></li>
                                            <li><a href="login-register.html">Login Register</a></li>
                                            <li><a href="my-account.html">My Account</a></li>
                                            <li><a href="order-complete.html">Order Complete</a></li>
                                            <li><a href="faq.html">Faq</a></li>
                                            <li><a href="contact-2.html">contact 02</a></li>
                                        </ul>
                                    </li>
                                    <!-- Blog -->
                                    <li class="menu-item has-children mega-menu">
                                        <a href="javascript:void(0)">Blog <i class="fas fa-chevron-down dropdown-arrow"></i></a>
                                        <ul class="sub-menu three-column">
                                            <li class="cus-col-33">
                                                <h3 class="menu-title"><a href="javascript:void(0)">Blog Grid</a></h3>
                                                <ul class="mega-single-block">
                                                    <li><a href="blog.html">Full Widh (Default)</a></li>
                                                    <li><a href="blog-left-sidebar.html">left Sidebar</a></li>
                                                    <li><a href="blog-right-sidebar.html">Right Sidebar</a></li>
                                                </ul>
                                            </li>
                                            <li class="cus-col-33">
                                                <h3 class="menu-title"><a href="javascript:void(0)">Blog List </a></h3>
                                                <ul class="mega-single-block">
                                                    <!-- <li><a href="blog-list.html">Full Widh (Default)</a></li> -->
                                                    <li><a href="blog-list-left-sidebar.html">left Sidebar</a></li>
                                                    <li><a href="blog-list-right-sidebar.html">Right Sidebar</a></li>
                                                </ul>
                                            </li>
                                            <li class="cus-col-33">
                                                <h3 class="menu-title"><a href="javascript:void(0)">Blog Details</a></h3>
                                                <ul class="mega-single-block">
                                                    <li><a href="blog-details.html">Image Format (Default)</a></li>
                                                    <li><a href="blog-details-gallery.html">Gallery Format</a></li>
                                                    <li><a href="blog-details-audio.html">Audio Format</a></li>
                                                    <li><a href="blog-details-video.html">Video Format</a></li>
                                                    <li><a href="blog-details-left-sidebar.html">left Sidebar</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="menu-item">
                                        <a href="contact.html">Contact</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <section class="breadcrumb-section">
                <h2 class="sr-only">Site Breadcrumb</h2>
                <div class="container">
                    <div class="breadcrumb-contents">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                <li class="breadcrumb-item active">Login</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </section>
            <!--=============================================
=            Login Register page content         =
=============================================-->
            <main class="page-section inner-page-sec-padding-bottom">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-xs-12 col-lg-6 mb--30 mb-lg--0">
                            <!-- Login Form s-->
                            <form action="login-register" method="post">
                                <div class="login-form">
                                    <h4 class="login-title">New Customer</h4>
                                    <p><span class="font-weight-bold">I am a new customer</span></p>
                                    <div class="row">
                                        <div class="col-md-12 col-12 mb--15">
                                            <label for="name">Full Name</label>
                                            <input class="mb-0 form-control" type="text" name="fullname" id="name" placeholder="Enter your full name">
                                        </div>
                                        <div class="col-12 mb--20">
                                            <label for="email">Email</label>
                                            <input class="mb-0 form-control" type="email" name="email" id="email" placeholder="Enter Your Email Address Here..">
                                        </div>
                                        <div class="col-lg-6 mb--20">
                                            <label for="password">Password</label>
                                            <input class="mb-0 form-control" type="password" name="password" id="password" placeholder="Enter your password">
                                        </div>
                                        <div class="col-lg-6 mb--20">
                                            <label for="repeat-password">Repeat Password</label>
                                            <input class="mb-0 form-control" type="password" name="repeat_password" id="repeat-password" placeholder="Repeat your password">
                                        </div>
                                        <div class="col-md-12">
                                            <button type="submit" class="btn btn-outlined">Register</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-6 col-xs-12">
                            <form action="login-register" method="post">
                                <div class="login-form">
                                    <h4 class="login-title">Returning Customer</h4>
                                    <p><span class="font-weight-bold">I am a returning customer</span></p>
                                    <div class="row">
                                        <div class="col-md-12 col-12 mb--15">
                                            <label for="email1">Enter your email address here...</label>
                                            <input class="mb-0 form-control" type="email" name="login_email" id="email1" placeholder="Enter your email address here...">
                                        </div>
                                        <div class="col-12 mb--20">
                                            <label for="login-password">Password</label>
                                            <input class="mb-0 form-control" type="password" name="login_password" id="login-password" placeholder="Enter your password">
                                        </div>
                                        <div class="col-md-12">
                                            <button type="submit" class="btn btn-outlined">Login</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
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
                                <p><span class="label">Address:</span><span class="text">Example Street 98, HH2 BacHa, New
                                        York, USA</span></p>
                                <p><span class="label">Phone:</span><span class="text">+18088 234 5678</span></p>
                                <p><span class="label">Email:</span><span class="text">suport@hastech.com</span></p>
                            </div>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-2 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="footer-title">
                                <h3>Information</h3>
                            </div>
                            <ul class="footer-list normal-list">
                                <li><a href="">Prices drop</a></li>
                                <li><a href="">New products</a></li>
                                <li><a href="">Best sales</a></li>
                                <li><a href="">Contact us</a></li>
                                <li><a href="">Sitemap</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-2 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="footer-title">
                                <h3>Extras</h3>
                            </div>
                            <ul class="footer-list normal-list">
                                <li><a href="">Delivery</a></li>
                                <li><a href="">About Us</a></li>
                                <li><a href="">Stores</a></li>
                                <li><a href="">Contact us</a></li>
                                <li><a href="">Sitemap</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-4 col-sm-6">
                        <div class="footer-title">
                            <h3>Newsletter Subscribe</h3>
                        </div>
                        <div class="newsletter-form mb--30">
                            <form action="./php/mail.php">
                                <input type="email" class="form-control" placeholder="Enter Your Email Address Here...">
                                <button class="btn btn--primary w-100">Subscribe</button>
                            </form>
                        </div>
                        <div class="social-block">
                            <h3 class="title">STAY CONNECTED</h3>
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
                    <p class="copyright-heading">Suspendisse in auctor augue. Cras fermentum est ac fermentum tempor. Etiam
                        vel magna volutpat, posuere eros</p>
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
        <script src="js/plugins.js"></script>
        <script src="js/ajax-mail.js"></script>
        <script src="js/custom.js"></script>


        <a id="scrollUp" href="#top" style="position: fixed; z-index: 2147483647;"><i class="ion-chevron-right"></i><i class="ion-chevron-right"></i></a><div id="envidictionary"><div class="o-search-mobile" style="top: 0px; left: 0px; display: none;"><img alt="ENVI" width="27" height="27" src="data:image/png;base64,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" style="width: 27px; height: 27px;"></div><div class="o-popup-tag o-bg-white o-border o-rounded o-shadow" style="width: 400px; top: 0px; left: 0px; display: none;"><div><button type="button" aria-label="Close" class="o-btn-close o-position-absolute o-top-0 o-end-0 o-mt-1 o-me-1"></button><ul role="tablist" class="o-nav o-nav-tabs o-pop-nav"><span><svg aria-hidden="true" focusable="false" data-icon="volume-high" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="o-pop-speak o-link-secondary o-svg-inline--fa"><path fill="currentColor" d="M533.6 32.5C598.5 85.3 640 165.8 640 256s-41.5 170.8-106.4 223.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C557.5 398.2 592 331.2 592 256s-34.5-142.2-88.7-186.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM473.1 107c43.2 35.2 70.9 88.9 70.9 149s-27.7 113.8-70.9 149c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C475.3 341.3 496 301.1 496 256s-20.7-85.3-53.2-111.8c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zm-60.5 74.5C434.1 199.1 448 225.9 448 256s-13.9 56.9-35.4 74.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C393.1 284.4 400 271 400 256s-6.9-28.4-17.7-37.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM301.1 34.8C312.6 40 320 51.4 320 64V448c0 12.6-7.4 24-18.9 29.2s-25 3.1-34.4-5.3L131.8 352H64c-35.3 0-64-28.7-64-64V224c0-35.3 28.7-64 64-64h67.8L266.7 40.1c9.4-8.4 22.9-10.4 34.4-5.3z"></path></svg></span><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="true" class="o-nav-link o-active">Tra cứu</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Dịch</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Cài đặt</div></li></ul><div class="o-selected-result o-pt-1"><div> Đang tìm kiếm ... </div></div></div></div></div><div id="envidictionarySetting" url="https://envi.jpdictionary.com/setting/"></div><div id="envidictionaryOff"></div><div id="tudienjp"><div class="o-search-mobile" style="top: 0px; left: 0px; display: none;"><img alt="Từ điển JP" width="27" height="27" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADYAAAA2CAYAAACMRWrdAAAACXBIWXMAADsOAAA7DgHMtqGDAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAyxSURBVHjazJprcFzVfcB/55z73F15V29ZxjaxjS0wKQ8TAy6kBlo6UFxIG7dp8gE60xJmmnSajjt9MGmSmZZ+aGnazIRxpjRMkmlSUpoE0pImwSHkUQrGDHaCwY6xsY1ly5JWWu3efdx7zzn9sLJka2Ujm1XiM7Mj6e7Rvff3f5//OcJaCwCfAjSMZhv81C8SVGxHXek/JuW3TGrW5Ho8xw2kNnp6/i9ueCB8pcxDKowetApcbTEVTVSH6/9kCABnZrppfgSQpOn7bGKfMImVAmhevZiGJU35q7jcudOtmW9UjMW5PMclA3JmxgxY1TEErqSU1D+c1OPtSjhIJNZKrIGmYu3FwyYlQbU+hCs5MtTD4BUuy5bRCrazcBKTmOviqfp2N85Ra+QRQuO4dYwBnXiQiS4aLpUaklBy/MpuKhkXr2qAeTRmdSrSiE80JgbJFsZZvmYHnUv3k1kyiheMMzGyieMHtuK4ZRBNzQkJOrbEU4a2Wqxt3stfopAuWNM6xWloRtYWPlru9X4nHEmFzsptUcqOrDMHzJzs2tKoi7uWX/kc6258nEz/QZLJfqpT/Si3gVQxds6b64ZFSFh6Y4gbSkzaHlOVjiCODMXXGui4+XcLe/PSoIwZDALBSMk+861XzNb3XyefOFNjMrp+6KanWHPrvxAdXc/uJ/+C4vA6GlEBrR3yA4JMoYRJZ6Wa1CyX3p5h2dUZDGYeD7QIFAIXQ2PmqkDOUa/FYk77HiSSo3nJkR1V/Pz8piBMU9RCNLVqYnsbcCbYVb/x9309q3Zx/OUt7Hzyz4hKHku6awS5cRw0ysmBldPhs3kjxxfkljqkGOLItJqiMQhfIVyBbQhMHCM9D+V7ZwhBTH/SOMbGMQiJn4XcUgflCaxpmv1ZLdc24RwHt8XHelb8RB3bczs/+sqf07viCFfe8j90Lt1PkBvHy4wycuh2Du/5MK4/OeNjCNCJbb7kPEJ1cjmmvv0ME5/5HH0P/y3h0FrSSoWxzz1GffdPsbUaIHAG+8ltuYPcr9yEEQIbx1ia974A72ya86lfhvdutnufu5crbv4mt/7h/ay6/j8QMqU4PMTooQ3UppYhnWSuBZ1zCCDeu4/y00+SHD6KC9R3vcLYJx4iPXQYmcsiMwHVHT/grXs+SHH7v6JcF5S60JgjWjR2/MANDN30ZZZv+gonXt7CwV1bqBQvIU0CjJYUBiDbOYVOzy/0yY4cbu9yZBg0H54kgKBw/330fOC3SQEdxwzf+wDjDz1M9pb34q+7DKgv+BlCgDZQi4lawNZs/Br5pa/xs29/hNd//CGETAlyRXy3jjUWx3exVl5Akp4jCMcBKWf8SgCh5+Gvu4zoO98jLRYJFghjjSRNwNQVgWvHr1zGV1vAct1HeHPX3bz6g3vJ5EdwvVoTZDqniDZWVTIMSI4NEx0/ji5XqD2/k4lHv0i4cQPhhmswWOTb3MNoD9cfI1c4Sood7il03HTFysFDpwQ5AzZ66Fre2PWbBNlJXK8+rZ3ztHFrccMQISVJtXrWec7yZUw98SQT2z8PQmCiKuGmjfQ99NdIz0NHEWTV24B14Gd2U+j9P4zrD/rBwMfHGxu3DWaGimeA7X/h/egkwM+UsPbC1KOyWSrPv4CNauR+dXPTZDwXqzU21TPz0uETFO6/j9xdv44eHUN2dxOuH0J6HkkUIRZiHsJgjYfWeRR5ylHj938y9cyxwdVDHz8DrF7utY4XXTAUUiKBiU8/QvTsD1mzbxd+Vyd6vIjVGuHMasBUIvzV7yJ/1btJTlUxWpMuFGpOBrTWoqSLlGqgxcccvyqw78CRTDNxd2x9H+WnvsXwH3yE8MaNTDzyKOH11xG851oMYGt1dHGEdGKSFEhPN9l36MgC2Rru2zF0HJPfeg+kCcXPbGfis48SbtpI7yf/EicMSQFncIDwhk24l65Y1EXQOwITAsSskLBJgrGWwu9tJXvn7ZipMu7SAaTjNH0H8IfWsvLZ/wIEaRSdU0tCnqcSrTDvHGy6nMKCi8QG03kBDbaOn89DPo9FY00VN5zOgcIiRIC18XSJLs4icQmm+Qzpi/lfQBiESBAinU6vZt87BjtVlB5/oYZ7m0BIcdqyRQPRWcq4ud/ZeZctjTTh+M76grRmtYoJGw/Y7rHH2mKKXoekdChl75emcEIx74LwQoWWVC0mbj5jvvsqVaJeWU/x+C8RTFKudJuXRnpTbmkHmDXgZgUmsSRl29YVtFDNe59NWEJqtF5CXM8iDN1ynD39FT7ANTzetqgoXcHsSujn1KeyIIRBKRCOxrHg1NkMqk1g9lQHq/1DyPMLZqmaZ6F5oeE+bVhMep4vsUAzVx4o/7x817YFrDFlWHZTSN+1/mynqi2qAjcjOfK9KsXXYrwOuVDzbE/l4QSC8ltpU2txe+1ROoLGhMEJxIJVJdx5FpoXKlmTWHTVtq31NvOiCqw5e6SVGtJQUu0BP1KgOemmfPltwCw6CUkaGYxRGC3xO2K8TBn0rFmkNUv+XS59GxbHFI/uqFI9qfE6WumSTIYlR4/gnTyJ0c6JrFQ39vnZN1n/7rlgFiEsca2DuJEjVzhB5+Dr+JkJpFPDmFXUo7UIMduL8POS4f+tcfTZGkK1N3iY1OJmJX5BYnXr9/GSLrpf+Tqdr36Jejgw4PvO33QVvI+x9fOjZzZMjaJa7iHIjXPFe77O4NAPCQsjoB0IRhnddzf7d16LF8SI6VqzUTIMbgrpu9onLi+Cxr5fpfj6/MFDaIMOMtQKA5hsPxVrP1SqNA6vhQfPAIsml9K7YjdX3/FPhP1vMLb3Ft546R5q5R6E1UhvAD8szTRMTyXm+oRm8kBMWrdtBVOeIKmaZvI/5/JCNAOHEDhB2NfiY+tueJxVG/8TIeClf/87Th7agE69Zs/eCDovicnkq+hkVnpuVjD5s4Sx3XHbTdEa8HKiWVbp8yhHWsB++d+oV7p58RsPUhxeR67rGEqlWNtMkI7rYo06oxq3GpxQ4ISLtzG4YKg5vb4ZsEbUxd7n7qM4vI5875vNDT8rLqq9vgV0yUxLi/vgy1sYPXIVuc7hC2q9/WJAZreUBOBbXmvR2NG9m3HcOnLa/Fq2gyRIdfHsRadSInUVpSOsFsQunxzvyX36krlgykkQQrdCiaZI0tgCplkNXARDuRHVro3/GL71421+baS75g2MlbJ+a/AQUp/Vn4SE2mR68ZigsfjVMchfPp6s22ZX7H94LKgfxkvT8+9SiYvpRIQSNCoWXx+jnlvN0cu2EU5+HyH98wOzdjovS3FGu22uyVptwdhFPRbSbPmB4ysq47FNjhxkIuwE+UGcscYCwKZ3WOoTGpNYlDKITAZZKIBuTS7CcdClEqZcRjjOokRAISHodBBSEEea2mRqrRaIpARMTbfLe88NJgTUxjSF1R7Lbs7iLS9Q/e7zlL/wEKq7q7ULPDpK7ne3krnrVvTJ0qJoy88r9j0xwck9VaQrmpvwvpw3NpwVrF7UdF3uc80DPbjT6W6qu4g98N84jUtanC45eJCuJTfT2Q9Jf9h2KA9FuRQz9nqdNDZ4nmq6hX37Frc4vU5DwqW/1oGDoFxOcDsc4sQlCfqwbncLWBpExKlPDUgj3XYwJys59lJEdDwht8x924rIOS0Hp7P1mcXLKLysIsbMNmr8ANXXj+zuaQGTtRgRhosXNIAkMgtu7JymMTF6SgzCETQmNdXRhK4Bj3j6cIrwXGShC7mk0BL5VGcd4fuLVloawC8opDpPMNUQLxrPYOW0U7qCN56eIrfCZUneQwKpK9BxA5k2j0UIq7HT6xXdaOA6kAXSbPujokKw8sYO9q+apHwsJigohFqAj9U67Tel5mmnYe8EgZ9XVE+kvPzPYwxszOD09yBereJlFFZYnLQ0o7TEyePlFGP7a4x0gpicWoRyA7y8onCpj65ZkLa5E6PEucE6I9c4if5UQzXurDoOUluCLkUSGQ4+NUVd+QwkFdb5Y8Rxg2JhM8XCbRRKP6Jn4rv4wRgH9lQ4ui8iNKVFAbMWsn0OXWsCkqqhdKwhkoaZF24G7HAlJJW86HvuH3XL2meNmV5ghhInlASyhk7XMj76Xur+ckZ670HLLLVgBVp1kK3tI+5ZT8GroozDYo4kMkhPEPY5Nq7oc4Pt7MwTAatN/MjKqD5W9u3jCGaO8ikdkTidHF720eY/pmU8M4qRPqPddzDKnShTw9GVGb9bzKG1we0S+4Med969g9kDLClIAb4A2RBflY75TuzJP5VG3C2wK61QrjQNLWyCsBawWOEgrMZNS1ghENb8PKDcNDRBOO7+w1WPdX1NxRLtnkb2seaP/x8AePiSUmAe1i0AAAAASUVORK5CYII=" style="width: 27px; height: 27px;"></div><div class="o-popup-tag o-bg-white o-border o-rounded o-shadow" style="width: 400px; top: 0px; left: 0px; display: none;"><div><button type="button" aria-label="Close" class="btn-sm o-btn-close o-position-absolute o-top-0 o-end-0 o-mt-1 o-me-1"></button><ul role="tablist" class="o-nav o-nav-tabs o-pop-nav"><span><svg aria-hidden="true" focusable="false" data-icon="volume-high" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="o-pop-speak o-svg-inline--fa"><path fill="currentColor" d="M533.6 32.5C598.5 85.3 640 165.8 640 256s-41.5 170.8-106.4 223.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C557.5 398.2 592 331.2 592 256s-34.5-142.2-88.7-186.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM473.1 107c43.2 35.2 70.9 88.9 70.9 149s-27.7 113.8-70.9 149c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C475.3 341.3 496 301.1 496 256s-20.7-85.3-53.2-111.8c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zm-60.5 74.5C434.1 199.1 448 225.9 448 256s-13.9 56.9-35.4 74.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C393.1 284.4 400 271 400 256s-6.9-28.4-17.7-37.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM301.1 34.8C312.6 40 320 51.4 320 64V448c0 12.6-7.4 24-18.9 29.2s-25 3.1-34.4-5.3L131.8 352H64c-35.3 0-64-28.7-64-64V224c0-35.3 28.7-64 64-64h67.8L266.7 40.1c9.4-8.4 22.9-10.4 34.4-5.3z"></path></svg></span><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="true" class="o-nav-link o-active">Từ vựng</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Hán tự</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Dịch</div></li></ul><div class="o-selected-result o-pt-1"><div> Đang tìm kiếm ... </div><div class="o-fs-6 o-mt-2" style="line-height: 1.7;"><div class="o-float-start"><div class="o-form-check"><input type="checkbox" id="flexCheckTudienjpLang" class="o-form-check-input"><label for="flexCheckTudienjpLang"> Tiếng Anh </label></div></div><div class="o-float-end o-me-1"><a href="https://tudienjp.com/setting/" target="_blank" class="o-link-secondary o-text-decoration-none">Cài đặt</a></div></div></div></div></div></div><div id="tudienjpSetting" url="https://tudienjp.com/setting/"></div><div id="tudienjpOff"></div><div id="mttContainer" class="bootstrapiso notranslate" data-original-title="Bản tin đăng ký" title="" style="transform: translate(712px, 258px);" dir="ltr"></div></body>
</html>
