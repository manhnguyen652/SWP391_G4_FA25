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
        <style>
            .address-card {
                background: #fff;
                border: 1px solid #e5e5e5;
                border-radius: 6px;
                padding: 30px 40px;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            }
            .address-card h3 {
                font-size: 22px;
                font-weight: 600;
                border-bottom: 1px dotted #ccc;
                padding-bottom: 10px;
                margin-bottom: 25px;
                color: #222;
            }
            .address-card p {
                font-size: 15px;
                color: #444;
                margin-bottom: 8px;
            }
            .address-card b {
                color: #000;
            }
            .edit-btn {
                display: inline-block;
                background-color: #62ab00;
                color: #fff !important;
                padding: 10px 20px;
                border-radius: 4px;
                font-weight: 500;
                text-decoration: none;
                margin-top: 20px;
                transition: all 0.3s ease;
            }
            .edit-btn:hover {
                background-color: #4e8f00;
            }
            .account-section {
                padding: 60px 0;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="address-card">
                <h3>Địa chỉ</h3>

                <c:choose>
                    <c:when test="${info != null}">
                        <p><b>${sessionScope.account.l_name} ${sessionScope.account.f_name}</b></p>
                        <p>${info.address}, ${info.country}</p>
                        <p>Mobile: ${info.phone}</p>
                    </c:when>
                    <c:otherwise>
                        <p>Bạn chưa có thông tin địa chỉ. Hãy thêm mới.</p>
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/edit-address" class="edit-btn">
                    <i class="fa fa-edit"></i> Edit Address
                </a>
            </div>
        </div>
    </body>
</html>
