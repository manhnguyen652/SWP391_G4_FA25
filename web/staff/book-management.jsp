<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Quản lý sản phẩm - Staff Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4F46E5;
                --primary-dark: #4338CA;
                --success-color: #10B981;
                --warning-color: #F59E0B;
                --danger-color: #EF4444;
                --info-color: #3B82F6;
                --dark-color: #1F2937;
                --light-bg: #F9FAFB;
                --border-color: #E5E7EB;
                --text-primary: #111827;
                --text-secondary: #6B7280;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: var(--light-bg);
                color: var(--text-primary);
            }

            /* Header Styles */
            .staff-header {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                color: white;
                padding: 1.5rem 0;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .staff-header .logo {
                font-size: 1.5rem;
                font-weight: 700;
                text-decoration: none;
                color: white;
            }

            .staff-header .user-menu {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.2);
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
            }

            /* Navigation */
            .staff-nav {
                background: white;
                border-bottom: 1px solid var(--border-color);
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }

            .staff-nav .nav-link {
                padding: 1rem 1.5rem;
                color: var(--text-secondary);
                font-weight: 500;
                transition: all 0.3s ease;
                border-bottom: 3px solid transparent;
            }

            .staff-nav .nav-link:hover {
                color: var(--primary-color);
                background: var(--light-bg);
            }

            .staff-nav .nav-link.active {
                color: var(--primary-color);
                border-bottom-color: var(--primary-color);
                background: var(--light-bg);
            }

            /* Stat Cards */
            .stat-card {
                background: white;
                border-radius: 16px;
                padding: 1.5rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border-left: 4px solid transparent;
            }

            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            }

            .stat-card.primary { border-left-color: var(--primary-color); }
            .stat-card.success { border-left-color: var(--success-color); }
            .stat-card.warning { border-left-color: var(--warning-color); }
            .stat-card.danger { border-left-color: var(--danger-color); }

            .stat-card .stat-icon {
                width: 48px;
                height: 48px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 1rem;
            }

            .stat-card.primary .stat-icon {
                background: rgba(79, 70, 229, 0.1);
                color: var(--primary-color);
            }

            .stat-card.success .stat-icon {
                background: rgba(16, 185, 129, 0.1);
                color: var(--success-color);
            }

            .stat-card.warning .stat-icon {
                background: rgba(245, 158, 11, 0.1);
                color: var(--warning-color);
            }

            .stat-card.danger .stat-icon {
                background: rgba(239, 68, 68, 0.1);
                color: var(--danger-color);
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                color: var(--text-primary);
            }

            .stat-label {
                font-size: 0.875rem;
                color: var(--text-secondary);
                font-weight: 500;
            }

            /* Main Content Card */
            .content-card {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-top: 2rem;
            }

            .content-card .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid var(--border-color);
            }

            .content-card .card-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
                margin: 0;
            }

            /* Buttons */
            .btn-modern {
                border-radius: 8px;
                padding: 0.625rem 1.25rem;
                font-weight: 500;
                transition: all 0.3s ease;
                border: none;
            }

            .btn-modern:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .btn-primary-modern {
                background: var(--primary-color);
                color: white;
            }

            .btn-primary-modern:hover {
                background: var(--primary-dark);
                color: white;
            }

            .btn-success-modern {
                background: var(--success-color);
                color: white;
            }

            /* Search Box */
            .search-box {
                position: relative;
                margin-bottom: 1.5rem;
            }

            .search-box input {
                border-radius: 10px;
                border: 1px solid var(--border-color);
                padding: 0.75rem 1rem 0.75rem 3rem;
                transition: all 0.3s ease;
            }

            .search-box input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            }

            .search-box .search-icon {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-secondary);
            }

            /* Table Styles */
            .table-modern {
                width: 100%;
            }

            .table-modern thead {
                background: var(--light-bg);
            }

            .table-modern thead th {
                font-weight: 600;
                color: var(--text-primary);
                text-transform: uppercase;
                font-size: 0.75rem;
                letter-spacing: 0.05em;
                padding: 1rem;
                border-bottom: 2px solid var(--border-color);
            }

            .table-modern tbody tr {
                transition: all 0.2s ease;
            }

            .table-modern tbody tr:hover {
                background: var(--light-bg);
            }

            .table-modern tbody td {
                padding: 1rem;
                vertical-align: middle;
            }

            /* Badges */
            .badge-modern {
                padding: 0.375rem 0.75rem;
                border-radius: 6px;
                font-weight: 500;
                font-size: 0.75rem;
            }

            .badge-success-modern {
                background: rgba(16, 185, 129, 0.1);
                color: var(--success-color);
            }

            .badge-warning-modern {
                background: rgba(245, 158, 11, 0.1);
                color: var(--warning-color);
            }

            .badge-danger-modern {
                background: rgba(239, 68, 68, 0.1);
                color: var(--danger-color);
            }

            .badge-info-modern {
                background: rgba(59, 130, 246, 0.1);
                color: var(--info-color);
            }

            /* Action Buttons */
            .btn-action {
                width: 36px;
                height: 36px;
                padding: 0;
                border-radius: 8px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin: 0 2px;
                transition: all 0.2s ease;
            }

            .btn-action:hover {
                transform: scale(1.1);
            }

            /* Pagination */
            .pagination-modern {
                display: flex;
                justify-content: center;
                gap: 0.5rem;
                margin-top: 2rem;
            }

            .pagination-modern .page-link {
                border-radius: 8px;
                border: 1px solid var(--border-color);
                color: var(--text-primary);
                padding: 0.5rem 1rem;
                transition: all 0.2s ease;
            }

            .pagination-modern .page-link:hover {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }

            .pagination-modern .page-item.active .page-link {
                background: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
            }

            /* Alerts */
            .alert-modern {
                border-radius: 12px;
                border: none;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 3rem;
                color: var(--text-secondary);
            }

            .empty-state i {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .staff-nav {
                    overflow-x: auto;
                }

                .content-card {
                    padding: 1rem;
                }

                .table-responsive {
                    overflow-x: auto;
                }
            }
        </style>
    </head>

    <body>
        <!-- Header -->
        <header class="staff-header">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <a href="home" class="logo">
                        <i class="fas fa-book-open me-2"></i>BookStore Management
                    </a>
                    <div class="user-menu">
                        <div class="user-avatar">
                            ${sessionScope.account.f_name.charAt(0)}${sessionScope.account.l_name.charAt(0)}
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-link text-white dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                ${sessionScope.account.f_name} ${sessionScope.account.l_name}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="profile"><i class="fas fa-user me-2"></i>Hồ sơ cá nhân</a></li>
                                <li><a class="dropdown-item" href="my-account"><i class="fas fa-cog me-2"></i>Tài khoản của tôi</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="home"><i class="fas fa-home me-2"></i>Về trang chủ</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- Navigation -->
        <nav class="staff-nav">
            <div class="container">
                <ul class="nav">
                    <li class="nav-item">
                        <a class="nav-link" href="staff-dashboard"><i class="fas fa-chart-line me-2"></i>Tổng quan</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="book-management"><i class="fas fa-book me-2"></i>Quản lý sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="staff-dashboard?action=authors"><i class="fas fa-user-edit me-2"></i>Tác giả</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="staff-dashboard?action=categories"><i class="fas fa-list me-2"></i>Danh mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="staff-dashboard?action=orders"><i class="fas fa-shopping-cart me-2"></i>Đơn hàng</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="container my-4">
            <!-- Statistics Cards -->
            <div class="row g-4 mb-4">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card primary">
                        <div class="stat-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="stat-number">${totalBooks}</div>
                        <div class="stat-label">Tổng sách</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card warning">
                        <div class="stat-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="stat-number">${lowStockCount}</div>
                        <div class="stat-label">Sắp hết hàng</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card danger">
                        <div class="stat-icon">
                            <i class="fas fa-times-circle"></i>
                        </div>
                        <div class="stat-number">${outOfStockCount}</div>
                        <div class="stat-label">Hết hàng</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card success">
                        <div class="stat-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
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

            <!-- Content Card -->
            <div class="content-card">
                <div class="card-header">
                    <h2 class="card-title"><i class="fas fa-list me-2"></i>Danh sách sản phẩm</h2>
                    <div class="d-flex gap-2">
                        <a href="book-management?action=add" class="btn btn-primary-modern btn-modern">
                            <i class="fas fa-plus me-2"></i>Thêm sách
                        </a>
                    </div>
                </div>

                <!-- Search -->
                <form method="get" action="book-management" class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" name="search" class="form-control" 
                           placeholder="Tìm kiếm theo tên sách, tác giả, danh mục..." 
                           value="${param.search}">
                </form>

                <!-- Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-modern alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-modern alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table table-modern">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên sách</th>
                                <th>Tác giả</th>
                                <th>Danh mục</th>
                                <th>Năm XB</th>
                                <th class="text-end">Giá</th>
                                <th class="text-center">Tồn kho</th>
                                <th class="text-center">Đã bán</th>
                                <th class="text-center">Trạng thái</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty books}">
                                    <tr>
                                        <td colspan="10">
                                            <div class="empty-state">
                                                <i class="fas fa-inbox"></i>
                                                <p>Không tìm thấy sách nào</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="book" items="${books}">
                                        <tr>
                                            <td><strong>#${book.BId}</strong></td>
                                            <td>
                                                <strong>${book.BTitle}</strong>
                                            </td>
                                            <td>${book.authorName}</td>
                                            <td>${book.categoryName}</td>
                                            <td>${book.publicationYear}</td>
                                            <td class="text-end">
                                                <strong>
                                                    <fmt:formatNumber value="${book.price}" type="number" maxFractionDigits="0"/> ₫
                                                </strong>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${book.stock == 0}">
                                                        <span class="badge badge-danger-modern badge-modern">0</span>
                                                    </c:when>
                                                    <c:when test="${book.stock < 10}">
                                                        <span class="badge badge-warning-modern badge-modern">${book.stock}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-success-modern badge-modern">${book.stock}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <c:set var="soldCount" value="${soldCountMap[book.BId]}" />
                                                <c:if test="${empty soldCount}">
                                                    <c:set var="soldCount" value="0" />
                                                </c:if>
                                                <span class="badge badge-info-modern badge-modern">${soldCount}</span>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${book.stock == 0}">
                                                        <span class="badge badge-danger-modern badge-modern">Hết hàng</span>
                                                    </c:when>
                                                    <c:when test="${book.stock < 10}">
                                                        <span class="badge badge-warning-modern badge-modern">Sắp hết</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-success-modern badge-modern">Còn hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <a href="book-management?action=view&bookId=${book.BId}" 
                                                   class="btn btn-info btn-action" title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="book-management?action=edit&bookId=${book.BId}" 
                                                   class="btn btn-warning btn-action" title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <c:set var="soldCount" value="${soldCountMap[book.BId]}" />
                                                <c:if test="${empty soldCount}">
                                                    <c:set var="soldCount" value="0" />
                                                </c:if>
                                                <c:if test="${soldCount == 0}">
                                                    <form action="book-management" method="post" style="display:inline;" 
                                                          onsubmit="return confirm('Bạn có chắc chắn muốn xóa sách này?');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="bookId" value="${book.BId}">
                                                        <button type="submit" class="btn btn-danger btn-action" title="Xóa">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-modern">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="book-management?page=${currentPage - 1}&search=${param.search}">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="book-management?page=${i}&search=${param.search}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="book-management?page=${currentPage + 1}&search=${param.search}">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </main>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Auto submit search on Enter -->
        <script>
            document.querySelector('.search-box input').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    this.closest('form').submit();
                }
            });
        </script>
    </body>
</html>
