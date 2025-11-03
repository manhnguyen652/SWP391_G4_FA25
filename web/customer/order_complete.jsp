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
        <style>
            .action-buttons {
                margin-top: 40px;
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }
            .action-buttons .btn {
                padding: 15px 40px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
            }
            .action-buttons .btn-primary {
                background-color: #62ab00;
                color: #fff;
                border: none;
            }
            .action-buttons .btn-primary:hover {
                background-color: #4d8a00;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(98, 171, 0, 0.3);
            }
            .action-buttons .btn-info {
                background-color: #17a2b8;
                color: #fff;
                border: none;
            }
            .action-buttons .btn-info:hover {
                background-color: #138496;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(23, 162, 184, 0.3);
            }
            .action-buttons .btn-secondary {
                background-color: #6c757d;
                color: #fff;
                border: none;
            }
            .action-buttons .btn-secondary:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
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
                            
                            <div class="action-buttons">
                                <a href="my-account/orders" class="btn btn-primary">
                                    <i class="fas fa-list-alt"></i> Xem đơn mua của tôi
                                </a>
                                <a href="home" class="btn btn-secondary">
                                    <i class="fas fa-home"></i> Về trang chủ
                                </a>
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