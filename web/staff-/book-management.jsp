<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Quản lý sách - Staff Dashboard</title>
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
            .stat-card.danger .stat-number { color: #dc3545; }
            .stat-card.info .stat-number { color: #17a2b8; }
            .btn-group .btn {
                margin-right: 5px;
            }
            .btn-group .btn:last-child {
                margin-right: 0;
            }
            .title-column {
                min-width: 200px;
            }
            .action-column {
                min-width: 150px;
            }
            .price-column {
                text-align: right;
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
                                <h3 class="text-center">Quản lý sách</h3>
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
                                <a href="staff-dashboard?action=books" class="active">Quản lý sách</a>
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
                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card primary">
                                <div class="stat-number">${totalBooks}</div>
                                <div class="stat-label">Tổng sách</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card warning">
                                <div class="stat-number">${lowStockCount}</div>
                                <div class="stat-label">Sách sắp hết</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card danger">
                                <div class="stat-number">${outOfStockCount}</div>
                                <div class="stat-label">Hết hàng</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card success">
                                <div class="stat-number">
                                    <c:set var="totalSold" value="0" />
                                    <c:forEach var="book" items="${books}">
                                        <c:set var="soldCount" value="${soldCountMap[book.BId]}" />
                                        <c:if test="${not empty soldCount}">
                                            <c:set var="totalSold" value="${totalSold + soldCount}" />
                                        </c:if>
                                    </c:forEach>
                                    ${totalSold}
                                </div>
                                <div class="stat-label">Đã bán</div>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Danh sách sách</h4>
                            <div class="btn-group">
                                <a href="staff-dashboard?action=addBook" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus"></i> Thêm sách
                                </a>
                                <a href="staff-dashboard?action=exportBooks" class="btn btn-success btn-sm">
                                    <i class="fas fa-file-excel"></i> Xuất Excel
                                </a>
                            </div>
                        </div>

                        <!-- Search -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <form method="get" action="staff-dashboard" class="d-flex">
                                    <input type="hidden" name="action" value="books">
                                    <input type="text" name="search" class="form-control me-2" 
                                           placeholder="Tìm kiếm theo tên sách, tác giả, danh mục..." 
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
                                        <th class="title-column">Tên sách</th>
                                        <th>Tác giả</th>
                                        <th>Danh mục</th>
                                        <th>Năm XB</th>
                                        <th class="price-column">Giá</th>
                                        <th>Tồn kho</th>
                                        <th>Đã bán</th>
                                        <th>Trạng thái</th>
                                        <th class="action-column">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="book" items="${books}">
                                        <tr>
                                            <td>${book.BId}</td>
                                            <td class="title-column">${book.BTitle}</td>
                                            <td>${book.authorName}</td>
                                            <td>${book.categoryName}</td>
                                            <td>${book.publicationYear}</td>
                                            <td class="price-column">
                                                <fmt:formatNumber value="${book.price}" type="currency" currencyCode="VND"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${book.stock == 0}">
                                                        <span class="badge badge-danger">Hết hàng</span>
                                                    </c:when>
                                                    <c:when test="${book.stock < 10}">
                                                        <span class="badge badge-warning">${book.stock}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-success">${book.stock}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:set var="soldCount" value="${soldCountMap[book.BId]}" />
                                                <c:if test="${empty soldCount}">
                                                    <c:set var="soldCount" value="0" />
                                                </c:if>
                                                <span class="badge badge-info">${soldCount}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${book.stock == 0}">
                                                        <span class="badge badge-danger">Hết hàng</span>
                                                    </c:when>
                                                    <c:when test="${book.stock < 10}">
                                                        <span class="badge badge-warning">Sắp hết</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-success">Còn hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="action-column">
                                                <div class="btn-group" role="group">
                                                    <a href="staff-dashboard?action=viewBook&bookId=${book.BId}" 
                                                       class="btn btn-info btn-sm" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="staff-dashboard?action=editBook&bookId=${book.BId}" 
                                                       class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <c:set var="soldCount" value="${soldCountMap[book.BId]}" />
                                                    <c:if test="${empty soldCount}">
                                                        <c:set var="soldCount" value="0" />
                                                    </c:if>
                                                    <c:if test="${soldCount == 0}">
                                                        <form action="staff-dashboard" method="post" style="display:inline;" 
                                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa sách này?');">
                                                            <input type="hidden" name="action" value="deleteBook">
                                                            <input type="hidden" name="bookId" value="${book.BId}">
                                                            <button type="submit" class="btn btn-danger btn-sm" title="Xóa">
                                                                <i class="fas fa-trash"></i>
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
                                            <a class="page-link" href="staff-dashboard?action=books&page=${currentPage - 1}&search=${search}">Trước</a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="staff-dashboard?action=books&page=${i}&search=${search}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="staff-dashboard?action=books&page=${currentPage + 1}&search=${search}">Sau</a>
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