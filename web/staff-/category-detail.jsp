<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Chi tiết danh mục - Staff Dashboard</title>
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
            .category-header {
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 2px solid #f8f9fa;
            }
            .category-icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: #007bff;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                font-weight: bold;
                margin: 0 auto 15px;
            }
            .category-name {
                font-size: 1.8rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            .info-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid #f8f9fa;
            }
            .info-label {
                font-weight: 600;
                color: #333;
                min-width: 150px;
            }
            .info-value {
                color: #666;
                flex: 1;
            }
            .badge {
                display: inline-block;
                padding: 6px 12px;
                font-size: 12px;
                font-weight: 500;
                line-height: 1;
                text-align: center;
                white-space: nowrap;
                vertical-align: baseline;
                border-radius: 0.25rem;
            }
            .badge-success { background: #28a745 !important; color: white !important; }
            .badge-warning { background: #ffc107 !important; color: #333 !important; }
            .badge-danger { background: #dc3545; color: white; }
            .badge-info { background: #17a2b8; color: white; }
            .action-buttons {
                margin-top: 30px;
                text-align: center;
            }
            .btn-group .btn {
                margin: 0 5px;
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
                                <h3 class="text-center">Chi tiết danh mục</h3>
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
                            <h4>Thông tin chi tiết danh mục</h4>
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

                        <c:if test="${not empty category}">
                            <!-- Category Header -->
                            <div class="category-header">
                                <div class="category-icon">
                                    ${category.cateName.charAt(0)}
                                </div>
                                <div class="category-name">${category.cateName}</div>
                            </div>

                            <!-- Category Info -->
                            <div class="category-info">
                                <div class="info-row">
                                    <div class="info-label">ID:</div>
                                    <div class="info-value">#${category.id}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Tên danh mục:</div>
                                    <div class="info-value">${category.cateName}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Số sách:</div>
                                    <div class="info-value">
                                        <span class="badge badge-info">${bookCount} sách</span>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Trạng thái:</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${bookCount > 0}">
                                                <span class="badge badge-success">Có sách</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning">Trống</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Có thể xóa:</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${bookCount == 0}">
                                                <span class="badge badge-success">Có thể xóa</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Không thể xóa (có sách)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="action-buttons">
                                <div class="btn-group">
                                    <a href="staff-dashboard?action=editCategory&categoryId=${category.id}" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Chỉnh sửa
                                    </a>
                                    <c:choose>
                                        <c:when test="${bookCount == 0}">
                                            <form method="post" action="staff-dashboard" style="display: inline;" 
                                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                                <input type="hidden" name="action" value="deleteCategory">
                                                <input type="hidden" name="categoryId" value="${category.id}">
                                                <button type="submit" class="btn btn-danger">
                                                    <i class="fas fa-trash"></i> Xóa
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-secondary" disabled>
                                                <i class="fas fa-lock"></i> Không thể xóa
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="staff-dashboard?action=categories" class="btn btn-secondary">
                                        <i class="fas fa-list"></i> Danh sách
                                    </a>
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
