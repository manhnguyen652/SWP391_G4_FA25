<%-- 
    Document   : home_register
    Created on : Oct 3, 2025, 9:34:05 PM
    Author     : admin123
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pustok - Book Store</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Use Minified Plugins Version For Fast Page Load -->
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
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
                                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                <li class="breadcrumb-item active">Login</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </section>
            <!--=============================================
=            Login Register page content         =
=============================================-->
            <main class="page-section inner-page-sec-padding-bottom">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-xs-12 col-lg-6 mb--30 mb-lg--0">
                            <!-- Login Form s-->
                            <form action="login-register" method="post">
                                <input type="hidden" name="action" value="register">
                                <div class="login-form">
                                    <h4 class="login-title">New Customer</h4>
                                    <p><span class="font-weight-bold">I am a new customer</span></p>
                                    <div class="row">
                                        <div class="col-md-12 col-12 mb--15">
                                            <label for="name">Full Name</label>
                                            <input class="mb-0 form-control" type="text" name="fullname" id="name" placeholder="Enter your full name">
                                        </div>
                                        <div class="col-12 mb--20">
                                            <label for="email">Email</label>
                                            <input class="mb-0 form-control" type="email" name="email" id="email" placeholder="Enter Your Email Address Here..">
                                        </div>
                                        <div class="col-lg-6 mb--20">
                                            <label for="password">Password</label>
                                            <input class="mb-0 form-control" type="password" name="password" id="password" placeholder="Enter your password">
                                        </div>
                                        <div class="col-lg-6 mb--20">
                                            <label for="repeat-password">Repeat Password</label>
                                            <input class="mb-0 form-control" type="password" name="repeat_password" id="repeat-password" placeholder="Repeat your password">
                                        </div>
                                        <div class="col-md-12">
                                            <button type="submit" class="btn btn-outlined">Register</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-6 col-xs-12">
                            <form action="login-register" method="post">
                                <input type="hidden" name="action" value="login">
                                <div class="login-form">
                                    <h4 class="login-title">Returning Customer</h4>
                                    <p><span class="font-weight-bold">I am a returning customer</span></p>
                                    <div class="row">
                                        <div class="col-md-12 col-12 mb--15">
                                            <label for="email1">Enter your email address here...</label>
                                            <input class="mb-0 form-control" type="email" name="login_email" id="email1" placeholder="Enter your email address here...">
                                        </div>
                                        <div class="col-12 mb--20">
                                            <label for="login-password">Password</label>
                                            <input class="mb-0 form-control" type="password" name="login_password" id="login-password" placeholder="Enter your password">
                                        </div>
                                        <div class="col-md-12">
                                            <button type="submit" class="btn btn-outlined">Login</button>
                                            
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <!--=================================
  Brands Slider
===================================== -->
        <section class="section-margin">
            <h2 class="sr-only">Brand Slider</h2>
            <div class="container">
                <div class="brand-slider sb-slick-slider border-top border-bottom slick-initialized slick-slider" data-slick-setting="{
                     &quot;autoplay&quot;: true,
                     &quot;autoplaySpeed&quot;: 8000,
                     &quot;slidesToShow&quot;: 6
                     }" data-slick-responsive="[
                     {&quot;breakpoint&quot;:992, &quot;settings&quot;: {&quot;slidesToShow&quot;: 4} },
                     {&quot;breakpoint&quot;:768, &quot;settings&quot;: {&quot;slidesToShow&quot;: 3} },
                     {&quot;breakpoint&quot;:575, &quot;settings&quot;: {&quot;slidesToShow&quot;: 3} },
                     {&quot;breakpoint&quot;:480, &quot;settings&quot;: {&quot;slidesToShow&quot;: 2} },
                     {&quot;breakpoint&quot;:320, &quot;settings&quot;: {&quot;slidesToShow&quot;: 1} }
                     ]"><div class="slick-list draggable"><div class="slick-track" style="opacity: 1; width: 1360px; transform: translate3d(-850px, 0px, 0px);"><div class="slick-slide" data-slick-index="0" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-1.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="1" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-2.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="2" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-3.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="3" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-4.jpg" alt="">
                                    </div></div></div><div class="slick-slide" data-slick-index="4" aria-hidden="true" style="width: 170px;" tabindex="-1"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-5.jpg" alt="">
                                    </div></div></div><div class="slick-slide slick-current slick-active" data-slick-index="5" aria-hidden="false" style="width: 170px;"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-6.jpg" alt="">
                                    </div></div></div><div class="slick-slide slick-active" data-slick-index="6" aria-hidden="false" style="width: 170px;"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-1.jpg" alt="">
                                    </div></div></div><div class="slick-slide slick-active" data-slick-index="7" aria-hidden="false" style="width: 170px;"><div><div class="single-slide" style="width: 100%; display: inline-block;">
                                        <img src="image/others/brand-2.jpg" alt="">
                                    </div></div></div></div></div></div>
            </div>
        </section>
        <!--=================================
    Footer Area
===================================== -->
        <footer class="site-footer">
            <div class="container">
                <div class="row justify-content-between  section-padding">
                    <div class=" col-xl-3 col-lg-4 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="brand-footer footer-title">
                                <img src="image/logo--footer.png" alt="">
                            </div>
                            <div class="footer-contact">
                                <p><span class="label">Address:</span><span class="text">Example Street 98, HH2 BacHa, New
                                        York, USA</span></p>
                                <p><span class="label">Phone:</span><span class="text">+18088 234 5678</span></p>
                                <p><span class="label">Email:</span><span class="text">suport@hastech.com</span></p>
                            </div>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-2 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="footer-title">
                                <h3>Information</h3>
                            </div>
                            <ul class="footer-list normal-list">
                                <li><a href="">Prices drop</a></li>
                                <li><a href="">New products</a></li>
                                <li><a href="">Best sales</a></li>
                                <li><a href="">Contact us</a></li>
                                <li><a href="">Sitemap</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-2 col-sm-6">
                        <div class="single-footer pb--40">
                            <div class="footer-title">
                                <h3>Extras</h3>
                            </div>
                            <ul class="footer-list normal-list">
                                <li><a href="">Delivery</a></li>
                                <li><a href="">About Us</a></li>
                                <li><a href="">Stores</a></li>
                                <li><a href="">Contact us</a></li>
                                <li><a href="">Sitemap</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class=" col-xl-3 col-lg-4 col-sm-6">
                        <div class="footer-title">
                            <h3>Newsletter Subscribe</h3>
                        </div>
                        <div class="newsletter-form mb--30">
                            <form action="./php/mail.php">
                                <input type="email" class="form-control" placeholder="Enter Your Email Address Here...">
                                <button class="btn btn--primary w-100">Subscribe</button>
                            </form>
                        </div>
                        <div class="social-block">
                            <h3 class="title">STAY CONNECTED</h3>
                            <ul class="social-list list-inline">
                                <li class="single-social facebook"><a href=""><i class="ion ion-social-facebook"></i></a>
                                </li>
                                <li class="single-social twitter"><a href=""><i class="ion ion-social-twitter"></i></a></li>
                                <li class="single-social google"><a href=""><i class="ion ion-social-googleplus-outline"></i></a></li>
                                <li class="single-social youtube"><a href=""><i class="ion ion-social-youtube"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <p class="copyright-heading">Suspendisse in auctor augue. Cras fermentum est ac fermentum tempor. Etiam
                        vel magna volutpat, posuere eros</p>
                    <a href="#" class="payment-block">
                        <img src="image/icon/payment.png" alt="">
                    </a>
                    <p class="copyright-text">Copyright © 2022 <a href="#" class="author">Pustok</a>. All Right Reserved.
                        <br>
                        Design By Pustok</p>
                </div>
            </div>
        </footer>
        <!-- Use Minified Plugins Version For Fast Page Load -->
        <jsp:include page="./common/footer.jsp"></jsp:include>
        <script src="js/plugins.js"></script>
        <script src="js/ajax-mail.js"></script>
        <script src="js/custom.js"></script>


        <a id="scrollUp" href="#top" style="position: fixed; z-index: 2147483647;"><i class="ion-chevron-right"></i><i class="ion-chevron-right"></i></a><div id="envidictionary"><div class="o-search-mobile" style="top: 0px; left: 0px; display: none;"><img alt="ENVI" width="27" height="27" src="data:image/png;base64,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" style="width: 27px; height: 27px;"></div><div class="o-popup-tag o-bg-white o-border o-rounded o-shadow" style="width: 400px; top: 0px; left: 0px; display: none;"><div><button type="button" aria-label="Close" class="o-btn-close o-position-absolute o-top-0 o-end-0 o-mt-1 o-me-1"></button><ul role="tablist" class="o-nav o-nav-tabs o-pop-nav"><span><svg aria-hidden="true" focusable="false" data-icon="volume-high" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="o-pop-speak o-link-secondary o-svg-inline--fa"><path fill="currentColor" d="M533.6 32.5C598.5 85.3 640 165.8 640 256s-41.5 170.8-106.4 223.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C557.5 398.2 592 331.2 592 256s-34.5-142.2-88.7-186.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM473.1 107c43.2 35.2 70.9 88.9 70.9 149s-27.7 113.8-70.9 149c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C475.3 341.3 496 301.1 496 256s-20.7-85.3-53.2-111.8c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zm-60.5 74.5C434.1 199.1 448 225.9 448 256s-13.9 56.9-35.4 74.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C393.1 284.4 400 271 400 256s-6.9-28.4-17.7-37.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM301.1 34.8C312.6 40 320 51.4 320 64V448c0 12.6-7.4 24-18.9 29.2s-25 3.1-34.4-5.3L131.8 352H64c-35.3 0-64-28.7-64-64V224c0-35.3 28.7-64 64-64h67.8L266.7 40.1c9.4-8.4 22.9-10.4 34.4-5.3z"></path></svg></span><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="true" class="o-nav-link o-active">Tra cứu</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Dịch</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Cài đặt</div></li></ul><div class="o-selected-result o-pt-1"><div> Đang tìm kiếm ... </div></div></div></div></div><div id="envidictionarySetting" url="https://envi.jpdictionary.com/setting/"></div><div id="envidictionaryOff"></div><div id="tudienjp"><div class="o-search-mobile" style="top: 0px; left: 0px; display: none;"><img alt="Từ điển JP" width="27" height="27" src="data:image/png;base64,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" style="width: 27px; height: 27px;"></div><div class="o-popup-tag o-bg-white o-border o-rounded o-shadow" style="width: 400px; top: 0px; left: 0px; display: none;"><div><button type="button" aria-label="Close" class="btn-sm o-btn-close o-position-absolute o-top-0 o-end-0 o-mt-1 o-me-1"></button><ul role="tablist" class="o-nav o-nav-tabs o-pop-nav"><span><svg aria-hidden="true" focusable="false" data-icon="volume-high" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="o-pop-speak o-svg-inline--fa"><path fill="currentColor" d="M533.6 32.5C598.5 85.3 640 165.8 640 256s-41.5 170.8-106.4 223.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C557.5 398.2 592 331.2 592 256s-34.5-142.2-88.7-186.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM473.1 107c43.2 35.2 70.9 88.9 70.9 149s-27.7 113.8-70.9 149c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C475.3 341.3 496 301.1 496 256s-20.7-85.3-53.2-111.8c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zm-60.5 74.5C434.1 199.1 448 225.9 448 256s-13.9 56.9-35.4 74.5c-10.3 8.4-25.4 6.8-33.8-3.5s-6.8-25.4 3.5-33.8C393.1 284.4 400 271 400 256s-6.9-28.4-17.7-37.3c-10.3-8.4-11.8-23.5-3.5-33.8s23.5-11.8 33.8-3.5zM301.1 34.8C312.6 40 320 51.4 320 64V448c0 12.6-7.4 24-18.9 29.2s-25 3.1-34.4-5.3L131.8 352H64c-35.3 0-64-28.7-64-64V224c0-35.3 28.7-64 64-64h67.8L266.7 40.1c9.4-8.4 22.9-10.4 34.4-5.3z"></path></svg></span><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="true" class="o-nav-link o-active">Từ vựng</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Hán tự</div></li><li role="presentation" class="o-nav-item"><div data-bs-toggle="tab" aria-selected="false" class="o-nav-link">Dịch</div></li></ul><div class="o-selected-result o-pt-1"><div> Đang tìm kiếm ... </div><div class="o-fs-6 o-mt-2" style="line-height: 1.7;"><div class="o-float-start"><div class="o-form-check"><input type="checkbox" id="flexCheckTudienjpLang" class="o-form-check-input"><label for="flexCheckTudienjpLang"> Tiếng Anh </label></div></div><div class="o-float-end o-me-1"><a href="https://tudienjp.com/setting/" target="_blank" class="o-link-secondary o-text-decoration-none">Cài đặt</a></div></div></div></div></div></div><div id="tudienjpSetting" url="https://tudienjp.com/setting/"></div><div id="tudienjpOff"></div><div id="mttContainer" class="bootstrapiso notranslate" data-original-title="Bản tin đăng ký" title="" style="transform: translate(712px, 258px);" dir="ltr"></div></body>
</html>
