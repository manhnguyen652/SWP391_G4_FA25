<%-- 
    Document   : my-account-address.jsp
    Created on : Oct 31, 2025, 9:19:42 PM
    Author     : admin123
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Địa chỉ thanh toán</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">       
    </head>
    <body>
        <jsp:include page="./common/header.jsp"></jsp:include>
        <h3>Edit Address</h3>
        <form action="${pageContext.request.contextPath}/edit-address" method="post">
            <div class="single-input">
                <label>Họ và tên</label>
                <input type="text" name="fullname" class="form-control"
                       value="${sessionScope.account.l_name} ${sessionScope.account.f_name}" readonly>
            </div>

            <div class="single-input">
                <label>Địa chỉ</label>
                <input type="text" name="address" class="form-control"
                       value="${info.address}" required>
            </div>

            <div class="single-input">
                <label>Quốc gia</label>
                <input type="text" name="country" class="form-control"
                       value="${info.country}" required>
            </div>

            <div class="single-input">
                <label>Số điện thoại</label>
                <input type="text" name="phone" class="form-control"
                       value="${info.phone}" required>
            </div>

            <button type="submit" class="btn">Lưu thay đổi</button>
            <a href="${pageContext.request.contextPath}/my-account?section=address" class="btn" style="background:#888">Hủy</a>
        </form>
        <jsp:include page="./common/brand_slider.jsp"></jsp:include>
        <jsp:include page="./common/footer.jsp"></jsp:include>
    </body>
</html>
