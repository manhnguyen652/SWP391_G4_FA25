<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">
</head>
<body>
<div class="site-wrapper" id="top">
    <jsp:include page="./common/header.jsp"/>

    <div class="container my-5">
        <h3>Chi tiết đơn hàng #${orderId}</h3>
        <table class="table table-bordered text-center">
            <thead class="thead-light">
                <tr>
                    <th>Ảnh</th>
                    <th>Tên sách</th>
                    <th>Số lượng</th>
                    <th>Giá / Sản phẩm</th>
                    <th>Tổng</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="d" items="${orderDetails}">
                    <tr>
                        <td><img src="${pageContext.request.contextPath}/customer/image/books/${d.bookImage}" width="60"/></td>
                        <td>${d.bookName}</td>
                        <td>${d.quantity}</td>
                        <td><fmt:formatNumber value="${d.pricePerItem}" type="number"/> VND</td>
                        <td><fmt:formatNumber value="${d.quantity * d.pricePerItem}" type="number"/> VND</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="${pageContext.request.contextPath}/my-account/orders" class="btn btn__bg mt-3">← Quay lại danh sách đơn hàng</a>
    </div>

    <jsp:include page="./common/footer.jsp"/>
</div>
</body>
</html>
