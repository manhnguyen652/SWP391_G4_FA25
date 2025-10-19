<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Feedback Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS gốc của site -->
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">

    <style>
        body {
            background-color: #f9f9f9;
        }
        /* Sidebar */
        .sidebar {
            background-color: #fff;
            border-right: 1px solid #ddd;
            height: 100vh;
            padding-top: 20px;
        }
        .sidebar h4 {
            margin-bottom: 1rem;
            color: #7bb241; /* giống màu .btn--primary */
            font-weight: 600;
        }
        .sidebar a {
            color: #333;
            text-decoration: none;
            display: block;
            padding: 8px 15px;
            border-radius: 5px;
            transition: 0.2s;
        }
        .sidebar a:hover, .sidebar a.active {
            background-color: #7bb241;
            color: white;
        }

        /* Nút Search */
        .btn--primary {
            background-color: #7bb241 !important;
            color: white !important;
            border: none;
        }
        .btn--primary:hover {
            background-color: #689a36 !important;
        }

        .table-actions button {
            margin-right: 5px;
        }
        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar trái -->
        <div class="col-md-2 sidebar">
            <h4>Feedback</h4>
            <a href="#" class="active">All Feedback</a>
            <a href="?filter=pending">Pending</a>
            <a href="?filter=approved">Approved</a>
            <a href="?filter=rejected">Rejected</a>
        </div>

        <!-- Nội dung phải -->
        <div class="col-md-10 p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Feedback List</h3>

                <!-- Search + Sort -->
                <form class="search-bar" action="feedback" method="get">
                    <input type="text" name="q" class="form-control" placeholder="Search feedback...">
                    <select name="sort" class="form-select">
                        <option value="">Sort by</option>
                        <option value="date_desc">Newest</option>
                        <option value="date_asc">Oldest</option>
                        <option value="name_asc">Name A-Z</option>
                        <option value="name_desc">Name Z-A</option>
                    </select>
                    <button class="btn btn--primary" type="submit">Search</button>
                </form>
            </div>

            <!-- Bảng danh sách Feedback -->
            <table class="table table-bordered table-hover bg-white">
                <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>User</th>
                    <th>Content</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="fb" items="${feedback_list}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${fb.userName}</td>
                        <td>${fb.content}</td>
                        <td>${fb.createdDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${fb.status == 'approved'}"><span class="badge bg-success">Approved</span></c:when>
                                <c:when test="${fb.status == 'pending'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                                <c:otherwise><span class="badge bg-danger">Rejected</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="table-actions">
                            <form action="feedback" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${fb.id}">
                                <button name="action" value="delete" class="btn btn-sm btn-danger">Delete</button>
                            </form>
                            <form action="feedback" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${fb.id}">
                                <button name="action" value="reject" class="btn btn-sm btn-secondary">Reject</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Phân trang -->
            <nav>
                <ul class="pagination">
                    <c:forEach var="p" begin="1" end="${totalPages}">
                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${p}">${p}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
