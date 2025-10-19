<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Quên mật khẩu - Pustok Book Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
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
                        <li class="breadcrumb-item active">Quên mật khẩu</li>
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
                            <h3 class="login-title">Quên mật khẩu</h3>
                            <p>Nhập địa chỉ email của bạn để nhận mã khôi phục mật khẩu.</p>
                        </div>

                        <form action="forgot-password" method="post">
                            <input type="hidden" name="action" value="send">
                            <div class="form-group mb-3">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       placeholder="Nhập email của bạn..." required>
                            </div>

                            <% String error = (String) request.getAttribute("error"); %>
                            <% if (error != null) { %>
                                <div class="alert alert-danger text-center"><%= error %></div>
                            <% } %>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary w-100">Gửi mã xác nhận</button>
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
