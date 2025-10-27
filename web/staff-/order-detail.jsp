<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Chi tiết đơn hàng - Staff Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            .dashboard-card {
                background: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }
            .dashboard-nav {
                background: #f8f9fa;
                padding: 15px 0;
                margin-bottom: 30px;
            }
            .dashboard-nav a {
                color: #333;
                text-decoration: none;
                padding: 10px 20px;
                margin: 0 5px;
                border-radius: 5px;
                transition: all 0.3s;
            }
            .dashboard-nav a:hover, .dashboard-nav a.active {
                background: #007bff;
                color: white;
            }
            .order-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .order-details {
                background: #fff;
                border: 1px solid #dee2e6;
                border-radius: 10px;
                overflow: hidden;
            }
            .order-details th {
                background: #f8f9fa;
                font-weight: 600;
            }
            .badge {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 500;
            }
            .badge-warning { background: #ffc107; color: #212529; }
            .badge-info { background: #17a2b8; color: white; }
            .badge-success { background: #28a745; color: white; }
            .badge-danger { background: #dc3545; color: white; }
            .badge-secondary { background: #6c757d; color: white; }
            .btn-group .btn {
                margin-right: 5px;
            }
            .btn-group .btn:last-child {
                margin-right: 0;
            }
        </style>
    </head>
    <body>
        <div class="site-wrapper" id="top">
            <!-- Header -->
            <div class="site-header header-2 mb--20 d-none d-lg-block">
                <div class="header-middle pt--10 pb--10">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-3">
                                <a href="home" class="site-brand">
                                    <img src="${pageContext.request.contextPath}/customer/image/logo.png" alt="">
                                </a>
                            </div>
                            <div class="col-lg-6">
                                <h3 class="text-center">Chi tiết đơn hàng</h3>
                            </div>
                            <div class="col-lg-3">
                                <div class="header-links">
                                    <ul class="nav align-items-center">
                                        <li class="item">
                                            <div class="dropdown">
                                                <a href="#" class="dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                    Hello, ${sessionScope.account.l_name} ${sessionScope.account.f_name}
                                                </a>
                                                <ul class="dropdown-menu" aria-labelledby="userDropdown">
                                                    <li><a class="dropdown-item" href="profile">Hồ sơ cá nhân</a></li>
                                                    <li><a class="dropdown-item" href="my-account">Tài khoản của tôi</a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li><a class="dropdown-item" href="home">Về trang chủ</a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Dashboard Navigation -->
            <div class="dashboard-nav">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <nav class="text-center">
                                <a href="staff-dashboard">Tổng quan</a>
                                <a href="staff-dashboard?action=users">Quản lý người dùng</a>
                                <a href="staff-dashboard?action=books">Quản lý sách</a>
                                <a href="staff-dashboard?action=authors">Quản lý tác giả</a>
                                <a href="staff-dashboard?action=categories">Quản lý danh mục</a>
                                <a href="staff-dashboard?action=orders" class="active">Quản lý đơn hàng</a>
                                <a href="staff-dashboard?action=refunds">Quản lý hoàn tiền</a>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <main class="inner-page-sec-padding-bottom">
                <div class="container">
                    <!-- Success/Error Messages -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Order Information -->
                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Thông tin đơn hàng #${order.id}</h4>
                            <div class="btn-group">
                                <a href="staff-dashboard?action=orders" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>

                        <div class="order-info">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6><strong>Thông tin khách hàng:</strong></h6>
                                    <p><strong>Tên:</strong> ${order.customerName}</p>
                                    <p><strong>Email:</strong> ${order.customerEmail}</p>
                                    <p><strong>ID khách hàng:</strong> ${order.u_id}</p>
                                </div>
                                <div class="col-md-6">
                                    <h6><strong>Thông tin đơn hàng:</strong></h6>
                                    <p><strong>Ngày tạo:</strong> <fmt:formatDate value="${order.create_date}" pattern="dd/MM/yyyy HH:mm"/></p>
                                    <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.total_amount}" type="currency" currencySymbol="VND"/></p>
                                    <p><strong>Trạng thái hiện tại:</strong> 
                                        <c:choose>
                                            <c:when test="${order.status_id == 1}">
                                                <span class="badge badge-warning">Đang chờ xử lý</span>
                                            </c:when>
                                            <c:when test="${order.status_id == 2}">
                                                <span class="badge badge-info">Đã xác nhận</span>
                                            </c:when>
                                            <c:when test="${order.status_id == 3}">
                                                <span class="badge badge-info">Đang giao hàng</span>
                                            </c:when>
                                            <c:when test="${order.status_id == 4}">
                                                <span class="badge badge-success">Đã giao hàng</span>
                                            </c:when>
                                            <c:when test="${order.status_id == 5}">
                                                <span class="badge badge-danger">Đã hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-secondary">${order.statusName}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Update Status -->
                        <div class="mt-4">
                            <h6><strong>Cập nhật trạng thái:</strong></h6>
                            <form method="post" action="staff-dashboard" class="d-flex align-items-center">
                                <input type="hidden" name="action" value="updateOrderStatus">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <select name="statusId" class="form-select me-3" style="width: auto;">
                                    <c:forEach var="status" items="${statuses}">
                                        <option value="${status[0]}" ${order.status_id == status[0] ? 'selected' : ''}>
                                            ${status[1]}
                                        </option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Cập nhật trạng thái
                                </button>
                            </form>
                        </div>

                        <!-- Refund Actions -->
                        <div class="mt-4">
                            <h6><strong>Hoàn tiền:</strong></h6>
                            <div class="btn-group">
                                <a href="staff-dashboard?action=createRefund&orderId=${order.id}" 
                                   class="btn btn-warning">
                                    <i class="fas fa-undo"></i> Tạo yêu cầu hoàn tiền
                                </a>
                                <a href="staff-dashboard?action=refunds" 
                                   class="btn btn-info">
                                    <i class="fas fa-list"></i> Xem danh sách hoàn tiền
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Order Details -->
                    <div class="dashboard-card">
                        <h5 class="mb-4">Chi tiết sản phẩm</h5>
                        <div class="table-responsive">
                            <table class="table table-striped order-details">
                                <thead>
                                    <tr>
                                        <th>ID Sách</th>
                                        <th>Tên sách</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="detail" items="${orderDetails}">
                                        <tr>
                                            <td>${detail[0]}</td>
                                            <td>${detail[1]}</td>
                                            <td>${detail[2]}</td>
                                            <td><fmt:formatNumber value="${detail[3]}" type="currency" currencySymbol="VND"/></td>
                                            <td><fmt:formatNumber value="${detail[4]}" type="currency" currencySymbol="VND"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr class="table-info">
                                        <th colspan="4" class="text-end">Tổng cộng:</th>
                                        <th><fmt:formatNumber value="${order.total_amount}" type="currency" currencySymbol="VND"/></th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/main.js"></script>
    </body>
</html>
