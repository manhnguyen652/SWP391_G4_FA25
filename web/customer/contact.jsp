<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Liên hệ - Pustok Book Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Giao diện -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/plugins.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/customer/css/main.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
</head>
<style>
        /* ====== Contact Page Custom Style ====== */

        .contact-section {
            padding: 60px 0;
        }

        .contact-info {
            margin-top: 10px;
        }

        .contact-info .title {
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #333;
        }

        .contact-info .desc {
            font-size: 15px;
            color: #555;
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .contact-info .info-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .contact-info .info-list li {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
            color: #333;
            font-size: 15px;
            line-height: 1.6;
        }

        .contact-info .info-list i {
            color: #5bb300; /* Màu xanh lá icon */
            font-size: 18px;
            margin-right: 10px;
            margin-top: 4px;
            width: 20px;
            text-align: center;
        }

        .contact-info strong {
            margin-right: 5px;
            font-weight: 600;
            color: #222;
        }

        /* Send message form */
        .contact-form .title {
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
        }

        .contact-form input,
        .contact-form textarea {
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 15px;
            transition: border 0.3s;
        }

        .contact-form input:focus,
        .contact-form textarea:focus {
            outline: none;
            border-color: #5bb300;
        }

        .contact-form button {
            background-color: #333;
            color: #fff;
            padding: 10px 25px;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .contact-form button:hover {
            background-color: #5bb300;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .contact-info, .contact-form {
                margin-bottom: 30px;
            }
        }
    </style>
<body>
<div class="site-wrapper" id="top">
    <jsp:include page="./common/header.jsp"></jsp:include>

    <!-- 🟩 Breadcrumb -->
    <section class="breadcrumb-section">
        <div class="container">
            <div class="breadcrumb-contents">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                        <li class="breadcrumb-item active">Contact</li>
                    </ol>
                </nav>
            </div>
        </div>
    </section>

    <!-- 🗺️ Google Map -->
    <div class="google-map mb--50">
        <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.911792219229!2d105.79829507470378!3d21.036237687515963!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab2e74bdf85b%3A0xc6d8a0debf1d045b!2zSG_DoG5nIMSQ4bupYyBLaG9hIE5nw6JuIFRow6FpIFRo4bqhbg!5e0!3m2!1svi!2s!4v1700000000000!5m2!1svi!2s"
            width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy">
        </iframe>
    </div>

    <!-- 🏢 Contact Section -->
    <section class="contact-section">
        <div class="container">
           <div class="row">
                    <!-- LEFT SIDE: Location & Details -->
                    <div class="col-lg-6 col-md-6 col-12">
                        <div class="contact-info">
                            <h3 class="title">Location & Details</h3>
                            <p class="desc">
                                It is a long established fact that readers will be distracted by the readable content of a page when looking at its layout.
                            </p>
                            <ul class="info-list">
                                <li>
                                    <i class="fas fa-map-marker-alt"></i>
                                    <strong>Address:</strong> 1234 - Bandit Tringi lAliquam Vitae, New York
                                </li>
                                <li>
                                    <i class="fas fa-envelope"></i>
                                    <strong>Email:</strong> support@example.com
                                </li>
                                <li>
                                    <i class="fas fa-phone"></i>
                                    <strong>Phone:</strong> (800) 0123 456 789
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- RIGHT SIDE: Send Us a Message -->
                    <div class="col-lg-6 col-md-6 col-12">
                        <div class="contact-form">
                            <h3 class="title">Send Us a Message</h3>
                            <form action="#" method="post">
                                <input type="text" name="name" placeholder="Your Name *" required>
                                <input type="email" name="email" placeholder="Your Email *" required>
                                <input type="text" name="phone" placeholder="Your Phone *" required>
                                <textarea name="message" rows="6" placeholder="Your Message"></textarea>
                                <button type="submit">SEND</button>
                            </form>
                        </div>
                    </div>
                </div>
        </div>
    </section>

                    
    <jsp:include page="./common/footer.jsp"></jsp:include>
</div>

<script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
</body>
</html>
