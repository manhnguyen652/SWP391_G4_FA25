<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Shipper Profile</title>
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
    <style>
        body {
            background: #f5f5f5;
        }
        .profile-wrapper {
            max-width: 640px;
            margin: 40px auto;
            background: #fff;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }
        .profile-wrapper h2 {
            font-weight: 600;
            margin-bottom: 20px;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            margin-bottom: 16px;
        }
        .btn-primary {
            background: #7bb241;
            border: none;
            padding: 10px 18px;
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary:hover {
            background: #689a36;
            color: #fff;
        }
        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-success {
            background: #e6f6ea;
            color: #2f855a;
        }
        .alert-danger {
            background: #fdecea;
            color: #c53030;
        }
    </style>
</head>
<body>
    <div class="profile-wrapper">
        <h2>Thông tin Shipper</h2>

        <c:if test="${not empty flash}">
            <div class="alert ${flashType == 'success' ? 'alert-success' : 'alert-danger'}">${flash}</div>
        </c:if>

        <form action="shipperProfile" method="post">
            <div>
                <label>Họ và tên</label>
                <input type="text" class="form-control" value="${sessionScope.account.f_name} ${sessionScope.account.l_name}" disabled>
            </div>
            <div>
                <label>Email</label>
                <input type="text" class="form-control" value="${sessionScope.account.u_email}" disabled>
            </div>
            <div>
                <label>Số điện thoại</label>
                <input type="text" name="phone" value="${shipper.phone}" class="form-control" required>
            </div>
            <div>
                <label>Biển số xe</label>
                <input type="text" name="vehicle" value="${shipper.vehicleNumber}" class="form-control" required>
            </div>
            <div>
                <label>Khu vực hoạt động</label>
                <input type="text" name="region" value="${shipper.region}" class="form-control" required>
            </div>
            <div class="actions">
                <button class="btn-primary" type="submit">Lưu thay đổi</button>
                <a href="shipping" class="btn-primary">Quay lại danh sách giao hàng</a>
            </div>
        </form>
    </div>
</body>
</html>
