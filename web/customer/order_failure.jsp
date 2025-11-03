<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pustok - Thanh toán thất bại</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
        <style>
            .order-failure-message {
                padding: 60px 0;
                text-align: center;
            }
            .order-failure-message h1 {
                color: #dc3545;
                font-size: 48px;
                font-weight: 700;
                margin-bottom: 20px;
            }
            .order-failure-message .failure-icon {
                font-size: 80px;
                color: #dc3545;
                margin-bottom: 30px;
            }
            .order-failure-message p {
                font-size: 18px;
                color: #666;
                margin-bottom: 30px;
                line-height: 1.6;
            }
            .failure-info-box {
                background: #fff3cd;
                border: 1px solid #ffc107;
                border-radius: 8px;
                padding: 30px;
                margin: 40px auto;
                max-width: 600px;
            }
            .failure-info-box h3 {
                color: #856404;
                font-size: 24px;
                margin-bottom: 20px;
                font-weight: 600;
            }
            .failure-info-box ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .failure-info-box ul li {
                padding: 10px 0;
                border-bottom: 1px solid #ffeaa7;
                font-size: 16px;
                color: #333;
            }
            .failure-info-box ul li:last-child {
                border-bottom: none;
            }
            .failure-info-box ul li strong {
                color: #856404;
                font-weight: 600;
            }
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
            .failure-reasons {
                background: #f8f9fa;
                border-radius: 8px;
                padding: 30px;
                margin: 40px auto;
                max-width: 700px;
            }
            .failure-reasons h4 {
                color: #333;
                font-size: 20px;
                margin-bottom: 20px;
                font-weight: 600;
            }
            .failure-reasons ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .failure-reasons ul li {
                padding: 10px 0 10px 30px;
                position: relative;
                color: #666;
                font-size: 15px;
                line-height: 1.6;
            }
            .failure-reasons ul li:before {
                content: "•";
                position: absolute;
                left: 10px;
                color: #dc3545;
                font-size: 20px;
                font-weight: bold;
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
                                    <li class="breadcrumb-item active">Thanh toán thất bại</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>

                <section class="order-complete inner-page-sec-padding-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <div class="order-failure-message">
                                    <div class="failure-icon">
                                        <i class="fas fa-times-circle"></i>
                                    </div>
                                    <h1>Thanh toán thất bại</h1>
                                    <p>Rất tiếc, giao dịch thanh toán của bạn không thành công.</p>
                                    <p>Vui lòng kiểm tra lại thông tin thanh toán hoặc thử lại sau.</p>
                                </div>

                                <div class="failure-info-box">
                                    <h3>Thông tin giao dịch</h3>
                                    <ul>
                                        <c:if test="${not empty orderInfo}">
                                            <li>Mã đơn hàng: <strong>#${orderInfo.id}</strong></li>
                                            <li>Ngày đặt: <strong><fmt:formatDate value="${orderInfo.createDate}" pattern="HH:mm 'ngày' dd/MM/yyyy" /></strong></li>
                                            <li>Tổng tiền: <strong><fmt:formatNumber value="${orderInfo.totalAmount}" pattern="#,##0" /> VND</strong></li>
                                        </c:if>
                                        <c:if test="${not empty responseCode}">
                                            <li>Mã lỗi: <strong>${responseCode}</strong></li>
                                        </c:if>
                                        <li>Trạng thái: <strong style="color: #dc3545;">Thanh toán thất bại</strong></li>
                                    </ul>
                                </div>

                                <div class="failure-reasons">
                                    <h4>Nguyên nhân có thể gây ra lỗi:</h4>
                                    <ul>
                                        <li>Số dư tài khoản không đủ</li>
                                        <li>Thông tin thẻ/ tài khoản không chính xác</li>
                                        <li>Thẻ đã bị khóa hoặc hết hạn</li>
                                        <li>Giao dịch vượt quá giới hạn cho phép</li>
                                        <li>Lỗi kết nối mạng hoặc hệ thống</li>
                                    </ul>
                                </div>

                                <div class="action-buttons">
                                    <a href="checkout" class="btn btn-primary">
                                        <i class="fas fa-redo"></i> Thử lại thanh toán
                                    </a>
                                    <a href="cart" class="btn btn-secondary">
                                        <i class="fas fa-shopping-cart"></i> Quay lại giỏ hàng
                                    </a>
                                    <a href="home" class="btn btn-secondary">
                                        <i class="fas fa-home"></i> Về trang chủ
                                    </a>
                                </div>

                                <c:if test="${not empty message}">
                                    <div style="text-align: center; margin-top: 30px; padding: 20px; background: #fff3cd; border-radius: 5px; max-width: 600px; margin-left: auto; margin-right: auto;">
                                        <p style="color: #856404; margin: 0; font-size: 16px;">
                                            <i class="fas fa-info-circle"></i> ${message}
                                        </p>
                                    </div>
                                </c:if>
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

