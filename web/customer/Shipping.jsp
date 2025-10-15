<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đơn vận chuyển</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Fonts -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            font-family: 'Varela Round', sans-serif;
            background-color: #f7f7f7;
        }
        /* Header */
        .top-header {
            background-color: #1a1a1a;
            color: #fff;
            padding: 8px 0;
            font-size: 14px;
        }
        .top-header a {
            color: #fff;
            margin-left: 10px;
        }
        .main-header {
            background-color: #ffffff;
            border-bottom: 1px solid #e5e5e5;
            padding: 15px 0;
        }
        .main-header .logo {
            font-size: 28px;
            color: #76b82a;
            font-weight: bold;
        }

        /* Sidebar */
        .sidebar {
            background: #fff;
            min-height: 100vh;
            border-right: 1px solid #e5e5e5;
            padding: 20px 0;
        }
        .sidebar h5 {
            padding-left: 20px;
            margin-bottom: 15px;
            color: #76b82a;
        }
        .sidebar ul {
            list-style: none;
            padding-left: 0;
        }
        .sidebar ul li a {
            display: block;
            padding: 10px 20px;
            color: #333;
            text-decoration: none;
        }
        .sidebar ul li a:hover {
            background-color: #f0f0f0;
            color: #76b82a;
        }

        /* Content area */
        .content-wrapper {
            padding: 20px;
        }
        .table-wrapper {
            background: #fff;
            border-radius: 5px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .table-title {
            margin-bottom: 15px;
        }
        .table-title h2 {
            font-size: 22px;
            margin: 0;
        }
        .pagination button {
            margin-right: 5px;
        }
    </style>
</head>
<body>

<!-- 🔸 Top Header -->
<div class="top-header">
    <div class="container d-flex justify-content-between">
        <div>
            <i class="fas fa-headphones-alt"></i> Free Support 24/7: <strong>+01-202-555-0181</strong>
        </div>
        <div>
            <a href="home">Home</a>
            <a href="#">Contact</a>
            <a href="#">My Account</a>
        </div>
    </div>
</div>

<!-- 🔸 Main Header -->
<div class="main-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">Pustok.</div>
        <form class="form-inline" action="search">
            <input class="form-control mr-sm-2" type="search" placeholder="Search entire store" aria-label="Search" style="width: 300px;">
            <button class="btn btn-success" type="submit">Search</button>
        </form>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <!-- 🟩 Sidebar -->
        <div class="col-md-3 col-lg-2 sidebar">
            <h5>Browse Categories</h5>
            <ul>
                <li><a href="#">Arts & Photography</a></li>
                <li><a href="#">Biographies</a></li>
                <li><a href="#">Business & Money</a></li>
                <li><a href="#">Calendars</a></li>
                <li><a href="#">Children's Books</a></li>
                <li><a href="#">Comics</a></li>
                <li><a href="#">Cookbooks</a></li>
                <li><a href="#">More Categories</a></li>
            </ul>
        </div>

        <!-- 🟨 Content -->
        <div class="col-md-9 col-lg-10 content-wrapper">
            <div class="mb-3">
                <a href="home" class="btn btn-primary">Quay về trang chủ</a>
            </div>

            <h5>Tổng thu nhập: ${dao.getIncomeByShipperId(sessionScope.account.accountId)}</h5>
            <h5>Tổng đơn hàng: ${dao.orders.size()}</h5>
            <h5>Tổng đơn hàng đã giao: ${dao.getNumberOfDeliveredByShipperId(sessionScope.account.accountId)}</h5>

            <div class="table-wrapper mt-3">
                <div class="table-title d-flex justify-content-between align-items-center">
                    <h2>Đơn vận chuyển</h2>
                </div>

                <!-- 🔸 Pagination -->
                <form action="shipping" method="post" class="pagination mb-3">
                    <c:forEach var="counter" begin="1" end="${(dao.orders.size() / 15) + (dao.orders.size() % 15 == 0 ? 0 : 1)}">
                        <button type="submit" name="subpageIndex" value="${counter}" 
                                class="btn btn-sm ${clickedSubpageIndex == counter ? 'btn-primary' : 'btn-outline-secondary'}">
                            ${counter}
                        </button>
                    </c:forEach>
                </form>

                <!-- 🔸 Orders Table -->
                <table class="table table-striped table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th>Chi tiết</th>
                            <th>Người mua</th>
                            <th>Ngày đặt</th>
                            <th>Ngày nhận</th>
                            <th>Trạng thái</th>
                            <th>Địa chỉ nhận</th>
                            <th>Đã thanh toán</th>
                            <th>Phí vận chuyển</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${dao.orders}" 
                                   begin="${15 * (clickedSubpageIndex - 1)}" 
                                   end="${15 * clickedSubpageIndex - 1}">
                            <tr>
                                <td><button class="btn btn-info btn-sm" onclick="detail(${order.orderId})">Chi tiết</button></td>
                                <td>${dao.getAccountByAccountId(order.buyerId).fullName}</td>
                                <td>${order.orderedDate}</td>
                                <td>${order.deliveredDate}</td>
                                <td style="color: ${order.status.equals('Đang duyệt') ? 'grey' : 
                                                        order.status.equals('Đang giao') ? 'blue' :
                                                        order.status.equals('Đã giao') ? 'green' : 
                                                        order.status.equals('Đã hủy') ? 'red' : ''}">
                                    ${order.status}
                                </td>
                                <td>${order.deliveryAddress}</td>
                                <td>${order.paymentStatus}</td>
                                <td>${order.shippingFee}</td>
                                <td>
                                    <form action="shipping" method="post">
                                        <input type="hidden" value="${order.orderId}" name="orderId">
                                        <button type="submit" class="btn btn-success btn-sm" name="shipSubmitButton"
                                            ${(order.status.equals("Đang duyệt") && order.shipperId == 0) ? "" : "disabled"}>
                                            Giao
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function detail(orderId){
        // TODO: mở modal chi tiết đơn hàng
        alert("Xem chi tiết đơn hàng: " + orderId);
    }
</script>
</body>
</html>
