<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>${empty category ? 'Thêm danh mục' : 'Chỉnh sửa danh mục'} - Staff Dashboard</title>
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
            .form-group {
                margin-bottom: 20px;
            }
            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 8px;
                display: block;
            }
            .form-control {
                width: 100%;
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                transition: border-color 0.3s;
            }
            .form-control:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
            }
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.3s;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }
            .btn-primary {
                background: #007bff;
                color: white;
            }
            .btn-primary:hover {
                background: #0056b3;
            }
            .btn-secondary {
                background: #6c757d;
                color: white;
            }
            .btn-secondary:hover {
                background: #545b62;
            }
            .btn-danger {
                background: #dc3545;
                color: white;
            }
            .btn-danger:hover {
                background: #c82333;
            }
            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 5px;
            }
            .alert-success {
                color: #155724;
                background-color: #d4edda;
                border-color: #c3e6cb;
            }
            .alert-danger {
                color: #721c24;
                background-color: #f8d7da;
                border-color: #f5c6cb;
            }
            .required {
                color: #dc3545;
            }
            .badge {
                display: inline-block;
                padding: 8px 16px;
                font-size: 12px;
                font-weight: bold;
                line-height: 1;
                text-align: center;
                white-space: nowrap;
                vertical-align: baseline;
                border-radius: 20px;
                border: 2px solid;
            }
            .badge-success { 
                background: #28a745 !important; 
                color: white !important; 
                border-color: #1e7e34 !important;
            }
            .badge-warning { 
                background: #ffc107 !important; 
                color: #212529 !important; 
                border-color: #e0a800 !important;
            }
            .category-info {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
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
                                <h3 class="text-center">${empty category ? 'Thêm danh mục' : 'Chỉnh sửa danh mục'}</h3>
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
                                <a href="staff-dashboard?action=categories" class="active">Quản lý danh mục</a>
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
                            <h4>${empty category ? 'Thêm danh mục mới' : 'Chỉnh sửa danh mục'}</h4>
                            <a href="staff-dashboard?action=categories" class="btn btn-secondary">
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
                            <input type="hidden" name="action" value="${empty category ? 'addCategory' : 'updateCategory'}">
                            <c:if test="${not empty category}">
                                <input type="hidden" name="categoryId" value="${category.id}">
                            </c:if>

                            <div class="form-group">
                                <label class="form-label" for="categoryName">Tên danh mục <span class="required">*</span></label>
                                <input type="text" id="categoryName" name="categoryName" class="form-control" 
                                       value="${category.cateName}" required 
                                       placeholder="Nhập tên danh mục...">
                            </div>

                            <c:if test="${not empty category}">
                                <div class="category-info">
                                    <h6>Thông tin danh mục:</h6>
                                    <p><strong>ID:</strong> #${category.id}</p>
                                    <p><strong>Số sách:</strong> ${bookCount}</p>
                                    <p><strong>Trạng thái:</strong> 
                                        <c:choose>
                                            <c:when test="${bookCount > 0}">
                                                <span class="badge badge-success" style="background: #28a745 !important; color: white !important; border: 2px solid #1e7e34 !important; padding: 8px 16px; border-radius: 20px; font-weight: bold;">✓ Có sách</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning" style="background: #ffc107 !important; color: #212529 !important; border: 2px solid #e0a800 !important; padding: 8px 16px; border-radius: 20px; font-weight: bold;">⚠ Trống</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </c:if>

                            <div class="btn-group">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${empty category ? 'Thêm danh mục' : 'Cập nhật'}
                                </button>
                                <a href="staff-dashboard?action=categories" class="btn btn-secondary">
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
