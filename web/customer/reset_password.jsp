<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Đặt lại mật khẩu - Pustok Book Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">
</head>
<body>
<div class="site-wrapper" id="top">
    <jsp:include page="./common/header.jsp"></jsp:include>

    <section class="breadcrumb-section">
        <div class="container">
            <div class="breadcrumb-contents">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                        <li class="breadcrumb-item active">Đặt lại mật khẩu</li>
                    </ol>
                </nav>
            </div>
        </div>
    </section>

    <main class="page-section inner-page-sec-padding-bottom">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 col-xl-5">
                    <div class="card shadow-sm p-4">
                        <div class="text-center mb-4">
                            <h3 class="login-title">Đặt lại mật khẩu mới</h3>
                            <p>Nhập mật khẩu mới cho tài khoản của bạn.</p>
                        </div>

                        <form action="forgot-password" method="post">
                            <input type="hidden" name="action" value="reset">
                            <input type="hidden" name="email" value="${email}">
                            <div class="form-group mb-3">
                                <label for="password">Mật khẩu mới</label>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Nhập mật khẩu mới..." required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="repeat_password">Nhập lại mật khẩu</label>
                                <input type="password" class="form-control" id="repeat_password" name="repeat_password"
                                       placeholder="Nhập lại mật khẩu..." required>
                            </div>

                            <% String error = (String) request.getAttribute("error"); %>
                            <% String success = (String) request.getAttribute("success"); %>
                            <% if (error != null) { %>
                                <div class="alert alert-danger text-center"><%= error %></div>
                            <% } else if (success != null) { %>
                                <div class="alert alert-success text-center"><%= success %></div>
                            <% } %>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-success w-100">Đặt lại mật khẩu</button>
                            </div>
                        </form>

                        <div class="text-center mt-3">
                            <a href="login-register">← Quay lại đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="./common/footer.jsp"></jsp:include>
</div>

<script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
</body>
</html>
