<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Tài khoản của tôi - Pustok</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">

        <style>
            .account-section {
                padding: 60px 0;
            }
            .account-sidebar {
                border: 1px solid #ddd;
                border-radius: 6px;
                overflow: hidden;
                margin-bottom: 20px;
            }
            .account-sidebar ul {
                list-style: none;
                margin: 0;
                padding: 0;
            }
            .account-sidebar li a {
                display: block;
                padding: 15px 20px;
                color: #333;
                border-bottom: 1px solid #eee;
                text-decoration: none;
                font-weight: 500;
                transition: all .3s;
            }
            .account-sidebar li a:hover, .account-sidebar li.active a {
                background-color: #62ab00;
                color: #fff;
            }
            .account-content {
                border: 1px solid #ddd;
                border-radius: 6px;
                padding: 25px;
            }
            .btn {
                background-color: #62ab00;
                color: #fff;
                border: none;
                padding: 8px 20px;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn:hover {
                background-color: #4e8f00;
            }
        </style>
    </head>

    <body>
        <div class="site-wrapper" id="top">
            <jsp:include page="./common/header.jsp"></jsp:include>

                <section class="breadcrumb-section">
                    <div class="container">
                        <div class="breadcrumb-contents">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                                <li class="breadcrumb-item active">Tài khoản của tôi</li>
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
                                    <li class="${param.section == null || param.section == 'dashboard' ? 'active' : ''}">
                                        <a href="${pageContext.request.contextPath}/my-account?section=dashboard">
                                            <i class="fa fa-tachometer"></i> Dashboard
                                        </a>
                                    </li>
                                    <li class="${param.section == null || param.section == 'orders' ? 'active' : ''}">
                                        <a href="${pageContext.request.contextPath}/my-account?section=orders"><i class="fa fa-shopping-cart"></i> Orders</a>
                                    </li>
                                    <li class="${param.section == 'address' ? 'active' : ''}">
                                        <a href="${pageContext.request.contextPath}/my-account?section=address"><i class="fa fa-map-marker"></i> Address</a>
                                    </li>

                                    <li>
                                        <a href="${pageContext.request.contextPath}/customer/account_details.jsp">
                                            <i class="fa fa-user"></i> Account Details
                                        </a>
                                    </li>
                                    <li>
                                        <a href="logout"><i class="fa fa-sign-out"></i> Logout</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Content -->
                        <div class="col-lg-9 col-md-8">
                            <div class="account-content">
                                <%
                                    String section = request.getParameter("section");
                                    if (section == null || section.equals("dashboard")) {
                                %>
                                <jsp:include page="my-account-dashboard.jsp"></jsp:include>
                                <% } else if (section.equals("orders")) { %>
                                <jsp:include page="my-account-orders.jsp"></jsp:include>
                                <% } else if (section.equals("address")) { %>
                                <jsp:include page="my-account-address.jsp"></jsp:include>
                                <% } else if (section.equals("details")) { %>
                                <jsp:include page="my-account-details.jsp"></jsp:include>
                                <% } else { %>
                                <jsp:include page="my-account-dashboard.jsp"></jsp:include>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="./common/footer.jsp"></jsp:include>
        </div>
    </body>
</html>
