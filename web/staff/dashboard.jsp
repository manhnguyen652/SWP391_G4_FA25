<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Dashboard Staff - Thống kê tổng quan</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
        <style>
            .dashboard-card {
                background: #fff;
                border-radius: 20px;
                padding: 30px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                margin-bottom: 30px;
                border: 1px solid #e9ecef;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            
            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            }
            
            .dashboard-nav {
                background: #f8f9fa;
                padding: 15px 0;
                margin-bottom: 20px;
                border-bottom: 1px solid #e9ecef;
            }
            
            .dashboard-nav a {
                color: #666;
                text-decoration: none;
                padding: 10px 20px;
                margin: 0 5px;
                border-radius: 5px;
                transition: all 0.3s ease;
                font-weight: 500;
            }
            
            .dashboard-nav a:hover, .dashboard-nav a.active {
                background: #007bff;
                color: white;
            }
            
            .stat-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-align: center;
                padding: 35px 25px;
                border-radius: 20px;
                margin-bottom: 30px;
                box-shadow: 0 15px 35px rgba(102, 126, 234, 0.3);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }
            
            .stat-card::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
                transform: rotate(45deg);
                transition: all 0.5s;
                opacity: 0;
            }
            
            .stat-card:hover::before {
                opacity: 1;
                animation: shimmer 2s infinite;
            }
            
            @keyframes shimmer {
                0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
                100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
            }
            
            .stat-card:hover {
                transform: translateY(-8px) scale(1.02);
                box-shadow: 0 25px 50px rgba(102, 126, 234, 0.4);
            }
            
            .stat-card .icon {
                font-size: 3.5rem;
                margin-bottom: 20px;
                opacity: 0.9;
            }
            
            .stat-card .number {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 15px;
                text-shadow: 0 3px 6px rgba(0,0,0,0.3);
            }
            
            .stat-card .label {
                font-size: 1.2rem;
                opacity: 0.9;
                font-weight: 500;
            }
            
            .stat-card .change {
                font-size: 0.9rem;
                margin-top: 10px;
                padding: 5px 15px;
                border-radius: 15px;
                background: rgba(255,255,255,0.2);
                display: inline-block;
            }
            
            .stat-card.success {
                background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                box-shadow: 0 15px 35px rgba(17, 153, 142, 0.3);
            }
            
            .stat-card.warning {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                box-shadow: 0 15px 35px rgba(240, 147, 251, 0.3);
            }
            
            .stat-card.info {
                background: linear-gradient(135deg, #ffc107 0%, #ff8c00 100%);
                box-shadow: 0 15px 35px rgba(255, 193, 7, 0.3);
            }
            
            .stat-card.danger {
                background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
                box-shadow: 0 15px 35px rgba(255, 107, 107, 0.3);
            }
            
            .chart-container {
                position: relative;
                height: 400px;
                margin: 25px 0;
            }
            
            .chart-container.small {
                height: 300px;
            }
            
            .chart-container.large {
                height: 500px;
            }
            
            .chart-title {
                font-size: 1.6rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 25px;
                text-align: center;
                position: relative;
                padding-bottom: 15px;
            }
            
            .chart-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 2px;
            }
            
            .metric-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            
            .metric-card {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                border-left: 4px solid #667eea;
                transition: transform 0.3s ease;
            }
            
            .metric-card:hover {
                transform: translateY(-3px);
            }
            
            .metric-card h4 {
                color: #667eea;
                font-size: 1.1rem;
                margin-bottom: 10px;
                font-weight: 600;
            }
            
            .metric-card .value {
                font-size: 2rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
            }
            
            .metric-card .subtitle {
                color: #666;
                font-size: 0.9rem;
            }
            
            .recent-orders-table {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }
            
            .recent-orders-table table {
                margin: 0;
            }
            
            .recent-orders-table th {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 15px;
                font-weight: 600;
            }
            
            .recent-orders-table td {
                padding: 15px;
                border-bottom: 1px solid #f8f9fa;
                vertical-align: middle;
            }
            
            .recent-orders-table tbody tr:hover {
                background: #f8f9fa;
                transition: background 0.3s ease;
            }
            
            .status-badge {
                padding: 8px 15px;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .status-pending { background: #fff3cd; color: #856404; }
            .status-confirmed { background: #d4edda; color: #155724; }
            .status-shipping { background: #cce5ff; color: #004085; }
            .status-completed { background: #d1ecf1; color: #0c5460; }
            .status-cancelled { background: #f8d7da; color: #721c24; }
            
            .top-selling-book {
                display: flex;
                align-items: center;
                padding: 15px;
                background: #f8f9fa;
                border-radius: 10px;
                margin-bottom: 10px;
                transition: transform 0.3s ease;
            }
            
            .top-selling-book:hover {
                transform: translateX(5px);
                background: #e9ecef;
            }
            
            .book-rank {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                width: 30px;
                height: 30px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                margin-right: 15px;
            }
            
            .book-info h6 {
                margin: 0;
                font-weight: 600;
                color: #333;
            }
            
            .book-info small {
                color: #6c757d;
            }
            
            .tab-container {
                background: white;
                border-radius: 15px;
                padding: 0;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                overflow: hidden;
            }
            
            .tab-nav {
                display: flex;
                background: #f8f9fa;
                border-bottom: 1px solid #e9ecef;
            }
            
            .tab-nav button {
                flex: 1;
                padding: 15px 20px;
                border: none;
                background: none;
                cursor: pointer;
                font-weight: 600;
                color: #666;
                transition: all 0.3s ease;
            }
            
            .tab-nav button.active {
                background: white;
                color: #667eea;
                border-bottom: 3px solid #667eea;
            }
            
            .tab-content {
                padding: 30px;
                min-height: 400px;
            }
            
            .tab-pane {
                display: none;
            }
            
            .tab-pane.active {
                display: block;
            }
            
            .refresh-btn {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                font-size: 1.5rem;
                cursor: pointer;
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                transition: all 0.3s ease;
                z-index: 1000;
            }
            
            .refresh-btn:hover {
                transform: scale(1.1);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
            }
            
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255,255,255,0.9);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
                backdrop-filter: blur(5px);
            }
            
            .loading-spinner {
                width: 60px;
                height: 60px;
                border: 4px solid #f3f3f3;
                border-top: 4px solid #667eea;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }
            
            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
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
                                <h3 class="text-center">Dashboard Staff</h3>
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
                    <a href="staff-dashboard" class="${param.action == null ? 'active' : ''}">Tổng quan</a>
                    <a href="staff-dashboard?action=users" class="${param.action == 'users' ? 'active' : ''}">Quản lý người dùng</a>
                    <a href="staff-dashboard?action=books" class="${param.action == 'books' ? 'active' : ''}">Quản lý sách</a>
                    <a href="staff-dashboard?action=authors" class="${param.action == 'authors' ? 'active' : ''}">Quản lý tác giả</a>
                    <a href="staff-dashboard?action=categories" class="${param.action == 'categories' ? 'active' : ''}">Quản lý danh mục</a>
                    <a href="staff-dashboard?action=orders" class="${param.action == 'orders' ? 'active' : ''}">Quản lý đơn hàng</a>
                    <a href="staff-dashboard?action=refunds" class="${param.action == 'refunds' ? 'active' : ''}">Quản lý hoàn tiền</a>
                </nav>
            </div>
        </div>
    </div>
</div>

            <!-- Main Content -->
            <main class="inner-page-sec-padding-bottom">
                <div class="container">
                    <!-- Statistics Cards -->
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card">
                                <div class="stat-icon"><i class="fas fa-users"></i></div>
                                <div class="stat-number" id="totalUsers">${totalUsers}</div>
                                <div class="stat-label">Tổng người dùng</div>
                                <div class="change">+12% so với tháng trước</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card success">
                                <div class="stat-icon"><i class="fas fa-book"></i></div>
                                <div class="stat-number" id="totalBooks">${totalBooks}</div>
                                <div class="stat-label">Tổng sách</div>
                                <div class="change">+8% so với tháng trước</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card warning">
                                <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
                                <div class="stat-number" id="totalOrders">${totalOrders}</div>
                                <div class="stat-label">Tổng đơn hàng</div>
                                <div class="change">+25% so với tháng trước</div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card info">
                                <div class="stat-icon"><i class="fas fa-dollar-sign"></i></div>
                                <div class="stat-number"><fmt:formatNumber value="${totalRevenue}" type="currency" currencyCode="VND"/></div>
                                <div class="stat-label">Tổng doanh thu</div>
                                <div class="change">+18% so với tháng trước</div>
                            </div>
                        </div>
                    </div>

                    <!-- Charts Row 1 -->
                    <div class="row">
                        <!-- Revenue Chart -->
                        <div class="col-lg-8">
                            <div class="dashboard-card">
                                <h3 class="chart-title">Doanh thu theo tháng</h3>
                                <div class="chart-container large">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Status Chart -->
                        <div class="col-lg-4">
                            <div class="dashboard-card">
                                <h3 class="chart-title">Trạng thái đơn hàng</h3>
                                <div class="chart-container">
                                    <canvas id="orderStatusChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Charts Row 2 -->
                    <div class="row">
                        <!-- Category Performance -->
                        <div class="col-lg-6">
                            <div class="dashboard-card">
                                <h3 class="chart-title">Hiệu suất theo danh mục</h3>
                                <div class="chart-container">
                                    <canvas id="categoryChart"></canvas>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Sales Trend -->
                        <div class="col-lg-6">
                            <div class="dashboard-card">
                                <h3 class="chart-title">Xu hướng bán hàng</h3>
                                <div class="chart-container">
                                    <canvas id="salesTrendChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Detailed Statistics -->
                    <div class="row">
                        <div class="col-12">
                            <div class="dashboard-card">
                                <h3 class="chart-title">Thống kê chi tiết</h3>
                                <div class="tab-container">
                                    <div class="tab-nav">
                                        <button class="tab-btn active" onclick="showTab('overview')">Tổng quan</button>
                                        <button class="tab-btn" onclick="showTab('users')">Người dùng</button>
                                        <button class="tab-btn" onclick="showTab('books')">Sách</button>
                                        <button class="tab-btn" onclick="showTab('orders')">Đơn hàng</button>
                                    </div>
                                    <div class="tab-content">
                                        <div id="overview" class="tab-pane active">
                                            <div class="metric-grid">
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-chart-line"></i> Tăng trưởng doanh thu</h4>
                                                    <div class="value">+18.5%</div>
                                                    <div class="subtitle">So với tháng trước</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-shopping-bag"></i> Đơn hàng trung bình</h4>
                                                    <div class="value">245,000 VNĐ</div>
                                                    <div class="subtitle">Giá trị trung bình mỗi đơn</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-users"></i> Khách hàng mới</h4>
                                                    <div class="value">127</div>
                                                    <div class="subtitle">Tháng này</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-book"></i> Sách bán chạy</h4>
                                                    <div class="value">45</div>
                                                    <div class="subtitle">Sách có doanh số cao</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="users" class="tab-pane">
                                            <div class="metric-grid">
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-user-check"></i> Người dùng đã xác thực</h4>
                                                    <div class="value" id="verifiedUsers">-</div>
                                                    <div class="subtitle">Tổng số tài khoản đã xác thực</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-user-plus"></i> Người dùng mới hôm nay</h4>
                                                    <div class="value" id="newUsersToday">-</div>
                                                    <div class="subtitle">Đăng ký mới trong ngày</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-percentage"></i> Tỷ lệ xác thực</h4>
                                                    <div class="value">92.5%</div>
                                                    <div class="subtitle">Tỷ lệ tài khoản đã xác thực</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-clock"></i> Hoạt động trung bình</h4>
                                                    <div class="value">4.2h</div>
                                                    <div class="subtitle">Thời gian online trung bình</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="books" class="tab-pane">
                                            <div class="metric-grid">
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-exclamation-triangle"></i> Sách sắp hết hàng</h4>
                                                    <div class="value" id="lowStockBooks">-</div>
                                                    <div class="subtitle">Sách có tồn kho < 10</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-times-circle"></i> Sách hết hàng</h4>
                                                    <div class="value" id="outOfStockBooks">-</div>
                                                    <div class="subtitle">Sách có tồn kho = 0</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-star"></i> Sách được yêu thích</h4>
                                                    <div class="value">23</div>
                                                    <div class="subtitle">Sách có đánh giá cao</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-tags"></i> Danh mục phổ biến</h4>
                                                    <div class="value">Văn học</div>
                                                    <div class="subtitle">Danh mục bán chạy nhất</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="orders" class="tab-pane">
                                            <div class="metric-grid">
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-hourglass-half"></i> Đơn hàng chờ xử lý</h4>
                                                    <div class="value" id="pendingOrders">-</div>
                                                    <div class="subtitle">Đơn hàng cần xử lý</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-truck"></i> Đơn hàng đang giao</h4>
                                                    <div class="value" id="shippingOrders">-</div>
                                                    <div class="subtitle">Đơn hàng đang vận chuyển</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-check-circle"></i> Đơn hàng hoàn thành</h4>
                                                    <div class="value" id="completedOrders">-</div>
                                                    <div class="subtitle">Đơn hàng đã giao thành công</div>
                                                </div>
                                                <div class="metric-card">
                                                    <h4><i class="fas fa-clock"></i> Thời gian xử lý TB</h4>
                                                    <div class="value">2.3 ngày</div>
                                                    <div class="subtitle">Thời gian xử lý trung bình</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Top Selling Books & Recent Orders -->
                    <div class="row">
                        <!-- Top Selling Books -->
                        <div class="col-lg-6">
                            <div class="dashboard-card">
                                <h3 class="chart-title">Sách bán chạy nhất</h3>
                                <div id="topSellingBooks">
                                    <c:forEach var="book" items="${topSellingBooks}" varStatus="loop">
                                        <div class="top-selling-book">
                                            <div class="book-rank">${loop.index + 1}</div>
                                            <div class="book-info">
                                                <h6>${book.BTitle}</h6>
                                                <small>Tác giả: ${book.authorName}</small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty topSellingBooks}">
                                        <div class="text-center text-muted py-4">
                                            <i class="fas fa-book fa-3x mb-3"></i>
                                            <p>Chưa có dữ liệu sách bán chạy</p>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Recent Orders -->
                        <div class="col-lg-6">
                            <div class="dashboard-card">
                                <h3 class="chart-title">Đơn hàng gần đây</h3>
                                <div class="recent-orders-table">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Khách hàng</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${recentOrders}">
                                                <tr>
                                                    <td>#${order.id}</td>
                                                    <td>${order.customerName}</td>
                                                    <td><fmt:formatNumber value="${order.total_amount}" type="currency" currencyCode="VND"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.status_id == 1}">
                                                                <span class="status-badge status-pending">Chờ xử lý</span>
                                                            </c:when>
                                                            <c:when test="${order.status_id == 2}">
                                                                <span class="status-badge status-confirmed">Đã xác nhận</span>
                                                            </c:when>
                                                            <c:when test="${order.status_id == 3}">
                                                                <span class="status-badge status-shipping">Đang giao</span>
                                                            </c:when>
                                                            <c:when test="${order.status_id == 4}">
                                                                <span class="status-badge status-completed">Hoàn thành</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge status-cancelled">Đã hủy</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty recentOrders}">
                                                <tr>
                                                    <td colspan="4" class="text-center text-muted py-4">
                                                        <i class="fas fa-shopping-cart fa-3x mb-3"></i>
                                                        <p>Chưa có đơn hàng nào</p>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Refresh Button -->
        <button class="refresh-btn" onclick="refreshData()" title="Làm mới dữ liệu">
            <i class="fas fa-sync-alt"></i>
        </button>

        <!-- Loading Overlay -->
        <div id="loadingOverlay" class="loading-overlay" style="display: none;">
            <div class="loading-spinner"></div>
        </div>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
        
        <script>
            // Chart.js configuration
            Chart.defaults.font.family = "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif";
            Chart.defaults.color = '#666';
            
            let charts = {};
            
            // Initialize all charts
            function initializeCharts() {
                // Revenue Chart
                const revenueCtx = document.getElementById('revenueChart').getContext('2d');
                charts.revenue = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: [12000000, 19000000, 15000000, 25000000, 22000000, 30000000, 28000000, 35000000, 32000000, 40000000, 38000000, 45000000],
                        borderColor: 'rgb(102, 126, 234)',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: 'rgb(102, 126, 234)',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 6,
                        pointHoverRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN', {
                                        style: 'currency',
                                        currency: 'VND'
                                    }).format(value);
                                }
                            },
                            grid: {
                                color: 'rgba(0,0,0,0.1)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    },
                    elements: {
                        point: {
                            hoverBackgroundColor: 'rgb(102, 126, 234)'
                        }
                    }
                }
            });
            
                // Order Status Chart
                const orderStatusCtx = document.getElementById('orderStatusChart').getContext('2d');
                charts.orderStatus = new Chart(orderStatusCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Chờ xử lý', 'Đã xác nhận', 'Đang giao', 'Hoàn thành', 'Đã hủy'],
                    datasets: [{
                        data: [12, 19, 8, 45, 6],
                        backgroundColor: [
                            '#fff3cd',
                            '#d4edda',
                            '#cce5ff',
                            '#d1ecf1',
                            '#f8d7da'
                        ],
                        borderColor: [
                            '#856404',
                            '#155724',
                            '#004085',
                            '#0c5460',
                            '#721c24'
                        ],
                        borderWidth: 2,
                        hoverOffset: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                padding: 20,
                                usePointStyle: true,
                                font: {
                                    size: 12
                                }
                            }
                        }
                    }
                }
            });
                
                // Category Chart
                const categoryCtx = document.getElementById('categoryChart').getContext('2d');
                charts.category = new Chart(categoryCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Văn học', 'Khoa học', 'Lịch sử', 'Nghệ thuật', 'Thể thao'],
                        datasets: [{
                            label: 'Số sách',
                            data: [45, 32, 28, 19, 15],
                            backgroundColor: [
                                'rgba(102, 126, 234, 0.8)',
                                'rgba(17, 153, 142, 0.8)',
                                'rgba(240, 147, 251, 0.8)',
                                'rgba(255, 193, 7, 0.8)',
                                'rgba(255, 107, 107, 0.8)'
                            ],
                            borderColor: [
                                'rgb(102, 126, 234)',
                                'rgb(17, 153, 142)',
                                'rgb(240, 147, 251)',
                                'rgb(255, 193, 7)',
                                'rgb(255, 107, 107)'
                            ],
                            borderWidth: 2,
                            borderRadius: 8,
                            borderSkipped: false,
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(0,0,0,0.1)'
                                }
                            },
                            x: {
                                grid: {
                                    display: false
                                }
                            }
                        }
                    }
                });
                
                // Sales Trend Chart
                const salesTrendCtx = document.getElementById('salesTrendChart').getContext('2d');
                charts.salesTrend = new Chart(salesTrendCtx, {
                    type: 'radar',
                    data: {
                        labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật'],
                        datasets: [{
                            label: 'Doanh số',
                            data: [65, 59, 80, 81, 56, 85, 40],
                            borderColor: 'rgb(102, 126, 234)',
                            backgroundColor: 'rgba(102, 126, 234, 0.2)',
                            borderWidth: 3,
                            pointBackgroundColor: 'rgb(102, 126, 234)',
                            pointBorderColor: '#fff',
                            pointBorderWidth: 2,
                            pointRadius: 6
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            r: {
                                beginAtZero: true,
                                max: 100,
                                grid: {
                                    color: 'rgba(0,0,0,0.1)'
                                }
                            }
                        }
                    }
                });
            }
            
            // Animate numbers on page load
            function animateValue(element, start, end, duration) {
                let startTimestamp = null;
                const step = (timestamp) => {
                    if (!startTimestamp) startTimestamp = timestamp;
                    const progress = Math.min((timestamp - startTimestamp) / duration, 1);
                    const current = Math.floor(progress * (end - start) + start);
                    element.textContent = current.toLocaleString('vi-VN');
                    if (progress < 1) {
                        window.requestAnimationFrame(step);
                    }
                };
                window.requestAnimationFrame(step);
            }
            
            // Initialize everything when page loads
            document.addEventListener('DOMContentLoaded', function() {
                initializeCharts();
                loadDataFromAPI();
                
                // Animate stat numbers
                const statNumbers = document.querySelectorAll('.stat-number');
                statNumbers.forEach((element, index) => {
                    const finalValue = parseInt(element.textContent.replace(/[^\d]/g, ''));
                    if (!isNaN(finalValue)) {
                        element.textContent = '0';
                        setTimeout(() => {
                            animateValue(element, 0, finalValue, 2000);
                        }, index * 200);
                    }
                });
            });
            
            // Tab functionality
            function showTab(tabName) {
                // Hide all tab panes
                document.querySelectorAll('.tab-pane').forEach(pane => {
                    pane.classList.remove('active');
                });
                
                // Remove active class from all tab buttons
                document.querySelectorAll('.tab-btn').forEach(btn => {
                    btn.classList.remove('active');
                });
                
                // Show selected tab pane
                document.getElementById(tabName).classList.add('active');
                
                // Add active class to clicked button
                event.target.classList.add('active');
            }
            
            // Loading functions
            function showLoading() {
                document.getElementById('loadingOverlay').style.display = 'flex';
            }
            
            function hideLoading() {
                document.getElementById('loadingOverlay').style.display = 'none';
            }
            
            // Refresh data
            function refreshData() {
                showLoading();
                
                // Animate refresh button
                const refreshBtn = document.querySelector('.refresh-btn');
                refreshBtn.style.transform = 'rotate(360deg)';
                
                setTimeout(() => {
                    refreshBtn.style.transform = 'rotate(0deg)';
                    hideLoading();
                    
                    // Show success message
                    showNotification('Dữ liệu đã được làm mới!', 'success');
                }, 2000);
            }
            
            // Notification function
            function showNotification(message, type = 'info') {
                const notification = document.createElement('div');
                notification.className = `alert alert-${type} alert-dismissible fade show`;
                notification.style.position = 'fixed';
                notification.style.top = '20px';
                notification.style.right = '20px';
                notification.style.zIndex = '10000';
                notification.innerHTML = `
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                `;
                
                document.body.appendChild(notification);
                
                setTimeout(() => {
                    notification.remove();
                }, 3000);
            }
            
            // Load data from API
            async function loadDataFromAPI() {
                try {
                    // Load order status data
                    const orderStatusResponse = await fetch('statistics-api?action=orderStatus');
                    const orderStatusData = await orderStatusResponse.json();
                    
                    if (charts && charts.orderStatus) {
                        charts.orderStatus.data.data = orderStatusData.data;
                        charts.orderStatus.update();
                    }
                    
                    // Load user stats
                    const userStatsResponse = await fetch('statistics-api?action=userStats');
                    const userStatsData = await userStatsResponse.json();
                    
                    const verifiedUsersEl = document.getElementById('verifiedUsers');
                    const newUsersTodayEl = document.getElementById('newUsersToday');
                    if (verifiedUsersEl) verifiedUsersEl.textContent = userStatsData.verifiedUsers || '-';
                    if (newUsersTodayEl) newUsersTodayEl.textContent = userStatsData.newUsersToday || '-';
                    
                    // Load book stats
                    const bookStatsResponse = await fetch('statistics-api?action=bookStats');
                    const bookStatsData = await bookStatsResponse.json();
                    
                    const lowStockEl = document.getElementById('lowStockBooks');
                    const outOfStockEl = document.getElementById('outOfStockBooks');
                    if (lowStockEl) lowStockEl.textContent = bookStatsData.lowStockBooks || '-';
                    if (outOfStockEl) outOfStockEl.textContent = bookStatsData.outOfStockBooks || '-';
                    
                    // Load order stats
                    const pendingEl = document.getElementById('pendingOrders');
                    const shippingEl = document.getElementById('shippingOrders');
                    const completedEl = document.getElementById('completedOrders');
                    if (pendingEl) pendingEl.textContent = orderStatusData.data[0] || '-';
                    if (shippingEl) shippingEl.textContent = orderStatusData.data[2] || '-';
                    if (completedEl) completedEl.textContent = orderStatusData.data[3] || '-';
                    
                } catch (error) {
                    console.error('Error loading data:', error);
                    showNotification('Lỗi khi tải dữ liệu từ server', 'danger');
                }
            }
        </script>
    </body>
</html>