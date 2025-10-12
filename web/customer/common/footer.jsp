<%-- 
    Document   : footer
    Created on : Sep 14, 2025, 9:45:33 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<footer class="site-footer">
    <div class="container">
        <div class="row justify-content-between  section-padding">
            <div class=" col-xl-3 col-lg-4 col-sm-6">
                <div class="single-footer pb--40">
                    <div class="brand-footer footer-title">
                        <img src="${pageContext.request.contextPath}/customer/image/logo--footer.png" alt="">
                    </div>
                    <div class="footer-contact">
                        <p><span class="label">Địa chỉ:</span><span class="text">Hà Nội, Việt Nam</span></p>
                        <p><span class="label">Số điện thoại:</span><span class="text">+84 999.999.999</span></p>
                        <p><span class="label">Email:</span><span class="text">pustok@gmail.com</span></p>
                    </div>
                </div>
            </div>
            <div class=" col-xl-3 col-lg-2 col-sm-6">
                <div class="single-footer pb--40">
                    <div class="footer-title">
                        <h3>Thông tin</h3>
                    </div>
                    <ul class="footer-list normal-list">
                        <li><a href="#">Prices drop</a></li>
                        <li><a href="#">New products</a></li>
                        <li><a href="#">Best sales</a></li>
                        <li><a href="#">Contact us</a></li>
                        <li><a href="#">Sitemap</a></li>
                    </ul>
                </div>
            </div>
            <div class=" col-xl-3 col-lg-2 col-sm-6">
                <div class="single-footer pb--40">
                    <div class="footer-title">
                        <h3>Extras</h3>
                    </div>
                    <ul class="footer-list normal-list">
                        <li><a href="#">Delivery</a></li>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Stores</a></li>
                        <li><a href="#">Contact us</a></li>
                        <li><a href="#">Sitemap</a></li>
                    </ul>
                </div>
            </div>
            <div class=" col-xl-3 col-lg-4 col-sm-6">
                <div class="footer-title">
                    <h3>Newsletter Subscribe</h3>
                </div>
                <div class="newsletter-form mb--30">
                    <form action="https://htmldemo.net/pustok/pustok/php/mail.php">
                        <input type="email" class="form-control" placeholder="Enter Your Email Address Here...">
                        <button class="btn btn--primary w-100">Subscribe</button>
                    </form>
                </div>
                <div class="social-block">
                    <h3 class="title">STAY CONNECTED</h3>
                    <ul class="social-list list-inline">
                        <li class="single-social facebook"><a href="#"><i class="ion ion-social-facebook"></i></a>
                        </li>
                        <li class="single-social twitter"><a href="#"><i class="ion ion-social-twitter"></i></a></li>
                        <li class="single-social google"><a href="#"><i
                                    class="ion ion-social-googleplus-outline"></i></a></li>
                        <li class="single-social youtube"><a href="#"><i class="ion ion-social-youtube"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="container">
            <p class="copyright-heading">Thank you!!!</p>
            <a href="#" class="payment-block">
                <img src="${pageContext.request.contextPath}/customer/image/icon/payment.png" alt="">
            </a>
            <p class="copyright-text">Copyright © 2025 <a href="#" class="author">Pustok</a>. All Right Reserved.
                <br>
                Design By Pustok</p>
        </div>
    </div>
</footer>