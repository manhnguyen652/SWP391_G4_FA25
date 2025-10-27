<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Chi tiết tác giả - Staff Dashboard</title>
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
            .badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.8rem;
            }
            .badge-success { background: #28a745; color: white; }
            .badge-warning { background: #ffc107; color: #333; }
            .badge-danger { background: #dc3545; color: white; }
            .badge-info { background: #17a2b8; color: white; }
            .author-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .author-name {
                font-size: 2rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            .author-bio {
                font-size: 1.1rem;
                line-height: 1.6;
                color: #666;
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
                                <h3 class="text-center">Chi tiết tác giả</h3>
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
                                <a href="staff-dashboard?action=authors" class="active">Quản lý tác giả</a>
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
                    <!-- Back Button -->
                    <div class="row mb-3">
                        <div class="col-12">
                            <a href="staff-dashboard?action=authors" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
                            </a>
                        </div>
                    </div>

                    <!-- Author Information -->
                    <div class="dashboard-card">
                        <div class="author-info">
                            <div class="author-name">${author.name}</div>
                            <div class="author-bio">
                                <c:choose>
                                    <c:when test="${not empty author.bio}">
                                        ${author.bio}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Chưa có tiểu sử</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Statistics -->
                        <div class="row">
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card primary">
                                    <div class="stat-number">${author.id}</div>
                                    <div class="stat-label">ID Tác giả</div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card info">
                                    <div class="stat-number">${bookCount}</div>
                                    <div class="stat-label">Số sách</div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card success">
                                    <div class="stat-number">
                                        <c:choose>
                                            <c:when test="${isInUse}">Có</c:when>
                                            <c:otherwise>Không</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="stat-label">Đang sử dụng</div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card warning">
                                    <div class="stat-number">
                                        <c:choose>
                                            <c:when test="${bookCount > 0}">Có sách</c:when>
                                            <c:otherwise>Chưa có sách</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="stat-label">Trạng thái</div>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="btn-group" role="group">
                                    <a href="staff-dashboard?action=editAuthor&authorId=${author.id}" 
                                       class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Chỉnh sửa
                                    </a>
                                    <c:if test="${!isInUse}">
                                        <form action="staff-dashboard" method="post" style="display:inline;" 
                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa tác giả này?');">
                                            <input type="hidden" name="action" value="deleteAuthor">
                                            <input type="hidden" name="authorId" value="${author.id}">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fas fa-trash"></i> Xóa
                                            </button>
                                        </form>
                                    </c:if>
                                    <a href="staff-dashboard?action=exportAuthors" class="btn btn-success">
                                        <i class="fas fa-file-excel"></i> Xuất Excel
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Warning if author is in use -->
                        <c:if test="${isInUse}">
                            <div class="alert alert-warning mt-3" role="alert">
                                <i class="fas fa-exclamation-triangle"></i>
                                <strong>Lưu ý:</strong> Tác giả này đang được sử dụng bởi ${bookCount} cuốn sách, không thể xóa.
                            </div>
                        </c:if>
                    </div>
                </div>
            </main>
        </div>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/main.js"></script>
    </body>
</html>
