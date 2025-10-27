<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">


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
                                    <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Thanh toán</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>
                <main id="content" class="page-section inner-page-sec-padding-bottom space-db--20">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">
                                <!-- Checkout Form s-->
                                <div class="checkout-form">
                                    <div class="row row-40">
                                        <div class="col-12">

                                        </div>
                                        <div class="col-lg-7 mb--20">
                                            <!-- Billing Address -->
                                            <div id="billing-form" class="mb-40">
                                                <h4 class="checkout-title">Địa chỉ thanh toán</h4>
                                                <div class="row">
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Họ*</label>
                                                        <input type="text" placeholder="Họ">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Tên*</label>
                                                        <input type="text" placeholder="Tên">
                                                    </div>

                                                    <div class="col-12 col-12 mb--20">
                                                        <label>Nước*</label>
                                                        <select class="nice-select">
                                                            <option>Bangladesh</option>
                                                            <option>China</option>
                                                            <option>country</option>
                                                            <option>India</option>
                                                            <option>Japan</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Địa chỉ Email*</label>
                                                        <input type="email" placeholder="Địa chỉ Email">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Số điện thoại*</label>
                                                        <input type="text" placeholder="Số điện thoại">
                                                    </div>
                                                    <div class="col-12 mb--20">
                                                        <label>Địa chỉ cụ thể*</label>
                                                        <input type="text" placeholder="Địa chỉ cụ thể">

                                                    </div>

                                                    <div class="col-12 mb--20 ">
                                                        <div class="block-border check-bx-wrapper">
                                                            <div class="check-box">
                                                                <input type="checkbox" id="create_account">
                                                                <label for="create_account">Create an Acount?</label>
                                                            </div>
                                                            <div class="check-box">
                                                                <input type="checkbox" id="shiping_address" data-shipping>
                                                                <label for="shiping_address">Ship to Different Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Shipping Address -->
                                            <div id="shipping-form" class="mb--40">
                                                <h4 class="checkout-title">Shipping Address</h4>
                                                <div class="row">
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>First Name*</label>
                                                        <input type="text" placeholder="First Name">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Last Name*</label>
                                                        <input type="text" placeholder="Last Name">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Email Address*</label>
                                                        <input type="email" placeholder="Email Address">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Phone no*</label>
                                                        <input type="text" placeholder="Phone number">
                                                    </div>
                                                    <div class="col-12 mb--20">
                                                        <label>Company Name</label>
                                                        <input type="text" placeholder="Company Name">
                                                    </div>
                                                    <div class="col-12 mb--20">
                                                        <label>Address*</label>
                                                        <input type="text" placeholder="Address line 1">
                                                        <input type="text" placeholder="Address line 2">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Country*</label>
                                                        <select class="nice-select">
                                                            <option>Bangladesh</option>
                                                            <option>China</option>
                                                            <option>country</option>
                                                            <option>India</option>
                                                            <option>Japan</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Town/City*</label>
                                                        <input type="text" placeholder="Town/City">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>State*</label>
                                                        <input type="text" placeholder="State">
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Zip Code*</label>
                                                        <input type="text" placeholder="Zip Code">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-note-block mt--30">
                                                <label for="order-note">Ghi chú đơn hàng</label>
                                                <textarea id="order-note" cols="30" rows="10" class="order-note"
                                                          placeholder="Ghi chú đơn hàng "></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="row">
                                                <!-- Cart Total -->
                                                <div class="col-12">
                                                    <div class="checkout-cart-total">
                                                        <h2 class="checkout-title">ĐƠN HÀNG CỦA BẠN</h2>
                                                        <h4>Sản phẩm <span>Tổng tiền</span></h4>
                                                        <ul>
                                                        <c:forEach var="item" items="${checkoutItems}">
                                                            <li>
                                                                <span class="left">${item.title} X ${item.quantity}</span> 
                                                                <span class="right"><fmt:formatNumber value="${item.total}" pattern="#,##0" /> VND</span>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>


                                                    <p>Tạm tính <span><fmt:formatNumber value="${checkoutSubTotal}" pattern="#,##0" /> VND</span></p>
                                                    <p>Phí vận chuyển <span><fmt:formatNumber value="${checkoutShippingFee}" pattern="#,##0" /> VND</span></p>
                                                    <h4>Tổng cộng <span><fmt:formatNumber value="${checkoutGrandTotal}" pattern="#,##0" /> VND</span></h4>
                                                    <div class="method-notice mt--25">

                                                    </div>
                                                    <div class="term-block">
                                                        <input type="checkbox" id="accept_terms2">
                                                        <label for="accept_terms2">Tôi đã đọc và chấp nhận các điều khoản và điều kiện
                                                        </label>
                                                    </div>
                                                    <button class="place-order w-100">Thanh toán</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <jsp:include page="./common/brand_slider.jsp"></jsp:include>
        <jsp:include page="./common/footer.jsp"></jsp:include>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/ajax-mail.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>
    </body>


</html>