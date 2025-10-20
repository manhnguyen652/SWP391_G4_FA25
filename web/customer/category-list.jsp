<%-- 
    Document   : category-list
    Created on : Oct 20, 2025, 3:51:05 PM
    Author     : duong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Danh mục sách</h2>
        <a href="category?action=new">Thêm danh mục</a>
        <table border="1">
            <tr><th>ID</th><th>Tên danh mục</th><th>Hành động</th></tr>
            <c:forEach var="c" items="${list}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.cate_name}</td>
                    <td>
                        <a href="category?action=edit&id=${c.id}">Sửa</a> |
                        <a href="category?action=delete&id=${c.id}">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

    </body>
</html>
