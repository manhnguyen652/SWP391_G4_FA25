<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pustok - Đặt hàng thành công</title>
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
                                    <li class="breadcrumb-item active">Đặt hàng thành công</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>

                <section class="order-complete inner-page-sec-padding-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="order-complete-message text-center">
                                    <h1>Cảm ơn bạn!</h1>
                                    <p>Đơn hàng của bạn đã được tiếp nhận.</p>
                                </div>
                                <ul class="order-details-list">
                                    <li>Mã đơn hàng: <strong>${orderInfo.id}</strong></li>
                                <li>Ngày đặt: <strong><fmt:formatDate value="${orderInfo.createDate}" pattern="HH:mm 'ngày' dd/MM/yyyy" /></strong></li>
                                <li>Tổng cộng: <strong><fmt:formatNumber value="${orderInfo.totalAmount}" pattern="#,##0" /> VND</strong></li>
                                <li>Phương thức thanh toán: <strong>Thanh toán VNPAY</strong></li>
                            </ul>
                            <h3 class="order-table-title">Chi tiết đơn hàng</h3>
                            <div class="table-responsive">
                                <table class="table order-details-table">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Tổng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:set var="subtotal" value="0" />
                                    <c:forEach var="item" items="${orderItems}">
                                        <tr>
                                            <td><a href="#">${item.productName}</a> <strong>× ${item.quantity}</strong></td>
                                            <td><span><fmt:formatNumber value="${item.totalItemPrice}" pattern="#,##0" /> VND</span></td>
                                        </tr>
                                        <c:set var="subtotal" value="${subtotal + item.totalItemPrice}" />
                                    </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th>Tạm tính:</th>
                                            <td><span><fmt:formatNumber value="${subtotal}" pattern="#,##0" /> VND</span></td>
                                        </tr>
                                        <tr>
                                            <th>Phí vận chuyển:</th>
                                            <td><span>0 VND</span></td> <%-- Cập nhật nếu có --%>
                                        </tr>
                                        <tr>
                                            <th>Phương thức thanh toán:</th>
                                            <td>Thanh toán VNPAY</td>
                                        </tr>
                                        <tr>
                                            <th>Tổng cộng:</th>
                                            <td><span><fmt:formatNumber value="${orderInfo.totalAmount}" pattern="#,##0" /> VND</span></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <jsp:include page="./common/brand_slider.jsp"></jsp:include>
        <jsp:include page="./common/footer.jsp"></jsp:include>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/ajax-mail.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
    </body>
</html>