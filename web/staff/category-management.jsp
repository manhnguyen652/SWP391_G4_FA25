<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Quản lý danh mục - Staff Dashboard</title>
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
            .badge-success { background: #28a745 !important; color: white !important; }
            .badge-warning { background: #ffc107 !important; color: #333 !important; }
            .badge-danger { background: #dc3545; color: white; }
            .badge-info { background: #17a2b8; color: white; }
            .pagination {
                justify-content: center;
            }
            .stat-card {
                text-align: center;
                padding: 20px;
            }
            .stat-number {
                font-size: 2rem;
                font-weight: bold;
                color: #007bff;
                margin-bottom: 5px;
            }
            .stat-label {
                color: #666;
                font-size: 0.9rem;
            }
            .btn-group .btn {
                margin-right: 1px;
                padding: 2px 4px;
                font-size: 10px;
                line-height: 1.1;
                border-radius: 2px;
                min-width: 24px;
                height: 24px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            .btn-group .btn:last-child {
                margin-right: 0;
            }
            .btn-sm {
                padding: 1px 3px;
                font-size: 9px;
                border-radius: 1px;
                min-width: 22px;
                height: 22px;
            }
            .btn-group .btn i {
                font-size: 9px;
            }
            .action-column {
                width: 120px;
                text-align: center;
                white-space: nowrap;
            }
            .name-column {
                min-width: 200px;
                max-width: 250px;
                word-wrap: break-word;
            }
            .table th, .table td {
                vertical-align: middle;
                padding: 8px 6px;
            }
            .table th.name-column, .table td.name-column {
                padding-left: 12px;
                padding-right: 12px;
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
                                <h3 class="text-center">Quản lý danh mục</h3>
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
                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${totalCategories}</div>
                                <div class="stat-label">Tổng danh mục</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${categoriesWithBooks}</div>
                                <div class="stat-label">Danh mục có sách</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${emptyCategories}</div>
                                <div class="stat-label">Danh mục trống</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${categoriesWithBooks}</div>
                                <div class="stat-label">Danh mục hoạt động</div>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Danh sách danh mục</h4>
                            <div>
                                <a href="staff-dashboard?action=addCategory" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Thêm danh mục
                                </a>
                            </div>
                        </div>

                        <!-- Search -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <form method="get" action="staff-dashboard" class="d-flex">
                                    <input type="hidden" name="action" value="categories">
                                    <input type="text" name="search" class="form-control me-2" 
                                           placeholder="Tìm kiếm theo tên danh mục..." 
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
                                        <th class="name-column">Tên danh mục</th>
                                        <th>Số sách</th>
                                        <th>Trạng thái</th>
                                        <th class="action-column">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="category" items="${categories}">
                                        <tr>
                                            <td>${category.id}</td>
                                            <td class="name-column">${category.cateName}</td>
                                            <td>
                                                <c:set var="bookCount" value="${bookCountMap[category.id]}" />
                                                <c:if test="${empty bookCount}">
                                                    <c:set var="bookCount" value="0" />
                                                </c:if>
                                                <span class="badge badge-info">${bookCount} sách</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${bookCount > 0}">
                                                        <span class="badge badge-success">Có sách</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-warning">Trống</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="action-column">
                                                <div class="btn-group" role="group">
                                                    <!-- View Detail Button -->
                                                    <a href="staff-dashboard?action=viewCategory&categoryId=${category.id}" class="btn btn-sm btn-info" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    
                                                    <!-- Edit Button -->
                                                    <a href="staff-dashboard?action=editCategory&categoryId=${category.id}" class="btn btn-sm btn-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    
                                                    <!-- Delete Button -->
                                                    <c:choose>
                                                        <c:when test="${bookCount == 0}">
                                                            <form method="post" action="staff-dashboard" style="display: inline;" 
                                                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                                                <input type="hidden" name="action" value="deleteCategory">
                                                                <input type="hidden" name="categoryId" value="${category.id}">
                                                                <button type="submit" class="btn btn-sm btn-danger" title="Xóa">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-sm btn-secondary" title="Không thể xóa - đang có sách" disabled>
                                                                <i class="fas fa-lock"></i>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
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
                                            <a class="page-link" href="staff-dashboard?action=categories&page=${currentPage - 1}&search=${param.search}">Trước</a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="staff-dashboard?action=categories&page=${i}&search=${param.search}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="staff-dashboard?action=categories&page=${currentPage + 1}&search=${param.search}">Sau</a>
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
