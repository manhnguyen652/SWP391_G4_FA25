<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>${author == null ? 'Thêm tác giả' : 'Chỉnh sửa tác giả'} - Staff Dashboard</title>
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
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px 15px;
                font-size: 14px;
                transition: all 0.3s;
            }
            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
            }
            .btn-group .btn {
                margin-right: 10px;
            }
            .btn-group .btn:last-child {
                margin-right: 0;
            }
            .author-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .stat-card {
                text-align: center;
                padding: 15px;
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
                font-size: 1.8rem;
                font-weight: bold;
                margin-bottom: 5px;
                color: #333;
            }
            .stat-label {
                font-size: 0.8rem;
                color: #666;
                font-weight: 500;
            }
            .stat-card.primary .stat-number { color: #007bff; }
            .stat-card.info .stat-number { color: #17a2b8; }
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
                                <h3 class="text-center">${author == null ? 'Thêm tác giả' : 'Chỉnh sửa tác giả'}</h3>
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

                    <div class="row">
                        <!-- Form -->
                        <div class="col-lg-8">
                            <div class="dashboard-card">
                                <h4 class="mb-4">${author == null ? 'Thông tin tác giả mới' : 'Chỉnh sửa thông tin tác giả'}</h4>
                                
                                <form action="staff-dashboard" method="post">
                                    <input type="hidden" name="action" value="${author == null ? 'addAuthor' : 'updateAuthor'}">
                                    <c:if test="${author != null}">
                                        <input type="hidden" name="authorId" value="${author.id}">
                                    </c:if>
                                    
                                    <div class="form-group">
                                        <label for="name" class="form-label">Tên tác giả <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="${author.name}" required 
                                               placeholder="Nhập tên tác giả">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="bio" class="form-label">Tiểu sử</label>
                                        <textarea class="form-control" id="bio" name="bio" rows="5" 
                                                  placeholder="Nhập tiểu sử tác giả">${author.bio}</textarea>
                                    </div>
                                    
                                    <div class="btn-group">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> ${author == null ? 'Thêm tác giả' : 'Cập nhật'}
                                        </button>
                                        <a href="staff-dashboard?action=authors" class="btn btn-secondary">
                                            <i class="fas fa-times"></i> Hủy
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Author Info (if editing) -->
                        <c:if test="${author != null}">
                            <div class="col-lg-4">
                                <div class="dashboard-card">
                                    <h5 class="mb-3">Thông tin hiện tại</h5>
                                    
                                    <div class="author-info">
                                        <div class="form-group">
                                            <label class="form-label">ID Tác giả</label>
                                            <div class="form-control-plaintext">${author.id}</div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="form-label">Tên tác giả</label>
                                            <div class="form-control-plaintext">${author.name}</div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="form-label">Tiểu sử</label>
                                            <div class="form-control-plaintext">
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
                                    </div>

                                    <!-- Statistics -->
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="stat-card primary">
                                                <div class="stat-number">${author.id}</div>
                                                <div class="stat-label">ID</div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="stat-card info">
                                                <div class="stat-number">${bookCount}</div>
                                                <div class="stat-label">Sách</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Quick Actions -->
                                    <div class="mt-3">
                                        <a href="staff-dashboard?action=viewAuthor&authorId=${author.id}" 
                                           class="btn btn-info btn-sm btn-block">
                                            <i class="fas fa-eye"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
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
