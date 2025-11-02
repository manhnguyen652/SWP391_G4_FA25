<%-- 
    Document   : my-account-orders.jsp
    Created on : Oct 31, 2025, 9:07:25 PM
    Author     : admin123
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>chi tiết địa chỉ</title>
    </head>
    <body>
        <h3>Orders</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty orders}">
                    <tr>
                        <td colspan="6" class="text-center">Hiện bạn chưa có đơn hàng nào.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orders}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${order.ship_lname} ${order.ship_fname}</td>
                            <td><fmt:formatDate value="${order.createDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                        <td>${order.statusId}</td>
                        <td><fmt:formatNumber value="${order.totalAmount}" type="number"/> VND</td>
                        <td>
                            <a href="my-account.jsp?section=order-detail&id=${order.id}" class="btn">VIEW</a>
                        </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- Nếu chưa có dữ liệu -->
<c:if test="${empty orders}">
    <p>Hiện bạn chưa có đơn hàng nào.</p>
</c:if>
</body>
</html>
