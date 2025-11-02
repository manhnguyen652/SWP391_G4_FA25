<%-- 
    Document   : my-account-details.jsp
    Created on : Nov 3, 2025
    Author     : admin123
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Account Details - Pustok</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">

    <style>
        .account-section { padding: 60px 0; }
        .account-sidebar {
            border: 1px solid #ddd; border-radius: 6px; overflow: hidden; margin-bottom: 20px;
        }
        .account-sidebar ul { list-style: none; margin: 0; padding: 0; }
        .account-sidebar li a {
            display: block; padding: 15px 20px; color: #333; border-bottom: 1px solid #eee;
            text-decoration: none; font-weight: 500; transition: all .3s;
        }
        .account-sidebar li a:hover, .account-sidebar li.active a {
            background-color: #62ab00; color: #fff;
        }

        .account-content {
            background: #fff; border: 1px solid #ddd; border-radius: 6px; padding: 30px 40px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .account-content h3 {
            font-size: 22px; font-weight: 600; border-bottom: 1px dotted #ccc;
            padding-bottom: 10px; margin-bottom: 25px; color: #222;
        }

        .single-input { margin-bottom: 20px; }
        .single-input label {
            display: block; font-weight: 500; margin-bottom: 8px;
        }
        .single-input input {
            width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 4px;
        }

        .btn {
            background-color: #62ab00; color: #fff; border: none;
            padding: 10px 20px; border-radius: 4px; cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn:hover { background-color: #4e8f00; }

        .btn.cancel {
            background-color: #888; margin-left: 10px;
        }
        .btn.cancel:hover { background-color: #666; }
    </style>
</head>

<body>
<div class="site-wrapper" id="top">
    <jsp:include page="./common/header.jsp"></jsp:include>

    <!-- Breadcrumb -->
    <section class="breadcrumb-section">
        <div class="container">
            <div class="breadcrumb-contents">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                        <li class="breadcrumb-item active">My Account</li>
                    </ol>
                </nav>
            </div>
        </div>
    </section>

    <!-- MAIN ACCOUNT PAGE -->
    <main class="account-section">
        <div class="container">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-lg-3 col-md-4">
                    <div class="account-sidebar">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/my-account?section=dashboard"><i class="fa fa-tachometer"></i> Dashboard</a></li>
                            <li><a href="${pageContext.request.contextPath}/my-account?section=orders"><i class="fa fa-shopping-cart"></i> Orders</a></li>
                            <li><a href="${pageContext.request.contextPath}/my-account?section=address"><i class="fa fa-map-marker"></i> Address</a></li>
                            <li class="active"><a href="${pageContext.request.contextPath}/my-account?section=details"><i class="fa fa-user"></i> Account Details</a></li>
                            <li><a href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out"></i> Logout</a></li>
                        </ul>
                    </div>
                </div>

                <!-- Content -->
                <div class="col-lg-9 col-md-8">
                    <div class="account-content">
                        <h3>Account Details</h3>
                        <form action="${pageContext.request.contextPath}/my-account" method="post">
                            <div class="row">
                                <div class="col-md-6 single-input">
                                    <label>First Name</label>
                                    <input type="text" value="${sessionScope.account.f_name}" readonly>
                                </div>
                                <div class="col-md-6 single-input">
                                    <label>Last Name</label>
                                    <input type="text" value="${sessionScope.account.l_name}" readonly>
                                </div>
                            </div>

                            <div class="single-input">
                                <label>Email Address</label>
                                <input type="email" value="${sessionScope.account.u_email}" readonly>
                            </div>

                            <h3 style="margin-top: 40px;">Password change</h3>
                            <div class="single-input">
                                <label>Current Password</label>
                                <input type="password" name="current_password" required>
                            </div>
                            <div class="single-input">
                                <label>New Password</label>
                                <input type="password" name="new_password" required>
                            </div>
                            <div class="single-input">
                                <label>Confirm Password</label>
                                <input type="password" name="repeat_password" required>
                            </div>

                            <button type="submit" class="btn">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="./common/footer.jsp"></jsp:include>
</div>
</body>
</html>
