<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Xác thực tài khoản - Pustok Book Store</title>
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
                                    <li class="breadcrumb-item active" aria-current="page">Xác thực tài khoản</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>

                <!-- =========================
                     XÁC THỰC TÀI KHOẢN
                =============================-->
                <main class="page-section inner-page-sec-padding-bottom">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-md-8 col-lg-6 col-xl-5">
                                <div class="card shadow-sm p-4">
                                    <div class="text-center mb-4">
                                        <h3 class="login-title">Xác thực tài khoản</h3>
                                        <p>Chúng tôi đã gửi mã xác thực đến địa chỉ email <strong>${email}</strong></p>
                                    <p>Vui lòng nhập mã gồm 6 chữ số bên dưới để kích hoạt tài khoản.</p>
                                </div>

                                <!-- Form xác thực -->
                                <form action="login-register" method="post">
                                    <input type="hidden" name="action" value="verify">
                                    <input type="hidden" name="email" value="${email}">
                                    <div class="form-group mb-3">
                                        <label for="code">Mã xác thực</label>
                                        <input type="text" class="form-control" id="code" name="code" placeholder="Nhập mã xác thực..." required>
                                    </div>

                                    <!-- Hiển thị thông báo -->
                                    <%
                                        String error = (String) request.getAttribute("error");
                                        if (error != null) {
                                    %>
                                    <div class="alert alert-danger text-center"><%= error %></div>
                                    <% } %>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary w-100">Xác nhận</button>
                                    </div>
                                </form>

                                <div class="text-center mt-4">
                                    <p>Bạn chưa nhận được mã?</p>

                                    <form id="resendForm" action="login-register" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="resend">
                                        <input type="hidden" name="email" value="${email}">
                                        <button type="submit" id="resendBtn" class="btn btn-outline-secondary btn-sm">Gửi lại mã</button>
                                    </form>

                                    <p class="mt-2 text-muted" id="countdownText" style="display:none;"></p>
                                    <p>Vui lòng kiểm tra hộp thư <strong>Spam / Quảng cáo</strong> hoặc <a href="login-register">đăng ký lại</a>.</p>
                                </div>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        const resendForm = document.getElementById("resendForm");
                                        const resendBtn = document.getElementById("resendBtn");
                                        const countdownText = document.getElementById("countdownText");

                                        if (!resendForm || !resendBtn || !countdownText)
                                            return;

                                        resendForm.addEventListener("submit", function (e) {
                                            e.preventDefault(); // ❗ Ngăn submit reload trang

                                            resendBtn.disabled = true;
                                            let remaining = 60;
                                            countdownText.style.display = "block";
                                            countdownText.innerText = `Vui lòng chờ ${remaining}s để gửi lại mã.`;

                                            const interval = setInterval(() => {
                                                remaining--;
                                                countdownText.innerText = "Vui lòng chờ " + remaining + "s để gửi lại mã."; 
                                                if (remaining <= 0) {
                                                    clearInterval(interval);
                                                    countdownText.style.display = "none";
                                                    resendBtn.disabled = false;
                                                }
                                            }, 1000);

                                            // Gửi request đến servlet
                                            fetch("login-register", {
                                                method: "POST",
                                                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                                                body: "action=resend&email=" + encodeURIComponent(resendForm.email.value);
                                            })
                                                    .then(res => res.text())
                                                    .then(() => {
                                                        countdownText.innerText = "✅ Mã xác thực mới đã được gửi đến email của bạn!";
                                                        countdownText.style.display = "block";
                                                        countdownText.style.color = "green";
                                                        setTimeout(() => countdownText.style.display = "none", 5000);
                                                    })
                                                    .catch(() => {
                                                        countdownText.innerText = "❌ Gửi lại mã thất bại. Vui lòng thử lại sau.";
                                                        countdownText.style.display = "block";
                                                        countdownText.style.color = "red";
                                                        setTimeout(() => countdownText.style.display = "none", 5000);
                                                    });
                                        });
                                    });
                                </script>
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
    </body>
</html>
