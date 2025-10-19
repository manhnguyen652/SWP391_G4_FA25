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
                        <li><a href="#">Sales</a></li>
                        <li><a href="#">Sản phẩm mới</a></li>
                        <li><a href="#">Liên hệ với chúng tôi</a></li>
                    </ul>
                </div>
            </div>
            <div class=" col-xl-3 col-lg-2 col-sm-6">
                <div class="single-footer pb--40">
                    <div class="footer-title">
                        <h3>Bổ sung</h3>
                    </div>
                    <ul class="footer-list normal-list">
                        <li><a href="#">Vận chuyển</a></li>
                        <li><a href="#">Về chúng tôi</a></li>
                        <li><a href="#">Cửa hàng</a></li>
                    </ul>
                </div>
            </div>
            <div class=" col-xl-3 col-lg-4 col-sm-6">
                <div class="footer-title">
                    <h3>Đăng ký nhận bản tin</h3>
                </div>
                <div class="newsletter-form mb--30">
                    <form action="https://htmldemo.net/pustok/pustok/php/mail.php">
                        <input type="email" class="form-control" placeholder="Nhập địa chỉ Email tại đây...">
                        <button class="btn btn--primary w-100">Đăng ký</button>
                    </form>
                </div>
                <div class="social-block">
                    <h3 class="title">Kết nối</h3>
                    <ul class="social-list list-inline">
                        <li class="single-social facebook" style="boder-radius: 20px;"><a href="#"><i class="ion ion-social-facebook"></i></a>
                        </li>
                        <li class="single-social twitter" style="boder-radius: 20px;"><a href="#"><i class="ion ion-social-twitter"></i></a></li>
                        <li class="single-social google" style="boder-radius: 20px;"><a href="#"><i
                                    class="ion ion-social-googleplus-outline"></i></a></li>
                        <li class="single-social youtube" style="boder-radius: 20px;"><a href="#"><i class="ion ion-social-youtube"></i></a></li>
                    </ul>

                    <!-- 🔽 Nút mới: Feedback List -->
                    <div class="mt-3 text-center">
                        <a href="${pageContext.request.contextPath}/customer/feedback_list.jsp"
                           class="btn btn--primary w-100">
                            View Feedback
                        </a>
                    </div>

                    <!-- 🔽 Nút mới: Shipping -->
                    <div class="mt-3 text-center">
                        <a href="${pageContext.request.contextPath}/customer/Shipping.jsp"
                           class="btn btn--primary w-100">
                            Shipping
                        </a>
                    </div>
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