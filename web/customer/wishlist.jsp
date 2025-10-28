<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pustok - Danh sách yêu thích</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
                                    <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Danh sách yêu thích</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>
                <div class="cart_area inner-page-sec-padding-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <form action="#"> <%-- Form may not be needed --%>
                                <div class="cart-table table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th class="pro-thumbnail">Ảnh</th>
                                                <th class="pro-title">Sản phẩm</th>
                                                <th class="pro-price">Giá</th>
                                                <th class="pro-stock">Trạng thái kho</th>
                                                <th class="pro-addtocart">Thêm vào giỏ</th>
                                                <th class="pro-remove">Xóa</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty wishlistItems}">
                                                    <c:forEach var="book" items="${wishlistItems}">
                                                        <tr>
                                                            <td class="pro-thumbnail">
                                                                <a href="home?state=detail&bookId=${book.BId}">
                                                                    <%-- Replace with dynamic image path if available --%>
                                                                    <img src="${pageContext.request.contextPath}/customer/image/products/product-1.jpg" alt="${book.BTitle}" style="max-width: 80px;">
                                                                </a>
                                                            </td>
                                                            <td class="pro-title">
                                                                <a href="home?state=detail&bookId=${book.BId}">${book.BTitle}</a>
                                                                <br><small>Tác giả: ${book.authorName}</small>
                                                            </td>
                                                            <td class="pro-price">
                                                                <span><fmt:formatNumber value="${book.price}" pattern="#,##0"/> VND</span>
                                                            </td>
                                                            <td class="pro-stock">
                                                                <%-- Display stock status --%>
                                                                <c:choose>
                                                                    <c:when test="${book.stock > 0}">
                                                                        <span class="text-success">Còn hàng</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-danger">Hết hàng</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="pro-addtocart">
                                                                <%-- Only show Add to Cart if in stock --%>
                                                                <c:if test="${book.stock > 0}">
                                                                    <a href="home?state=cart&action=add&bookId=${book.BId}" class="btn btn--primary btn-sm">Thêm vào giỏ</a>
                                                                </c:if>
                                                            </td>
                                                            <td class="pro-remove">
                                                                <%-- Use wishlistItemId for removal --%>
                                                                <a href="wishlist?action=remove&itemId=${book.wishlistItemId}" title="Xóa khỏi danh sách yêu thích">
                                                                    <i class="far fa-trash-alt"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center py-5">Danh sách yêu thích của bạn đang trống.</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="./common/brand_slider.jsp"></jsp:include>
        <jsp:include page="./common/footer.jsp"></jsp:include>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/ajax-mail.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
    </body>
</html>