<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>${empty user ? 'Thêm người dùng' : 'Chỉnh sửa người dùng'} - Staff Dashboard</title>
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
            .form-group {
                margin-bottom: 20px;
            }
            .form-label {
                font-weight: bold;
                margin-bottom: 5px;
                display: block;
            }
            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }
            .form-control:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
            }
            .btn-group {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }
            .required {
                color: red;
            }
            .badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: bold;
            }
            .badge-success { 
                background: #28a745 !important; 
                color: white !important; 
            }
            .badge-warning { 
                background: #ffc107 !important; 
                color: #333 !important; 
            }
            .badge-danger { 
                background: #dc3545; 
                color: white; 
            }
            .badge-info { 
                background: #17a2b8; 
                color: white; 
            }
            .badge-secondary { 
                background: #6c757d; 
                color: white; 
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
                                <h3 class="text-center">${empty user ? 'Thêm người dùng mới' : 'Chỉnh sửa người dùng'}</h3>
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
                            <h4>${empty user ? 'Thông tin người dùng mới' : 'Chỉnh sửa thông tin người dùng'}</h4>
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

                        <form method="post" action="staff-dashboard">
                            <input type="hidden" name="action" value="${empty user ? 'addUser' : 'updateUser'}">
                            <c:if test="${not empty user}">
                                <input type="hidden" name="userId" value="${user.u_id}">
                            </c:if>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="email">Email <span class="required">*</span></label>
                                        <input type="email" id="email" name="email" class="form-control" 
                                               value="${user.u_email}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="password">Mật khẩu <span class="required">*</span></label>
                                        <input type="password" id="password" name="password" class="form-control" 
                                               ${empty user ? 'required' : 'placeholder="Để trống nếu không muốn thay đổi"'}">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="firstName">Tên <span class="required">*</span></label>
                                        <input type="text" id="firstName" name="firstName" class="form-control" 
                                               value="${user.f_name}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="lastName">Họ <span class="required">*</span></label>
                                        <input type="text" id="lastName" name="lastName" class="form-control" 
                                               value="${user.l_name}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="dob">Ngày sinh</label>
                                        <input type="date" id="dob" name="dob" class="form-control" 
                                               value="${user.dob}">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="permission">Quyền <span class="required">*</span></label>
                                        <select id="permission" name="permission" class="form-control" required>
                                            <option value="">Chọn quyền</option>
                                            <c:choose>
                                                <c:when test="${sessionScope.account.permission_id == 1}">
                                                    <!-- Admin có thể tạo tất cả role -->
                                                    <option value="2" ${user.permission_id == 2 ? 'selected' : ''}>User</option>
                                                    <option value="3" ${user.permission_id == 3 ? 'selected' : ''}>Staff</option>
                                                    <option value="4" ${user.permission_id == 4 ? 'selected' : ''}>Shipper</option>
                                                </c:when>
                                                <c:when test="${sessionScope.account.permission_id == 3}">
                                                    <!-- Staff chỉ có thể tạo User và Shipper -->
                                                    <option value="2" ${user.permission_id == 2 ? 'selected' : ''}>User</option>
                                                    <option value="4" ${user.permission_id == 4 ? 'selected' : ''}>Shipper</option>
                                                </c:when>
                                            </c:choose>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <c:if test="${not empty user}">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Trạng thái xác thực</label>
                                            <div style="padding: 10px; background: #f8f9fa; border-radius: 5px; border: 1px solid #dee2e6;">
                                                <c:choose>
                                                    <c:when test="${user.is_verified}">
                                                        <span class="badge badge-success" style="background: #28a745 !important; color: white !important; padding: 8px 15px; border-radius: 20px; font-weight: bold; display: inline-block;">✓ Đã xác thực</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-warning" style="background: #ffc107 !important; color: #333 !important; padding: 8px 15px; border-radius: 20px; font-weight: bold; display: inline-block;">⚠ Chưa xác thực</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">ID người dùng</label>
                                            <div style="padding: 10px; background: #f8f9fa; border-radius: 5px; border: 1px solid #dee2e6; font-weight: bold; color: #007bff;">
                                                #${user.u_id}
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Mã xác thực</label>
                                            <div style="padding: 10px; background: #f8f9fa; border-radius: 5px; border: 1px solid #dee2e6;">
                                                <c:choose>
                                                    <c:when test="${not empty user.verification_code}">
                                                        <code style="font-size: 16px; font-weight: bold; color: #dc3545;">${user.verification_code}</code>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Chưa có mã xác thực</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Ngày tạo</label>
                                            <div style="padding: 10px; background: #f8f9fa; border-radius: 5px; border: 1px solid #dee2e6;">
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
                                </div>
                            </c:if>

                            <div class="btn-group">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${empty user ? 'Thêm người dùng' : 'Cập nhật'}
                                </button>
                                <a href="staff-dashboard?action=users" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </main>

        </div>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
    </body>
</html>
