<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Chi tiết yêu cầu hoàn tiền - Staff Dashboard</title>
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
            .refund-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
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
                margin-right: 10px;
            }
            .btn-group .btn:last-child {
                margin-right: 0;
            }
            .status-actions {
                background: #fff;
                border: 1px solid #dee2e6;
                border-radius: 10px;
                padding: 20px;
                margin-top: 20px;
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
                                <h3 class="text-center">Chi tiết yêu cầu hoàn tiền</h3>
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

                    <!-- Refund Information -->
                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Thông tin yêu cầu hoàn tiền #${refund.id}</h4>
                            <div class="btn-group">
                                <a href="staff-dashboard?action=refunds" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>

                        <div class="refund-info">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6><strong>Thông tin yêu cầu:</strong></h6>
                                    <p><strong>ID yêu cầu:</strong> #${refund.id}</p>
                                    <p><strong>ID đơn hàng:</strong> #${refund.orderId}</p>
                                    <p><strong>Khách hàng:</strong> ${refund.customerName}</p>
                                    <p><strong>Email:</strong> ${refund.customerEmail}</p>
                                    <p><strong>Số tiền yêu cầu:</strong> <fmt:formatNumber value="${refund.amount}" type="currency" currencySymbol="VND"/></p>
                                    <p><strong>Lý do:</strong> ${refund.reason}</p>
                                </div>
                                <div class="col-md-6">
                                    <h6><strong>Trạng thái và thời gian:</strong></h6>
                                    <p><strong>Trạng thái hiện tại:</strong> 
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
                                    </p>
                                    <p><strong>Ngày yêu cầu:</strong> <fmt:formatDate value="${refund.requestDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                                    <c:if test="${not empty refund.processDate}">
                                        <p><strong>Ngày xử lý:</strong> <fmt:formatDate value="${refund.processDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                                    </c:if>
                                    <c:if test="${not empty refund.processedBy}">
                                        <p><strong>Người xử lý:</strong> ${refund.processedBy}</p>
                                    </c:if>
                                </div>
                            </div>
                            
                            <c:if test="${not empty refund.notes}">
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <h6><strong>Ghi chú:</strong></h6>
                                        <p class="text-muted">${refund.notes}</p>
                                    </div>
                                </div>
                            </c:if>
                            
                            <div class="row mt-3">
                                <div class="col-12">
                                    <h6><strong>Thông tin đơn hàng liên quan:</strong></h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p><strong>Tổng tiền đơn hàng:</strong> <fmt:formatNumber value="${refund.orderAmount}" type="currency" currencySymbol="VND"/></p>
                                        </div>
                                        <div class="col-md-6">
                                            <p><strong>Ngày tạo đơn hàng:</strong> <fmt:formatDate value="${refund.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Status Actions -->
                        <c:if test="${refund.status == 'PENDING'}">
                            <div class="status-actions">
                                <h6><strong>Thao tác xử lý:</strong></h6>
                                <div class="btn-group">
                                    <form method="post" action="staff-dashboard" style="display: inline;">
                                        <input type="hidden" name="action" value="updateRefundStatus">
                                        <input type="hidden" name="refundId" value="${refund.id}">
                                        <input type="hidden" name="status" value="APPROVED">
                                        <button type="submit" class="btn btn-success" 
                                                onclick="return confirm('Bạn có chắc chắn muốn duyệt yêu cầu hoàn tiền này?')">
                                            <i class="fas fa-check"></i> Duyệt yêu cầu
                                        </button>
                                    </form>
                                    <form method="post" action="staff-dashboard" style="display: inline;">
                                        <input type="hidden" name="action" value="updateRefundStatus">
                                        <input type="hidden" name="refundId" value="${refund.id}">
                                        <input type="hidden" name="status" value="REJECTED">
                                        <button type="submit" class="btn btn-danger" 
                                                onclick="return confirm('Bạn có chắc chắn muốn từ chối yêu cầu hoàn tiền này?')">
                                            <i class="fas fa-times"></i> Từ chối yêu cầu
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${refund.status == 'APPROVED'}">
                            <div class="status-actions">
                                <h6><strong>Thao tác tiếp theo:</strong></h6>
                                <div class="btn-group">
                                    <form method="post" action="staff-dashboard" style="display: inline;">
                                        <input type="hidden" name="action" value="updateRefundStatus">
                                        <input type="hidden" name="refundId" value="${refund.id}">
                                        <input type="hidden" name="status" value="COMPLETED">
                                        <button type="submit" class="btn btn-success" 
                                                onclick="return confirm('Bạn có chắc chắn đã hoàn tiền thành công?')">
                                            <i class="fas fa-check-circle"></i> Xác nhận hoàn tiền
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${refund.status == 'COMPLETED'}">
                            <div class="status-actions">
                                <div class="alert alert-success">
                                    <i class="fas fa-check-circle"></i> 
                                    <strong>Yêu cầu hoàn tiền đã được xử lý thành công!</strong>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${refund.status == 'REJECTED'}">
                            <div class="status-actions">
                                <div class="alert alert-danger">
                                    <i class="fas fa-times-circle"></i> 
                                    <strong>Yêu cầu hoàn tiền đã bị từ chối!</strong>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Related Actions -->
                    <div class="dashboard-card">
                        <h5 class="mb-4">Thao tác liên quan</h5>
                        <div class="btn-group">
                            <a href="staff-dashboard?action=viewOrder&orderId=${refund.orderId}" 
                               class="btn btn-info">
                                <i class="fas fa-eye"></i> Xem đơn hàng liên quan
                            </a>
                            <a href="staff-dashboard?action=refunds" 
                               class="btn btn-secondary">
                                <i class="fas fa-list"></i> Danh sách hoàn tiền
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/main.js"></script>
    </body>
</html>
