<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Quản lý người dùng - Staff Dashboard</title>
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
                                <h3 class="text-center">Quản lý người dùng</h3>
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
                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${totalUsers}</div>
                                <div class="stat-label">Tổng người dùng</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${verifiedUsers}</div>
                                <div class="stat-label">Đã xác thực</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${unverifiedUsers}</div>
                                <div class="stat-label">Chưa xác thực</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="dashboard-card stat-card">
                                <div class="stat-number">${newUsersToday}</div>
                                <div class="stat-label">Mới hôm nay</div>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4>Danh sách người dùng</h4>
                            <div>
                                <a href="staff-dashboard?action=addUser" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Thêm người dùng
                                </a>
                            </div>
                        </div>

                        <!-- Search and Filter -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <form method="get" action="staff-dashboard" class="d-flex">
                                    <input type="hidden" name="action" value="users">
                                    <input type="text" name="search" class="form-control me-2" 
                                           placeholder="Tìm kiếm theo tên, email..." 
                                           value="${param.search}">
                                    <button type="submit" class="btn btn-outline-primary">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </form>
                            </div>
                            <div class="col-md-3">
                                <form method="get" action="staff-dashboard" class="d-flex">
                                    <input type="hidden" name="action" value="users">
                                    <input type="hidden" name="search" value="${param.search}">
                                    <select name="role" class="form-select me-2" onchange="this.form.submit()">
                                        <option value="">Tất cả quyền</option>
                                        <option value="1" ${param.role == '1' ? 'selected' : ''}>Admin</option>
                                        <option value="2" ${param.role == '2' ? 'selected' : ''}>User</option>
                                        <option value="3" ${param.role == '3' ? 'selected' : ''}>Staff</option>
                                        <option value="4" ${param.role == '4' ? 'selected' : ''}>Shipper</option>
                                    </select>
                                </form>
                            </div>
                            <div class="col-md-3">
                                <form method="get" action="staff-dashboard" class="d-flex">
                                    <input type="hidden" name="action" value="users">
                                    <input type="hidden" name="search" value="${param.search}">
                                    <input type="hidden" name="role" value="${param.role}">
                                    <select name="status" class="form-select me-2" onchange="this.form.submit()">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="verified" ${param.status == 'verified' ? 'selected' : ''}>Đã xác thực</option>
                                        <option value="unverified" ${param.status == 'unverified' ? 'selected' : ''}>Chưa xác thực</option>
                                    </select>
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
                                        <th>Email</th>
                                        <th class="name-column">Họ tên</th>
                                        <th>Ngày sinh</th>
                                        <th>Quyền</th>
                                        <th>Trạng thái</th>
                                        <th>Mã xác thực</th>
                                        <th>Ngày tạo</th>
                                        <th class="action-column">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>${user.u_id}</td>
                                            <td>${user.u_email}</td>
                                            <td class="name-column">${user.l_name} ${user.f_name}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.dob}">
                                                        <fmt:formatDate value="${user.dob}" pattern="dd/MM/yyyy" type="date"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Chưa cập nhật</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
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
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.is_verified}">
                                                        <span class="badge badge-success">Đã xác thực</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-warning">Chưa xác thực</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.verification_code}">
                                                        <code>${user.verification_code}</code>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.create_date}">
                                                        <fmt:formatDate value="${user.create_date}" pattern="dd/MM/yyyy HH:mm" type="both"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="action-column">
                                                <div class="btn-group" role="group">
                                                    <!-- View Detail Button -->
                                                    <a href="staff-dashboard?action=viewUser&userId=${user.u_id}" class="btn btn-sm btn-info" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    
                                                    <!-- Edit Button -->
                                                    <c:choose>
                                                        <c:when test="${sessionScope.account.permission_id == 1}">
                                                            <!-- Admin có thể chỉnh sửa tất cả trừ Admin khác -->
                                                            <c:if test="${user.permission_id != 1}">
                                                                <a href="staff-dashboard?action=editUser&userId=${user.u_id}" class="btn btn-sm btn-primary" title="Chỉnh sửa">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                            </c:if>
                                                        </c:when>
                                                        <c:when test="${sessionScope.account.permission_id == 3}">
                                                            <!-- Staff có thể chỉnh sửa User và Shipper -->
                                                            <c:if test="${user.permission_id == 2 || user.permission_id == 4}">
                                                                <a href="staff-dashboard?action=editUser&userId=${user.u_id}" class="btn btn-sm btn-primary" title="Chỉnh sửa">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                            </c:if>
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                    <!-- Verification Button -->
                                                    <c:choose>
                                                        <c:when test="${sessionScope.account.permission_id == 1}">
                                                            <!-- Admin có thể xác thực tất cả trừ Admin khác -->
                                                            <c:if test="${user.permission_id != 1}">
                                                                <form method="post" action="staff-dashboard" style="display: inline;">
                                                                    <input type="hidden" name="action" value="updateUserStatus">
                                                                    <input type="hidden" name="userId" value="${user.u_id}">
                                                                    <input type="hidden" name="isVerified" value="${!user.is_verified}">
                                                                    <button type="submit" class="btn btn-sm ${user.is_verified ? 'btn-warning' : 'btn-success'}" title="${user.is_verified ? 'Hủy xác thực' : 'Xác thực'}">
                                                                        <i class="fas fa-${user.is_verified ? 'times' : 'check'}"></i>
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </c:when>
                                                        <c:when test="${sessionScope.account.permission_id == 3}">
                                                            <!-- Staff có thể xác thực User thông thường và Shipper -->
                                                            <c:if test="${user.permission_id == 2 || user.permission_id == 4}">
                                                                <form method="post" action="staff-dashboard" style="display: inline;">
                                                                    <input type="hidden" name="action" value="updateUserStatus">
                                                                    <input type="hidden" name="userId" value="${user.u_id}">
                                                                    <input type="hidden" name="isVerified" value="${!user.is_verified}">
                                                                    <button type="submit" class="btn btn-sm ${user.is_verified ? 'btn-warning' : 'btn-success'}" title="${user.is_verified ? 'Hủy xác thực' : 'Xác thực'}">
                                                                        <i class="fas fa-${user.is_verified ? 'times' : 'check'}"></i>
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                    <!-- Delete Button (chỉ Admin mới có quyền xóa) -->
                                                    <c:if test="${sessionScope.account.permission_id == 1 && user.permission_id != 1}">
                                                        <form method="post" action="staff-dashboard" style="display: inline;" 
                                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                                                            <input type="hidden" name="action" value="deleteUser">
                                                            <input type="hidden" name="userId" value="${user.u_id}">
                                                            <button type="submit" class="btn btn-sm btn-danger" title="Xóa">
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
                                            <a class="page-link" href="staff-dashboard?action=users&page=${currentPage - 1}&search=${param.search}&role=${param.role}&status=${param.status}">Trước</a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="staff-dashboard?action=users&page=${i}&search=${param.search}&role=${param.role}&status=${param.status}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="staff-dashboard?action=users&page=${currentPage + 1}&search=${param.search}&role=${param.role}&status=${param.status}">Sau</a>
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
