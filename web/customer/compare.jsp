<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pustok - So sánh sản phẩm</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
        <style>
            .compare-table td.empty-slot {
                background-color: #f8f8f8;
                text-align: center;
                vertical-align: middle;
                color: #aaa;
                height: 150px;
            }
            .pro-addtocart .btn-disabled {
                cursor: not-allowed;
                opacity: 0.6;
            }
        </style>
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
                                    <li class="breadcrumb-item active">So Sánh</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>
                <main class="compare_area inner-page-sec-padding-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                            <c:if test="${param.remove == 'success'}">
                                <div class="alert alert-success">Sản phẩm đã được xóa khỏi danh sách so sánh.</div>
                            </c:if>
                            <c:if test="${param.error == 'invalid_remove' || param.error == 'remove_failed'}">
                                <div class="alert alert-danger">Lỗi khi xóa sản phẩm khỏi danh sách so sánh.</div>
                            </c:if>

                            <form action="#">
                                <div class="compare-table table-responsive">
                                    <c:choose>
                                        <c:when test="${not empty compareItems}">
                                            <table class="table mb-0">
                                                <tbody>
                                                    <tr>
                                                        <td class="first-column fw-bold">Sản phẩm</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td class="product-image-title">
                                                                <a href="home?state=detail&bookId=${book.BId}" class="image d-block mb-2">
                                                                    <img src="${pageContext.request.contextPath}/customer/image/products/product-${book.BId % 5 + 1}.jpg" alt="Compare ${book.BTitle}" style="max-width: 120px; height: auto; margin: 0 auto;">
                                                                </a>
                                                                <a href="home?state=detail&bookId=${book.BId}" class="title d-block mb-1">${book.BTitle}</a>
                                                                <small class="text-muted d-block">Tác giả: ${book.authorName}</small>
                                                            </td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}">
                                                                <td class="product-image-title empty-slot"><span>(Trống)</span></td>
                                                            </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                    <tr>
                                                        <td class="first-column fw-bold">Mô tả</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td class="pro-desc">
                                                                <p>
                                                                    <c:choose>
                                                                        <c:when test="${not empty book.description}">
                                                                            ${book.description}
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="text-muted">Chưa có mô tả.</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </p>
                                                            </td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}"> <td class="pro-desc empty-slot"></td> </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                    <tr>
                                                        <td class="first-column fw-bold">Giá</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td class="pro-price"><fmt:formatNumber value="${book.price}" pattern="#,##0"/> VND</td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}"> <td class="pro-price empty-slot"></td> </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                    <tr>
                                                        <td class="first-column fw-bold">Tồn kho</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td class="pro-stock">
                                                                <c:choose>
                                                                    <c:when test="${book.stock > 0}"><span class="text-success">Còn hàng</span></c:when>
                                                                    <c:otherwise><span class="text-danger">Hết hàng</span></c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}"> <td class="pro-stock empty-slot"></td> </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                    <tr>
                                                        <td class="first-column fw-bold">Thêm vào giỏ</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td class="pro-addtocart">
                                                                <c:choose>
                                                                    <c:when test="${book.stock > 0}">
                                                                        <a href="home?state=cart&action=add&bookId=${book.BId}" class="btn btn--primary btn-sm" tabindex="0">
                                                                            <i class="fas fa-shopping-cart"></i>&nbsp;Thêm
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <button class="btn btn-sm btn-secondary btn-disabled" disabled>Hết hàng</button>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}"> <td class="pro-addtocart empty-slot"></td> </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                    <tr>
                                                        <td class="first-column fw-bold">Xóa</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td class="pro-remove">
                                                                <a href="compare?action=remove&itemId=${book.compareItemId}" title="Xóa khỏi so sánh" class="btn btn-outlined btn-sm">
                                                                    <i class="fas fa-trash"></i>
                                                                </a>
                                                            </td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}"> <td class="pro-remove empty-slot"></td> </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                    <tr>
                                                        <td class="first-column fw-bold">Tác giả</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td>${book.authorName}</td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}"> <td class="empty-slot"></td> </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                    <tr>
                                                        <td class="first-column fw-bold">Năm XB</td>
                                                        <c:forEach var="book" items="${compareItems}">
                                                            <td>${book.publicationYear}</td>
                                                        </c:forEach>
                                                        <c:if test="${compareItems.size() < MAX_COMPARE_ITEMS}">
                                                            <c:forEach begin="${compareItems.size()}" end="${MAX_COMPARE_ITEMS - 1}"> <td class="empty-slot"></td> </c:forEach>
                                                        </c:if>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info text-center my-5">
                                                Chưa có sản phẩm nào trong danh sách so sánh.
                                                <br>
                                                Bạn có thể thêm tối đa ${MAX_COMPARE_ITEMS} sản phẩm từ trang sản phẩm hoặc trang chi tiết.
                                                <br><br>
                                                <a href="home" class="btn btn--primary">Quay lại trang chủ</a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
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