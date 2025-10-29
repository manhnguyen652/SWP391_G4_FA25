<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Chi tiết sách - Staff Dashboard</title>
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
            .book-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .book-title {
                font-size: 2rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            .book-description {
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
                                <h3 class="text-center">Chi tiết sách</h3>
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
                    <!-- Back Button -->
                    <div class="row mb-3">
                        <div class="col-12">
                            <a href="staff-dashboard?action=books" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
                            </a>
                        </div>
                    </div>

                    <!-- Book Information -->
                    <div class="dashboard-card">
                        <div class="book-info">
                            <div class="book-title">${book.BTitle}</div>
                            <div class="book-description">
                                <c:choose>
                                    <c:when test="${not empty book.description}">
                                        ${book.description}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Chưa có mô tả</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Statistics -->
                        <div class="row">
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card primary">
                                    <div class="stat-number">${book.BId}</div>
                                    <div class="stat-label">ID Sách</div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card info">
                                    <div class="stat-number">${book.stock}</div>
                                    <div class="stat-label">Tồn kho</div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card success">
                                    <div class="stat-number">${soldCount}</div>
                                    <div class="stat-label">Đã bán</div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card warning">
                                    <div class="stat-number">
                                        <fmt:formatNumber value="${book.price}" type="currency" currencyCode="VND"/>
                                    </div>
                                    <div class="stat-label">Giá bán</div>
                                </div>
                            </div>
                        </div>

                        <!-- Book Details -->
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h5>Thông tin cơ bản</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Tên sách:</strong></td>
                                        <td>${book.BTitle}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Tác giả:</strong></td>
                                        <td>${book.authorName}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Danh mục:</strong></td>
                                        <td>${book.categoryName}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Nhà xuất bản:</strong></td>
                                        <td>${book.publisherName}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Năm xuất bản:</strong></td>
                                        <td>${book.publicationYear}</td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <h5>Thông tin kinh doanh</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Giá bán:</strong></td>
                                        <td><fmt:formatNumber value="${book.price}" type="currency" currencyCode="VND"/></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Tồn kho:</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${book.stock == 0}">
                                                    <span class="badge badge-danger">Hết hàng</span>
                                                </c:when>
                                                <c:when test="${book.stock < 10}">
                                                    <span class="badge badge-warning">${book.stock} (Sắp hết)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-success">${book.stock}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Đã bán:</strong></td>
                                        <td><span class="badge badge-info">${soldCount}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Trạng thái:</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${book.stock == 0}">
                                                    <span class="badge badge-danger">Hết hàng</span>
                                                </c:when>
                                                <c:when test="${book.stock < 10}">
                                                    <span class="badge badge-warning">Sắp hết hàng</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-success">Còn hàng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="btn-group" role="group">
                                    <a href="staff-dashboard?action=editBook&bookId=${book.BId}" 
                                       class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Chỉnh sửa
                                    </a>
                                    <c:if test="${!isInOrder}">
                                        <form action="staff-dashboard" method="post" style="display:inline;" 
                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa sách này?');">
                                            <input type="hidden" name="action" value="deleteBook">
                                            <input type="hidden" name="bookId" value="${book.BId}">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fas fa-trash"></i> Xóa
                                            </button>
                                        </form>
                                    </c:if>
                                    <a href="staff-dashboard?action=exportBooks" class="btn btn-success">
                                        <i class="fas fa-file-excel"></i> Xuất Excel
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Warning if book is in order -->
                        <c:if test="${isInOrder}">
                            <div class="alert alert-warning mt-3" role="alert">
                                <i class="fas fa-exclamation-triangle"></i>
                                <strong>Lưu ý:</strong> Sách này đang được sử dụng trong đơn hàng, không thể xóa.
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
