<%-- 
    Document   : my-account-order-detail.jsp
    Created on : Oct 31, 2025, 9:15:54 PM
    Author     : admin123
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>chi tiết order</title>
    </head>
    <body>
        <h3>Order Detail</h3>

<p><b>Order ID:</b> ${param.orderId}</p>
<p><b>Ngày đặt:</b> ${order.date}</p>
<p><b>Trạng thái:</b> ${order.status}</p>

<table class="table">
    <thead>
        <tr><th>Image</th><th>Product</th><th>Price</th><th>Quantity</th><th>Total</th></tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${order.items}">
            <tr>
                <td><img src="${item.image}" width="60"></td>
                <td>${item.name}</td>
                <td>${item.price}</td>
                <td>${item.quantity}</td>
                <td>${item.total}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<a href="my-account.jsp?section=orders" class="btn">← Quay lại</a>
</body>
</html>
