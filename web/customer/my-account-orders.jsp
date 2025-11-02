<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">

    <style>
        .status-tabs {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-bottom: 25px;
            gap: 8px;
        }
        .status-tabs a {
            padding: 8px 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            color: #333;
            background: #fff;
            transition: 0.3s;
        }
        .status-tabs a:hover {
            background: #f0f0f0;
        }
        .status-tabs a.active {
            background-color: #7fad39;
            color: white;
            border-color: #7fad39;
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>

<body>
    <div class="site-wrapper" id="top">
        <!-- Header -->
        <jsp:include page="./common/header.jsp" />

        <section class="breadcrumb-section">
            <div class="container">
                <div class="breadcrumb-contents">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Tài khoản của tôi</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </section>

        <!-- Account section -->
        <main class="account-page-section section-padding">
            <div class="container">
                <div class="row">
                    <!-- Sidebar -->
                    <div class="col-lg-3 col-md-4">
                        <div class="myaccount-tab-menu nav" role="tablist">
                            <a href="${pageContext.request.contextPath}/my-account?section=dashboard"><i class="fa fa-dashboard"></i> Dashboard</a>
                            <a href="${pageContext.request.contextPath}/my-account/orders" class="active"><i class="fa fa-cart-arrow-down"></i> Orders</a>
                            <a href="${pageContext.request.contextPath}/my-account?section=address"><i class="fa fa-map-marker"></i> Address</a>
                            <a href="${pageContext.request.contextPath}/customer/account_details.jsp"><i class="fa fa-user"></i> Account Details</a>
                            <a href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out"></i> Logout</a>
                        </div>
                    </div>

                    <!-- Content -->
                    <div class="col-lg-9 col-md-8">
                        <div class="myaccount-content">
                            <h3 class="title">Orders</h3>

                            <!-- Tabs lọc trạng thái -->
                            <div class="status-tabs">
                                <a href="${pageContext.request.contextPath}/my-account/orders" 
                                   class="${empty currentStatus ? 'active' : ''}">Tất cả</a>

                                <a href="${pageContext.request.contextPath}/my-account/orders?status=1" 
                                   class="${currentStatus == '1' ? 'active' : ''}">Đang chờ xử lý</a>

                                <a href="${pageContext.request.contextPath}/my-account/orders?status=2" 
                                   class="${currentStatus == '2' ? 'active' : ''}">Đã xác nhận</a>

                                <a href="${pageContext.request.contextPath}/my-account/orders?status=3" 
                                   class="${currentStatus == '3' ? 'active' : ''}">Đang giao hàng</a>

                                <a href="${pageContext.request.contextPath}/my-account/orders?status=4" 
                                   class="${currentStatus == '4' ? 'active' : ''}">Đã giao hàng</a>

                                <a href="${pageContext.request.contextPath}/my-account/orders?status=5" 
                                   class="${currentStatus == '5' ? 'active' : ''}">Đã hủy</a>
                            </div>

                            <div class="myaccount-table table-responsive text-center">
                                <table class="table table-bordered">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>No</th>
                                            <th>Tên người nhận</th>
                                            <th>Ngày đặt</th>
                                            <th>Trạng thái</th>
                                            <th>Tổng tiền</th>
                                            <th>Chi tiết</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty orders}">
                                                <tr>
                                                    <td colspan="6">Hiện bạn chưa có đơn hàng nào.</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="order" items="${orders}" varStatus="loop">
                                                    <tr>
                                                        <td>${loop.index + 1}</td>
                                                        <td>${order.ship_lname} ${order.ship_fname}</td>
                                                        <td><fmt:formatDate value="${order.createDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                        <td>${order.statusName}</td>
                                                        <td><fmt:formatNumber value="${order.totalAmount}" type="number"/> VND</td>
                                                        <td><a href="${pageContext.request.contextPath}/my-account-order-detail?id=${order.id}" class="btn btn__bg">VIEW</a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <jsp:include page="./common/footer.jsp" />
    </div>
</body>
</html>
