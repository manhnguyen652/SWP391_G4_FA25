<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Đăng nhập & Đăng ký - Pustok Book Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/customer/css/main.css" />
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
</head>
<body>
<div class="site-wrapper" id="top">
    <jsp:include page="./common/header.jsp"></jsp:include>

    <section class="breadcrumb-section">
        <h2 class="sr-only">Site Breadcrumb</h2>
        <div class="container">
            <div class="breadcrumb-contents">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Đăng nhập & Đăng ký</li>
                    </ol>
                </nav>
            </div>
        </div>
    </section>

    <!-- ========================= TRANG LOGIN/REGISTER ========================= -->
    <main class="page-section inner-page-sec-padding-bottom">
        <div class="container">
            <div class="row justify-content-center">
                <!-- FORM ĐĂNG NHẬP -->
                <div class="col-md-6">
                    <div class="register-box">
                        <h3 class="mb-3">Đăng ký tài khoản</h3>

                        <!-- Hiển thị lỗi đăng ký -->
                        <% if (request.getAttribute("registerError") != null) { %>
                            <div class="alert alert-danger text-center">
                                <%= request.getAttribute("registerError") %>
                            </div>
                        <% } %>

                        <form action="login-register" method="post" novalidate>
                            <input type="hidden" name="action" value="register">

                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" name="fullname" class="form-control" required
                                       value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : "" %>"
                                       placeholder="Nhập họ và tên...">
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" required
                                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                                       placeholder="Nhập email...">
                            </div>

                            <div class="form-group">
                                <label>Mật khẩu</label>
                                <input type="password" name="password" class="form-control" required
                                       placeholder="Tạo mật khẩu...">
                            </div>

                            <div class="form-group">
                                <label>Nhập lại mật khẩu</label>
                                <input type="password" name="repeat_password" class="form-control" required
                                       placeholder="Nhập lại mật khẩu...">
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-success w-100 mt-2">Đăng ký</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- FORM ĐĂNG Nhập-->
                <div class="col-md-6 mb-5">
                    <div class="login-box">
                        <h3 class="mb-3">Đăng nhập</h3>

                        <!-- Hiển thị lỗi đăng nhập -->
                        <% if (request.getAttribute("loginError") != null) { %>
                            <div class="alert alert-danger text-center">
                                <%= request.getAttribute("loginError") %>
                            </div>
                        <% } %>

                        <% if (request.getAttribute("success") != null) { %>
                            <div class="alert alert-success text-center">
                                <%= request.getAttribute("success") %>
                            </div>
                        <% } %>

                        <form action="login-register" method="post" novalidate>
                            <input type="hidden" name="action" value="login">

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="login_email" class="form-control" required
                                       value="<%= request.getAttribute("login_email") != null ? request.getAttribute("login_email") : "" %>"
                                       placeholder="Nhập email...">
                            </div>

                            <div class="form-group">
                                <label>Mật khẩu</label>
                                <input type="password" name="login_password" class="form-control" required
                                       placeholder="Nhập mật khẩu...">
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary w-100 mt-2">Đăng nhập</button>
                                <a href="forgot-password">Quên mật khẩu?</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="./common/footer.jsp"></jsp:include>
</div>

<!-- JS -->
<script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>

<!-- Kiểm tra HTML5 client-side -->
<script>
document.addEventListener("DOMContentLoaded", () => {
    const forms = document.querySelectorAll("form");
    forms.forEach(form => {
        form.addEventListener("submit", e => {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
                alert("⚠️ Vui lòng điền đầy đủ thông tin trước khi gửi!");
            }
        });
    });
});
</script>
</body>
</html>
