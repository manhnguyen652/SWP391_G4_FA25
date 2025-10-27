<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Quản lý đơn hàng - Staff Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
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
            .table-responsive {
                overflow-x: auto;
            }
            .table th {
                background: #f8f9fa;
                border-top: none;
            }
            .badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
            }
            .badge-success { background: #28a745; color: white; }
            .badge-warning { background: #ffc107; color: #333; }
            .badge-danger { background: #dc3545; color: white; }
            .badge-info { background: #17a2b8; color: white; }
            .pagination {
                justify-content: center;
            }
            .stat-card {
                text-align: center;
                padding: 20px;
                border-radius: 10px;
                background: #fff;
                border: 1px solid #e9ecef;
                margin-bottom: 15px;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .stat-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                border-color: #007bff;
            }
            .stat-number {
                font-size: 2.2rem;
                font-weight: bold;
                margin-bottom: 8px;
                color: #333;
            }
            .stat-label {
                font-size: 0.9rem;
                color: #666;
                font-weight: 500;
            }
            .stat-card.primary .stat-number { color: #007bff; }
            .stat-card.success .stat-number { color: #28a745; }
            .stat-card.warning .stat-number { color: #ffc107; }
            .stat-card.info .stat-number { color: #17a2b8; }
            .stat-card.danger .stat-number { color: #dc3545; }
            .stat-card.secondary .stat-number { color: #6c757d; }
            .stat-card.light .stat-number { color: #f8f9fa; }
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
                                <h3 class="text-center">Quản lý đơn hàng</h3>
                            </div>
                            <div class="col-lg-3">
                                <div class="main-navigation flex-lg-right">
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
                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card primary">
                                <div class="stat-number">${totalOrders}</div>
                                <div class="stat-label">Tổng đơn hàng</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card info">
                                <div class="stat-number">${todayOrders}</div>
                                <div class="stat-label">Đơn hàng hôm nay</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card success">
                                <div class="stat-number"><fmt:formatNumber value="${todayRevenue}" type="currency" currencySymbol="VND"/></div>
                                <div class="stat-label">Doanh thu hôm nay</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card warning">
                                <div class="stat-number"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="VND"/></div>
                                <div class="stat-label">Tổng doanh thu</div>
                            </div>
                        </div>
                    </div>

                    <!-- Status Statistics -->
                    <div class="row mb-4">
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <div class="stat-card warning">
                                <div class="stat-number">${pendingOrders}</div>
                                <div class="stat-label">Chờ xử lý</div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <div class="stat-card info">
                                <div class="stat-number">${confirmedOrders}</div>
                                <div class="stat-label">Đã xác nhận</div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <div class="stat-card primary">
                                <div class="stat-number">${shippingOrders}</div>
                                <div class="stat-label">Đang giao</div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <div class="stat-card success">
                                <div class="stat-number">${completedOrders}</div>
                                <div class="stat-label">Hoàn thành</div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <div class="stat-card danger">
                                <div class="stat-number">${cancelledOrders}</div>
                                <div class="stat-label">Đã hủy</div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4 col-sm-6">
                            <div class="stat-card secondary">
                                <div class="stat-number">${totalOrders - pendingOrders - confirmedOrders - shippingOrders - completedOrders - cancelledOrders}</div>
                                <div class="stat-label">Khác</div>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Danh sách đơn hàng</h4>
                            <div>
                                <span class="text-muted">Tổng: ${totalOrders} đơn hàng</span>
                            </div>
                        </div>

                        <!-- Search -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <form method="get" action="staff-dashboard" class="d-flex">
                                    <input type="hidden" name="action" value="orders">
                                    <input type="text" name="search" class="form-control me-2" 
                                           placeholder="Tìm kiếm theo ID, tên khách hàng, email..." 
                                           value="${param.search}">
                                    <button type="submit" class="btn btn-outline-primary">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </form>
                            </div>
                        </div>

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

                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Khách hàng</th>
                                        <th>Tổng tiền</th>
                                        <th>Ngày tạo</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>#${order.id}</td>
                                            <td>${order.customerName}</td>
                                            <td>${String.format("%.0f", order.total_amount)} VND</td>
                                            <td>${order.create_date}</td>
                                            <td>
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
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="staff-dashboard?action=viewOrder&orderId=${order.id}" 
                                                       class="btn btn-info btn-sm" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <form method="post" action="staff-dashboard" style="display: inline;">
                                                        <input type="hidden" name="action" value="updateOrderStatus">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <select name="statusId" class="form-select form-select-sm" 
                                                                style="width: auto; display: inline-block;" 
                                                                onchange="this.form.submit()">
                                                            <option value="1" ${order.status_id == 1 ? 'selected' : ''}>Đang chờ xử lý</option>
                                                            <option value="2" ${order.status_id == 2 ? 'selected' : ''}>Đã xác nhận</option>
                                                            <option value="3" ${order.status_id == 3 ? 'selected' : ''}>Đang giao hàng</option>
                                                            <option value="4" ${order.status_id == 4 ? 'selected' : ''}>Đã giao hàng</option>
                                                            <option value="5" ${order.status_id == 5 ? 'selected' : ''}>Đã hủy</option>
                                                        </select>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="staff-dashboard?action=orders&page=${currentPage - 1}&search=${search}">Trước</a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="staff-dashboard?action=orders&page=${i}&search=${search}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="staff-dashboard?action=orders&page=${currentPage + 1}&search=${search}">Sau</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </main>

        </div>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
    </body>
</html>
