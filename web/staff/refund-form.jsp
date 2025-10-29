<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Tạo yêu cầu hoàn tiền - Staff Dashboard</title>
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
                margin-bottom: 8px;
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
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
            }
            .btn-group .btn {
                margin-right: 10px;
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
                                <h3 class="text-center">Tạo yêu cầu hoàn tiền</h3>
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
                                <a href="staff-dashboard?action=categories">Quản lý danh mục</a>
                                <a href="staff-dashboard?action=orders">Quản lý đơn hàng</a>
                                <a href="staff-dashboard?action=refunds" class="active">Quản lý hoàn tiền</a>
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
                            <h4>Tạo yêu cầu hoàn tiền cho đơn hàng #${order.id}</h4>
                            <a href="staff-dashboard?action=viewOrder&orderId=${order.id}" class="btn btn-secondary btn-sm">
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

                        <!-- Order Information -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h6><strong>Thông tin đơn hàng:</strong></h6>
                                <p><strong>ID đơn hàng:</strong> #${order.id}</p>
                                <p><strong>Khách hàng:</strong> ${order.customerName}</p>
                                <p><strong>Email:</strong> ${order.customerEmail}</p>
                                <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.total_amount}" type="currency" currencySymbol="VND"/></p>
                            </div>
                            <div class="col-md-6">
                                <h6><strong>Thông tin hoàn tiền:</strong></h6>
                                <p><strong>Ngày tạo đơn:</strong> <fmt:formatDate value="${order.create_date}" pattern="dd/MM/yyyy HH:mm"/></p>
                                <p><strong>Trạng thái hiện tại:</strong> ${order.statusName}</p>
                            </div>
                        </div>

                        <!-- Refund Form -->
                        <form method="post" action="staff-dashboard">
                            <input type="hidden" name="action" value="createRefund">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <input type="hidden" name="userId" value="${order.u_id}">
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="amount">Số tiền hoàn (VND):</label>
                                        <input type="number" class="form-control" id="amount" name="amount" 
                                               value="${order.total_amount}" min="0" max="${order.total_amount}" 
                                               step="1000" required>
                                        <small class="text-muted">Tối đa: <fmt:formatNumber value="${order.total_amount}" type="currency" currencySymbol="VND"/></small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="reason">Lý do hoàn tiền:</label>
                                        <select class="form-control" id="reason" name="reason" required>
                                            <option value="">-- Chọn lý do --</option>
                                            <option value="Sản phẩm bị lỗi">Sản phẩm bị lỗi</option>
                                            <option value="Không hài lòng với chất lượng">Không hài lòng với chất lượng</option>
                                            <option value="Giao hàng chậm">Giao hàng chậm</option>
                                            <option value="Sản phẩm không đúng mô tả">Sản phẩm không đúng mô tả</option>
                                            <option value="Khách hàng thay đổi ý định">Khách hàng thay đổi ý định</option>
                                            <option value="Lỗi hệ thống">Lỗi hệ thống</option>
                                            <option value="Khác">Khác</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="notes">Ghi chú thêm (tùy chọn):</label>
                                <textarea class="form-control" id="notes" name="notes" rows="3" 
                                          placeholder="Nhập ghi chú bổ sung về lý do hoàn tiền..."></textarea>
                            </div>

                            <div class="btn-group">
                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-undo"></i> Tạo yêu cầu hoàn tiền
                                </button>
                                <a href="staff-dashboard?action=viewOrder&orderId=${order.id}" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/main.js"></script>
    </body>
</html>
