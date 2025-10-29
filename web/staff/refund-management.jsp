<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Quản lý hoàn tiền - Staff Dashboard</title>
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
            .badge-secondary { background: #6c757d; color: white; }
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
                                <h3 class="text-center">Quản lý hoàn tiền</h3>
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
                                <a href="staff-dashboard?action=orders">Quản lý đơn hàng</a>
                                <a href="staff-dashboard?action=refunds" class="active">Quản lý hoàn tiền</a>
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
                                <div class="stat-number">${totalRefunds}</div>
                                <div class="stat-label">Tổng yêu cầu</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card warning">
                                <div class="stat-number">${pendingRefunds}</div>
                                <div class="stat-label">Chờ xử lý</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card success">
                                <div class="stat-number">${completedRefunds}</div>
                                <div class="stat-label">Đã hoàn tiền</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card info">
                                <div class="stat-number"><fmt:formatNumber value="${totalRefundAmount}" type="currency" currencySymbol="VND"/></div>
                                <div class="stat-label">Tổng hoàn tiền</div>
                            </div>
                        </div>
                    </div>

                    <!-- Status Statistics -->
                    <div class="row mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card warning">
                                <div class="stat-number">${pendingRefunds}</div>
                                <div class="stat-label">Chờ xử lý</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card info">
                                <div class="stat-number">${approvedRefunds}</div>
                                <div class="stat-label">Đã duyệt</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card success">
                                <div class="stat-number">${completedRefunds}</div>
                                <div class="stat-label">Hoàn thành</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card danger">
                                <div class="stat-number">${rejectedRefunds}</div>
                                <div class="stat-label">Từ chối</div>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Danh sách yêu cầu hoàn tiền</h4>
                            <div>
                                <span class="text-muted">Tổng: ${totalRefunds} yêu cầu</span>
                            </div>
                        </div>

                        <!-- Search -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <form method="get" action="staff-dashboard" class="d-flex">
                                    <input type="hidden" name="action" value="refunds">
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
                                        <th>Đơn hàng</th>
                                        <th>Khách hàng</th>
                                        <th>Số tiền</th>
                                        <th>Lý do</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày yêu cầu</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="refund" items="${refunds}">
                                        <tr>
                                            <td>#${refund.id}</td>
                                            <td>#${refund.orderId}</td>
                                            <td>User #${refund.userId}</td>
                                            <td><fmt:formatNumber value="${refund.amount}" type="currency" currencySymbol="VND"/></td>
                                            <td>${refund.reason}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${refund.status == 'PENDING'}">
                                                        <span class="badge badge-warning">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${refund.status == 'APPROVED'}">
                                                        <span class="badge badge-info">Đã duyệt</span>
                                                    </c:when>
                                                    <c:when test="${refund.status == 'COMPLETED'}">
                                                        <span class="badge badge-success">Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${refund.status == 'REJECTED'}">
                                                        <span class="badge badge-danger">Từ chối</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-secondary">${refund.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${refund.requestDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="staff-dashboard?action=viewRefund&refundId=${refund.id}" 
                                                       class="btn btn-info btn-sm" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${refund.status == 'PENDING'}">
                                                        <form method="post" action="staff-dashboard" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateRefundStatus">
                                                            <input type="hidden" name="refundId" value="${refund.id}">
                                                            <input type="hidden" name="status" value="APPROVED">
                                                            <button type="submit" class="btn btn-success btn-sm" title="Duyệt">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                        </form>
                                                        <form method="post" action="staff-dashboard" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateRefundStatus">
                                                            <input type="hidden" name="refundId" value="${refund.id}">
                                                            <input type="hidden" name="status" value="REJECTED">
                                                            <button type="submit" class="btn btn-danger btn-sm" title="Từ chối">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
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
                                            <a class="page-link" href="staff-dashboard?action=refunds&page=${currentPage - 1}&search=${search}">Trước</a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="staff-dashboard?action=refunds&page=${i}&search=${search}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="staff-dashboard?action=refunds&page=${currentPage + 1}&search=${search}">Sau</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </main>
        </div>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/main.js"></script>
    </body>
</html>
