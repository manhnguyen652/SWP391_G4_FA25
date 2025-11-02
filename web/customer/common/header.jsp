<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DAO.CategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%
    // Load categoryList nếu chưa có trong request
    if (request.getAttribute("categoryList") == null) {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);
    }
%> 
        <style>
            .cart-block {
                display: flex !important;
                align-items: center !important;
                position: relative !important;
                cursor: pointer !important;
            }

            .cart-block::before {
                margin-right: 10px !important;
                font-size: 30px !important;
                line-height: 1 !important;
            }

            .cart-total {

                display: flex !important;
                flex-direction: column !important;
                align-items: flex-start !important;
                position: relative !important;
                padding-right: 0 !important;
            }

            .cart-total .top-line {
                display: flex !important;
                align-items: center !important;
                margin-bottom: 2px !important;
            }

            .cart-total .text-item {
                order: 1 !important;
                font-size: 14px !important;
                font-weight: 600 !important;
                color: #333 !important;
                margin-right: 8px !important;
                line-height: 1.2 !important;
                white-space: nowrap;
            }

            .cart-total .text-number {
                order: 2 !important;
                position: static !important;
                width: auto !important;
                height: auto !important;
                line-height: 1 !important;
                padding: 2px 6px !important;
                font-size: 11px !important;
                margin-right: 0 !important;
                border-radius: 4px !important;
                background: #bd0018 !important;
                color: #fff !important;
                font-weight: 700 !important;
                text-align: center !important;
            }

            .cart-total .price {
                order: 3 !important;
                font-size: 15px !important;
                font-weight: 600 !important;
                color: #62ab00 !important;
                line-height: 1.2 !important;
                margin-left: 0 !important;
                white-space: nowrap;
            }

            .cart-total .price i {
                margin-left: 5px !important;
                font-size: 10px !important;
                color: #777 !important;
            }

            .cart-dropdown-block {
                top: calc(100% + 5px) !important;
                right: 0 !important;
                left: auto !important;
            }


            .header-links .dropdown {
                margin-right: 20px !important;
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
                                                            <li><a class="dropdown-item" href="wishlist">Danh sách yêu thích</a></li>
                                                            <li><a class="dropdown-item" href="compare">Danh sách so sánh</a></li>
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
                                                        <a href="cart?action=checkoutAll" class="btn btn--primary">Thanh toán <i class="fas fa-chevron-right"></i></a>
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
                                    <c:forEach var="cat" items="${categoryList}">
                                        <li class="cat-item">
                                            <a href="search?categoryId=${cat.id}">${cat.cateName}</a>
                                        </li>
                                    </c:forEach>
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
                                <!-- Blog -->
                                <li class="menu-item has-children mega-menu">
                                    <a href="javascript:void(0)">Blog</a>
                                </li>
                                <li class="menu-item">
                                    <a href="contact">Liên hệ</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>