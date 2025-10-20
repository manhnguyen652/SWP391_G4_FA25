<%-- 
    Document   : category-detail
    Created on : Oct 20, 2025, 3:51:45 PM
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
        <h2>${category == null ? "Thêm mới" : "Cập nhật"} danh mục</h2>
        <form method="post" action="category">
            <input type="hidden" name="id" value="${category.id}" />
            <label>Tên danh mục:</label>
            <input type="text" name="cate_name" value="${category.cate_name}" required />
            <button type="submit">Lưu</button>
        </form>

    </body>
</html>
