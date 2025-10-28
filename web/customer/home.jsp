<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
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
                                    <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Trang chủ</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>
                <main class="inner-page-sec-padding-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-9 order-lg-2">
                                <div class="shop-toolbar with-sidebar mb--30">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-2 col-sm-6">
                                            <!-- Product View Mode -->
                                            <div class="product-view-mode">
                                                <a href="#" class="sorting-btn active" data-target="grid"><i
                                                        class="fas fa-th"></i></a>
                                                <a href="#" class="sorting-btn" data-target="grid-four">
                                                    <span class="grid-four-icon">
                                                        <i class="fas fa-grip-vertical"></i><i class="fas fa-grip-vertical"></i>
                                                    </span>
                                                </a>
                                                <a href="#" class="sorting-btn" data-target="list "><i
                                                        class="fas fa-list"></i></a>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-md-4 col-sm-6  mt--10 mt-sm--0">
                                            <span class="toolbar-status">
                                                Hiển thị 1 đến 9 của 14 (2 Trang)
                                            </span>
                                        </div>
                                        <div class="col-lg-3 col-md-2 col-sm-6  mt--10 mt-md--0">
                                            <div class="sorting-selection">
                                                <!--                                                <span>Hiển thị:</span>
                                                                                                <select class="form-control nice-select sort-select">
                                                                                                    <option value="" selected="selected">3</option>
                                                                                                    <option value="">9</option>
                                                                                                    <option value="">5</option>
                                                                                                    <option value="">10</option>
                                                                                                    <option value="">12</option>
                                                                                                </select>-->
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-6 mt--10 mt-md--0 ">
                                            <div class="sorting-selection">
                                                <span>Lọc theo:</span>
                                                <select class="form-control nice-select sort-select mr-0">
                                                    <option value="" selected="selected">Sắp xếp mặc định</option>
                                                    <option value="">Sắp xếp theo: Tên (A → Z)</option>
                                                    <option value="">Sắp xếp theo: Tên (Z → A)</option>
                                                    <option value="">Sắp xếp theo: Giá (Thấp → Cao)</option>
                                                    <option value="">Sắp xếp theo: Giá (Cao → Thấp)</option>
                                                    <option value="">Sắp xếp theo: Xếp hạng (Cao nhất)</option>
                                                    <option value="">Sắp xếp theo: Xếp hạng (Thấp nhất)</option>
                                                    <option value="">Sắp xếp theo: Mẫu (A → Z)</option>
                                                    <option value="">Sắp xếp theo: Mẫu (Z → A) </option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="shop-toolbar d-none">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-2 col-sm-6">
                                            <!-- Product View Mode -->
                                            <div class="product-view-mode">
                                                <a href="#" class="sorting-btn active" data-target="grid"><i
                                                        class="fas fa-th"></i></a>
                                                <a href="#" class="sorting-btn" data-target="grid-four">
                                                    <span class="grid-four-icon">
                                                        <i class="fas fa-grip-vertical"></i><i class="fas fa-grip-vertical"></i>
                                                    </span>
                                                </a>
                                                <a href="#" class="sorting-btn" data-target="list "><i
                                                        class="fas fa-list"></i></a>
                                            </div>
                                        </div>
                                        <div class="col-xl-5 col-md-4 col-sm-6  mt--10 mt-sm--0">
                                            <span class="toolbar-status">
                                                Showing 1 to 9 of 14 (2 Pages)
                                            </span>
                                        </div>
                                        <!--                                        <div class="col-lg-2 col-md-2 col-sm-6  mt--10 mt-md--0">
                                                                                    <div class="sorting-selection">
                                                                                        <span>Show:</span>
                                                                                        <select class="form-control nice-select sort-select">
                                                                                            <option value="" selected="selected">3</option>
                                                                                            <option value="">9</option>
                                                                                            <option value="">5</option>
                                                                                            <option value="">10</option>
                                                                                            <option value="">12</option>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>-->
                                        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-6 mt--10 mt-md--0 ">
                                            <div class="sorting-selection">
                                                <span>Lọc theo:</span>
                                                <select class="form-control nice-select sort-select mr-0">
                                                    <option value="" selected="selected">Sắp xếp mặc định</option>
                                                    <option value="">Sắp xếp theo: Tên (A → Z)</option>
                                                    <option value="">Sắp xếp theo: Tên (Z → A)</option>
                                                    <option value="">Sắp xếp theo: Giá (Thấp → Cao)</option>
                                                    <option value="">Sắp xếp theo: Giá (Cao → Thấp)</option>
                                                    <option value="">Sắp xếp theo: Xếp hạng (Cao nhất)</option>
                                                    <option value="">Sắp xếp theo: Xếp hạng (Thấp nhất)</option>
                                                    <option value="">Sắp xếp theo: Mẫu (A → Z)</option>
                                                    <option value="">Sắp xếp theo: Mẫu (Z → A)</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="shop-product-wrap grid with-pagination row space-db--30 shop-border">
                                <c:forEach var="book" items="${bookList}">
                                    <div class="col-lg-4 col-sm-6">
                                        <div class="product-card">
                                            <div class="product-grid-content">
                                                <div class="product-header">
                                                    <a href="#" class="author">
                                                        ${book.authorName}
                                                    </a>
                                                    <h3><a href="home?state=detail&bookId=${book.BId}">${book.BTitle}</a></h3>
                                                </div>
                                                <div class="product-card--body">
                                                    <div class="card-image">

                                                        <img src="${pageContext.request.contextPath}/customer/image/products/product-1.jpg" alt="">
                                                        <div class="hover-contents">
                                                            <a href="home?state=detail&bookId=${book.BId}" class="hover-image">
                                                                <img src="${pageContext.request.contextPath}/customer/image/products/product-2.jpg" alt="">
                                                            </a>
                                                            <div class="hover-btns">
                                                                <a href="home?state=cart&action=add&bookId=${book.BId}&page=${currentPage}" class="single-btn">
                                                                    <i class="fas fa-shopping-basket"></i>
                                                                </a>
                                                                <a href="wishlist?action=add&bookId=${book.BId}&page=${currentPage}" class="single-btn">
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
                                                        <span class="price"><fmt:formatNumber value="${book.price}" pattern="#,##0"/> VND</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>  

                            </div>
                            <!-- Pagination Block -->
                            <div class="row pt--30">
                                <div class="col-md-12">
                                    <div class="pagination-block">
                                        <ul class="pagination-btns flex-center">

                                            <c:choose>
                                                <c:when test="${not empty searchQuery}">

                                                    <c:url var="pageUrlBase" value="search">
                                                        <c:param name="searchQuery" value="${searchQuery}" />
                                                    </c:url>
                                                </c:when>
                                                <c:otherwise>

                                                    <c:url var="pageUrlBase" value="home" />
                                                </c:otherwise>
                                            </c:choose>


                                            <c:if test="${currentPage > 1}">
                                                <li>
                                                    <c:url var="prevUrl" value="${pageUrlBase}">
                                                        <c:param name="page" value="${currentPage - 1}" />
                                                    </c:url>
                                                    <a href="${prevUrl}" class="single-btn prev-btn"><i class="zmdi zmdi-chevron-left"></i></a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="${i == currentPage ? 'active' : ''}">
                                                    <c:url var="pageUrl" value="${pageUrlBase}">
                                                        <c:param name="page" value="${i}" />
                                                    </c:url>
                                                    <a href="${pageUrl}" class="single-btn">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <%-- Next Button --%>
                                            <c:if test="${currentPage < totalPages}">
                                                <li>
                                                    <%-- Construct next page URL --%>
                                                    <c:url var="nextUrl" value="${pageUrlBase}">
                                                        <c:param name="page" value="${currentPage + 1}" />
                                                    </c:url>
                                                    <a href="${nextUrl}" class="single-btn next-btn"><i class="zmdi zmdi-chevron-right"></i></a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
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
                                                                <span class="widget-label">Số lượng</span>
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
                        </div>
                        <div class="col-lg-3  mt--40 mt-lg--0">
                            <div class="inner-page-sidebar">
                                <!-- Accordion -->
                                <div class="single-block">
                                    <h3 class="sidebar-title">Thể loại</h3>
                                    <ul class="sidebar-menu--shop">
                                        <c:forEach var="cat" items="${categoryList}">
                                            <li><a href="#">${cat.cateName}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                                <!-- Price -->
                                <div class="single-block">
                                    <h3 class="sidebar-title">Lọc theo giá</h3>
                                    <div class="range-slider pt--30">
                                        <div class="sb-range-slider"></div>
                                        <div class="slider-price">
                                            <p>
                                                <input type="text" id="amount" readonly="">
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <!-- Size -->
                                <div class="single-block">
                                    <h3 class="sidebar-title">Tác giả</h3>
                                    <ul class="sidebar-menu--shop menu-type-2">

                                        <c:forEach var="author" items="${authorList}">
                                            <li><a href="#">${author.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                                <!-- Color -->
                                <div class="single-block">
                                    <h3 class="sidebar-title">Nhà xuất bản</h3>
                                    <ul class="sidebar-menu--shop menu-type-2">

                                        <c:forEach var="pub" items="${publisherList}">
                                            <li><a href="#">${pub.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                                <!-- Promotion Block -->
                                <div class="single-block">
                                    <a href="#" class="promo-image sidebar">
                                        <img src="image/others/home-side-promo.jpg" alt="">
                                    </a>
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
    </body>
</html>
