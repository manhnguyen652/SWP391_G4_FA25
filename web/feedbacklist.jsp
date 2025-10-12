<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9f9;
        }
        .sidebar {
            background-color: #fff;
            border-right: 1px solid #ddd;
            height: 100vh;
            padding-top: 20px;
        }
        .sidebar h4 {
            margin-bottom: 1rem;
            color: #4CAF50;
            font-weight: 600;
        }
        .sidebar a {
            color: #333;
            text-decoration: none;
            display: block;
            padding: 8px 15px;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background-color: #f0f0f0;
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
            <a href="#">All Feedback</a>
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
                    <button class="btn btn-success" type="submit">Search</button>
                </form>
            </div>

            
        </div>
    </div>
</div>
</body>

</html>
