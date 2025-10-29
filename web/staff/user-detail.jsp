<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Chi tiết người dùng - Staff Dashboard</title>
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
            .badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
            }
            .badge-success { background: #28a745 !important; color: white !important; }
            .badge-warning { background: #ffc107 !important; color: #333 !important; }
            .badge-danger { background: #dc3545; color: white; }
            .badge-info { background: #17a2b8; color: white; }
            .badge-secondary { background: #6c757d; color: white; }
            .user-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .info-row {
                display: flex;
                margin-bottom: 15px;
            }
            .info-label {
                font-weight: bold;
                width: 150px;
                color: #333;
            }
            .info-value {
                flex: 1;
                color: #666;
            }
            .action-buttons {
                margin-top: 20px;
            }
            .btn-group {
                display: flex;
                gap: 10px;
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
                                <h3 class="text-center">Chi tiết người dùng</h3>
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
                                <a href="staff-dashboard?action=users" class="active">Quản lý người dùng</a>
                                <a href="staff-dashboard?action=books">Quản lý sách</a>
                                <a href="staff-dashboard?action=authors">Quản lý tác giả</a>
                                <a href="staff-dashboard?action=categories">Quản lý danh mục</a>
                                <a href="staff-dashboard?action=orders">Quản lý đơn hàng</a>
                                <a href="staff-dashboard?action=refunds">Quản lý hoàn tiền</a>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <main class="inner-page-sec-padding-bottom">
                <div class="container">
                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Thông tin chi tiết người dùng</h4>
                            <a href="staff-dashboard?action=users" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
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

                        <c:if test="${not empty user}">
                            <div class="user-info">
                                <div class="info-row">
                                    <div class="info-label">ID:</div>
                                    <div class="info-value">${user.u_id}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Email:</div>
                                    <div class="info-value">${user.u_email}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Họ tên:</div>
                                    <div class="info-value">${user.l_name} ${user.f_name}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Ngày sinh:</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty user.dob}">
                                                <fmt:formatDate value="${user.dob}" pattern="dd/MM/yyyy" type="date"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa cập nhật</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Quyền:</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${user.permission_id == 1}">
                                                <span class="badge badge-danger">Admin</span>
                                            </c:when>
                                            <c:when test="${user.permission_id == 2}">
                                                <span class="badge badge-info">User</span>
                                            </c:when>
                                            <c:when test="${user.permission_id == 3}">
                                                <span class="badge badge-warning">Staff</span>
                                            </c:when>
                                            <c:when test="${user.permission_id == 4}">
                                                <span class="badge badge-success">Shipper</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-secondary">Unknown</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Trạng thái:</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${user.is_verified}">
                                                <span class="badge badge-success">Đã xác thực</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning">Chưa xác thực</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Mã xác thực:</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty user.verification_code}">
                                                <code>${user.verification_code}</code>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Ngày tạo:</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty user.create_date}">
                                                <fmt:formatDate value="${user.create_date}" pattern="dd/MM/yyyy HH:mm:ss" type="both"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="action-buttons">
                                <div class="btn-group">
                                    <c:choose>
                                        <c:when test="${sessionScope.account.permission_id == 1}">
                                            <!-- Admin có thể chỉnh sửa tất cả trừ Admin khác -->
                                            <c:if test="${user.permission_id != 1}">
                                                <a href="staff-dashboard?action=editUser&userId=${user.u_id}" class="btn btn-primary">
                                                    <i class="fas fa-edit"></i> Chỉnh sửa
                                                </a>
                                                <c:choose>
                                                    <c:when test="${user.isIs_verified()}">
                                                        <form method="post" action="staff-dashboard" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateUserStatus">
                                                            <input type="hidden" name="userId" value="${user.u_id}">
                                                            <input type="hidden" name="isVerified" value="false">
                                                            <button type="submit" class="btn btn-warning">
                                                                <i class="fas fa-times"></i> Hủy xác thực
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form method="post" action="staff-dashboard" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateUserStatus">
                                                            <input type="hidden" name="userId" value="${user.u_id}">
                                                            <input type="hidden" name="isVerified" value="true">
                                                            <button type="submit" class="btn btn-success">
                                                                <i class="fas fa-check"></i> Xác thực
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:when>
                                        <c:when test="${sessionScope.account.permission_id == 3}">
                                            <!-- Staff có thể chỉnh sửa User và Shipper -->
                                            <c:if test="${user.permission_id == 2 || user.permission_id == 4}">
                                                <a href="staff-dashboard?action=editUser&userId=${user.u_id}" class="btn btn-primary">
                                                    <i class="fas fa-edit"></i> Chỉnh sửa
                                                </a>
                                                <c:choose>
                                                    <c:when test="${user.isIs_verified()}">
                                                        <form method="post" action="staff-dashboard" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateUserStatus">
                                                            <input type="hidden" name="userId" value="${user.u_id}">
                                                            <input type="hidden" name="isVerified" value="false">
                                                            <button type="submit" class="btn btn-warning">
                                                                <i class="fas fa-times"></i> Hủy xác thực
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form method="post" action="staff-dashboard" style="display: inline;">
                                                            <input type="hidden" name="action" value="updateUserStatus">
                                                            <input type="hidden" name="userId" value="${user.u_id}">
                                                            <input type="hidden" name="isVerified" value="true">
                                                            <button type="submit" class="btn btn-success">
                                                                <i class="fas fa-check"></i> Xác thực
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
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
