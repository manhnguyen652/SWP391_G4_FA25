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
                                                <select id="sortOrder" name="sortOrder" class="form-control nice-select sort-select mr-0">
                                                    <option value="default" ${selectedSortOrder == null || selectedSortOrder == 'default' ? 'selected' : ''}>Sắp xếp mặc định</option>
                                                    <option value="name_asc" ${selectedSortOrder == 'name_asc' ? 'selected' : ''}>Sắp xếp theo: Tên (A → Z)</option>
                                                    <option value="name_desc" ${selectedSortOrder == 'name_desc' ? 'selected' : ''}>Sắp xếp theo: Tên (Z → A)</option>
                                                    <option value="price_asc" ${selectedSortOrder == 'price_asc' ? 'selected' : ''}>Sắp xếp theo: Giá (Thấp → Cao)</option>
                                                    <option value="price_desc" ${selectedSortOrder == 'price_desc' ? 'selected' : ''}>Sắp xếp theo: Giá (Cao → Thấp)</option>
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
                                                                <a href="compare?action=add&bookId=${book.BId}" class="single-btn" title="Thêm vào so sánh"> <i class="fas fa-random"></i> </a>
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
                                                <c:when test="${not empty searchQuery || not empty selectedCategoryId || not empty selectedMinPrice || not empty selectedMaxPrice || not empty selectedAuthorId || not empty selectedPublisherId}">
                                                    <c:url var="pageUrlBase" value="search">
                                                        <c:if test="${not empty searchQuery}">
                                                            <c:param name="searchQuery" value="${searchQuery}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedCategoryId}">
                                                            <c:param name="categoryId" value="${selectedCategoryId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedMinPrice}">
                                                            <c:param name="minPrice" value="${selectedMinPrice}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedMaxPrice}">
                                                            <c:param name="maxPrice" value="${selectedMaxPrice}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedAuthorId}">
                                                            <c:param name="authorId" value="${selectedAuthorId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedPublisherId}">
                                                            <c:param name="publisherId" value="${selectedPublisherId}" />
                                                        </c:if>
                                                        <c:if test="${not empty selectedSortOrder}">
                                                            <c:param name="sortOrder" value="${selectedSortOrder}" />
                                                        </c:if>
                                                    </c:url>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url var="pageUrlBase" value="home">
                                                        <c:if test="${not empty selectedSortOrder}">
                                                            <c:param name="sortOrder" value="${selectedSortOrder}" />
                                                        </c:if>
                                                    </c:url>
                                                </c:otherwise>
                                            </c:choose>


                                            <c:if test="${currentPage > 1}">
                                                <li>
                                                    <c:url var="prevUrl" value="${pageUrlBase}">
                                                        <c:param name="page" value="${currentPage - 1}" />
                                                        <c:if test="${not empty selectedSortOrder && selectedSortOrder != 'default'}">
                                                            <c:param name="sortOrder" value="${selectedSortOrder}" />
                                                        </c:if>
                                                    </c:url>
                                                    <a href="${prevUrl}" class="single-btn prev-btn"><i class="zmdi zmdi-chevron-left"></i></a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="${i == currentPage ? 'active' : ''}">
                                                    <c:url var="pageUrl" value="${pageUrlBase}">
                                                        <c:param name="page" value="${i}" />
                                                        <c:if test="${not empty selectedSortOrder && selectedSortOrder != 'default'}">
                                                            <c:param name="sortOrder" value="${selectedSortOrder}" />
                                                        </c:if>
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
                                                        <c:if test="${not empty selectedSortOrder && selectedSortOrder != 'default'}">
                                                            <c:param name="sortOrder" value="${selectedSortOrder}" />
                                                        </c:if>
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
                                <!-- Filter Form -->
                                <form id="filterForm" method="GET" action="search">
                                    <!-- Hidden fields để giữ searchQuery và sortOrder nếu có -->
                                    <c:if test="${not empty searchQuery}">
                                        <input type="hidden" name="searchQuery" value="${searchQuery}">
                                    </c:if>
                                    <c:if test="${not empty selectedSortOrder}">
                                        <input type="hidden" id="sortOrderHidden" name="sortOrder" value="${selectedSortOrder}">
                                    </c:if>
                                    
                                    <!-- Accordion -->
                                    <div class="single-block">
                                        <h3 class="sidebar-title">Thể loại</h3>
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle w-100 text-left" type="button" id="categoryDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                <span id="categoryText">
                                                    <c:choose>
                                                        <c:when test="${not empty selectedCategoryId}">
                                                            <c:forEach var="cat" items="${categoryList}">
                                                                <c:if test="${cat.id == selectedCategoryId}">${cat.cateName}</c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>Tất cả thể loại</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </button>
                                            <ul class="dropdown-menu w-100" aria-labelledby="categoryDropdown">
                                                <li><a class="dropdown-item filter-dropdown-item" href="javascript:void(0);" data-filter="categoryId" data-value="">Tất cả thể loại</a></li>
                                                <c:forEach var="cat" items="${categoryList}">
                                                    <li><a class="dropdown-item filter-dropdown-item ${selectedCategoryId == cat.id ? 'active' : ''}" href="javascript:void(0);" data-filter="categoryId" data-value="${cat.id}" data-text="${cat.cateName}">${cat.cateName}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <input type="hidden" id="categoryId" name="categoryId" value="${selectedCategoryId}">
                                    </div>
                                    <!-- Price -->
                                    <div class="single-block">
                                        <h3 class="sidebar-title">Lọc theo giá</h3>
                                        <div class="price-inputs pt--30">
                                            <div class="form-group mb-3">
                                                <label for="minPriceInput" class="form-label">Giá tối thiểu (VND)</label>
                                                <input type="number" 
                                                       id="minPriceInput" 
                                                       class="form-control" 
                                                       placeholder="0" 
                                                       min="0" 
                                                       step="1000"
                                                       value="<c:choose><c:when test="${not empty selectedMinPrice}">${selectedMinPrice}</c:when><c:otherwise>0</c:otherwise></c:choose>">
                                            </div>
                                            <div class="form-group mb-3">
                                                <label for="maxPriceInput" class="form-label">Giá tối đa (VND)</label>
                                                <input type="number" 
                                                       id="maxPriceInput" 
                                                       class="form-control" 
                                                       placeholder="<c:choose><c:when test="${not empty priceRange && not empty priceRange.maxPrice}"><fmt:formatNumber value="${priceRange.maxPrice}" pattern="#,##0"/></c:when><c:otherwise>1000000</c:otherwise></c:choose>" 
                                                       min="0" 
                                                       step="1000"
                                                       value="<c:choose><c:when test="${not empty selectedMaxPrice}">${selectedMaxPrice}</c:when><c:when test="${not empty priceRange && not empty priceRange.maxPrice}">${priceRange.maxPrice}</c:when><c:otherwise>1000000</c:otherwise></c:choose>">
                                            </div>
                                            <button type="button" id="applyPriceFilter" class="btn btn-primary w-100">ÁP DỤNG</button>
                                        </div>
                                        <input type="hidden" id="minPrice" name="minPrice" value="${selectedMinPrice}">
                                        <input type="hidden" id="maxPrice" name="maxPrice" value="${selectedMaxPrice}">
                                    </div>
                                    <!-- Author -->
                                    <div class="single-block">
                                        <h3 class="sidebar-title">Tác giả</h3>
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle w-100 text-left" type="button" id="authorDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                <span id="authorText">
                                                    <c:choose>
                                                        <c:when test="${not empty selectedAuthorId}">
                                                            <c:forEach var="author" items="${authorList}">
                                                                <c:if test="${author.id == selectedAuthorId}">${author.name}</c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>Tất cả tác giả</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </button>
                                            <ul class="dropdown-menu w-100" aria-labelledby="authorDropdown">
                                                <li><a class="dropdown-item filter-dropdown-item" href="javascript:void(0);" data-filter="authorId" data-value="">Tất cả tác giả</a></li>
                                                <c:forEach var="author" items="${authorList}">
                                                    <li><a class="dropdown-item filter-dropdown-item ${selectedAuthorId == author.id ? 'active' : ''}" href="javascript:void(0);" data-filter="authorId" data-value="${author.id}" data-text="${author.name}">${author.name}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <input type="hidden" id="authorId" name="authorId" value="${selectedAuthorId}">
                                    </div>
                                    <!-- Publisher -->
                                    <div class="single-block">
                                        <h3 class="sidebar-title">Nhà xuất bản</h3>
                                        <div class="dropdown">
                                            <button class="btn btn-secondary dropdown-toggle w-100 text-left" type="button" id="publisherDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                <span id="publisherText">
                                                    <c:choose>
                                                        <c:when test="${not empty selectedPublisherId}">
                                                            <c:forEach var="pub" items="${publisherList}">
                                                                <c:if test="${pub.id == selectedPublisherId}">${pub.name}</c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>Tất cả nhà xuất bản</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </button>
                                            <ul class="dropdown-menu w-100" aria-labelledby="publisherDropdown">
                                                <li><a class="dropdown-item filter-dropdown-item" href="javascript:void(0);" data-filter="publisherId" data-value="">Tất cả nhà xuất bản</a></li>
                                                <c:forEach var="pub" items="${publisherList}">
                                                    <li><a class="dropdown-item filter-dropdown-item ${selectedPublisherId == pub.id ? 'active' : ''}" href="javascript:void(0);" data-filter="publisherId" data-value="${pub.id}" data-text="${pub.name}">${pub.name}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                        <input type="hidden" id="publisherId" name="publisherId" value="${selectedPublisherId}">
                                    </div>
                                </form>
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
        <script>
            jQuery(document).ready(function($) {
                // Xử lý input giá tối thiểu và tối đa
                $("#minPriceInput, #maxPriceInput").on('input', function() {
                    var minPrice = $("#minPriceInput").val() || '';
                    var maxPrice = $("#maxPriceInput").val() || '';
                    
                    // Cập nhật hidden fields
                    $("#minPrice").val(minPrice);
                    $("#maxPrice").val(maxPrice);
                });
                
                // Validation khi blur (rời khỏi input)
                $("#minPriceInput, #maxPriceInput").on('blur', function() {
                    var minPrice = parseInt($("#minPriceInput").val()) || 0;
                    var maxPrice = parseInt($("#maxPriceInput").val()) || 0;
                    
                    // Validation: đảm bảo giá tối thiểu <= giá tối đa (nếu cả hai đều có giá trị)
                    if (minPrice > 0 && maxPrice > 0 && minPrice > maxPrice) {
                        alert("Giá tối thiểu không được lớn hơn giá tối đa!");
                        if ($(this).attr('id') === 'minPriceInput') {
                            $("#minPriceInput").val(0);
                            $("#minPrice").val(0);
                        } else {
                            $("#maxPriceInput").val(minPrice);
                            $("#maxPrice").val(minPrice);
                        }
                    }
                });
                
                // Xử lý nút ÁP DỤNG cho price filter
                $("#applyPriceFilter").on('click', function() {
                    var minPrice = $("#minPriceInput").val() || '';
                    var maxPrice = $("#maxPriceInput").val() || '';
                    
                    // Cập nhật hidden fields trước khi submit
                    $("#minPrice").val(minPrice);
                    $("#maxPrice").val(maxPrice);
                    
                    // Validation trước khi submit
                    var minPriceInt = parseInt(minPrice) || 0;
                    var maxPriceInt = parseInt(maxPrice) || 0;
                    
                    if (maxPriceInt > 0 && minPriceInt > maxPriceInt) {
                        alert("Giá tối thiểu không được lớn hơn giá tối đa!");
                        return false;
                    }
                    
                    // Submit form để filter
                    $("#filterForm").submit();
                });
                
                // Xử lý click vào dropdown item (Thể loại, Tác giả, Nhà xuất bản)
                $(".filter-dropdown-item").on('click', function(e) {
                    e.preventDefault();
                    var $this = $(this);
                    var filterType = $this.data('filter');
                    var filterValue = $this.data('value');
                    var filterText = $this.data('text') || 'Tất cả ' + (filterType === 'categoryId' ? 'thể loại' : filterType === 'authorId' ? 'tác giả' : 'nhà xuất bản');
                    
                    // Cập nhật hidden field
                    $("#" + filterType).val(filterValue);
                    
                    // Cập nhật text trên button
                    var textSpanId = filterType.replace('Id', 'Text');
                    $("#" + textSpanId).text(filterText);
                    
                    // Remove active class từ tất cả items trong cùng dropdown
                    $this.closest('.dropdown-menu').find('.dropdown-item').removeClass('active');
                    // Add active class cho item được chọn
                    $this.addClass('active');
                    
                    // Submit form để filter
                    $("#filterForm").submit();
                });
                
                // Xử lý thay đổi sắp xếp (sortOrder)
                $("#sortOrder").on('change', function() {
                    var sortOrder = $(this).val();
                    var urlParams = new URLSearchParams(window.location.search);
                    
                    // Xác định base URL (search hoặc home)
                    var baseUrl = window.location.pathname;
                    if (baseUrl.includes('search')) {
                        baseUrl = 'search';
                    } else {
                        baseUrl = 'home';
                    }
                    
                    // Cập nhật hoặc thêm sortOrder parameter
                    if (sortOrder && sortOrder !== 'default') {
                        urlParams.set('sortOrder', sortOrder);
                    } else {
                        urlParams.delete('sortOrder');
                    }
                    
                    // Reset về page 1 khi thay đổi sort
                    urlParams.set('page', '1');
                    
                    // Redirect với parameters mới
                    window.location.href = baseUrl + '?' + urlParams.toString();
                });
            });
        </script>
        <style>
            .single-block .dropdown {
                margin-top: 10px;
            }
            .single-block .dropdown-toggle {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .single-block .dropdown-toggle::after {
                margin-left: auto;
            }
            .dropdown-item.active {
                background-color: #28a745;
                color: white;
            }
            .dropdown-item.active:hover {
                background-color: #218838;
                color: white;
            }
        </style>
    </body>
</html>
