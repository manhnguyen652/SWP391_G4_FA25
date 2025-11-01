<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Pustok - Thanh toán</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
                                    <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Thanh toán</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>

                <main id="content" class="page-section inner-page-sec-padding-bottom space-db--20">
                    <div class="container">
                        <form action="checkout" method="POST"> 
                            <div class="row">
                                <div class="col-12">
                                    <div class="checkout-form">
                                        <div class="row row-40">
                                            <div class="col-lg-7 mb--20">
                                                <div id="billing-form" class="mb-40">
                                                    <h4 class="checkout-title">Thông tin người nhận</h4>
                                                    <div class="row">

                                                        <div class="col-md-6 col-12 mb--20">
                                                            <label>Họ*</label>
                                                            <input type="text" name="lastName" placeholder="Họ" value="${sessionScope.account.l_name}" required>
                                                    </div>
                                                    <div class="col-md-6 col-12 mb--20">
                                                        <label>Tên*</label>
                                                        <input type="text" name="firstName" placeholder="Tên" value="${sessionScope.account.f_name}" required>
                                                    </div>
                                                    <div class="col-12 mb--20">
                                                        <label>Địa chỉ Email*</label>
                                                        <input type="email" name="email" placeholder="Địa chỉ Email" value="${sessionScope.account.u_email}" required>
                                                    </div>

                                                    <hr>

                                                    <h4 class="checkout-title mt-3">Địa chỉ giao hàng</h4>

                                                    <c:if test="${not empty savedAddresses}">
                                                        <p>Chọn địa chỉ đã lưu:</p>
                                                        <c:forEach var="addr" items="${savedAddresses}" varStatus="loop">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="addressSelection" id="addr_${addr.id}" value="${addr.id}" ${loop.first ? 'checked' : ''}>
                                                                <label class="form-check-label" for="addr_${addr.id}">
                                                                    <strong>${addr.phone}</strong> - ${addr.address}, ${addr.country}
                                                                </label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:if>

                                                    <div class="form-check mt-2">
                                                        <input class="form-check-input" type="radio" name="addressSelection" id="addr_new" value="new" ${empty savedAddresses ? 'checked' : ''}>
                                                        <label class="form-check-label" for="addr_new">
                                                            Sử dụng địa chỉ mới
                                                        </label>
                                                    </div>

                                                    <div id="new-address-form" style="display:none; margin-top: 15px; padding-left: 20px;">
                                                        <h5>Nhập địa chỉ mới</h5>
                                                        <div class="col-12 mb--20">
                                                            <label>Số điện thoại mới*</label>
                                                            <input type="text" class="form-control" name="new_phone" placeholder="Số điện thoại">
                                                        </div>
                                                        <div class="col-12 mb--20">
                                                            <label>Địa chỉ cụ thể mới*</label>
                                                            <input type="text" class="form-control" name="new_address" placeholder="Địa chỉ cụ thể (Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố)">
                                                        </div>
                                                        <div class="col-12 mb--20">
                                                            <label>Nước mới*</label>
                                                            <select class="form-control nice-select" name="new_country">
                                                                <option value="VN" selected>Việt Nam</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="order-note-block mt--30">
                                                <label for="order-note">Ghi chú đơn hàng</label>
                                                <textarea id="order-note" name="orderNote" cols="30" rows="10" class="order-note"
                                                          placeholder="Ghi chú về đơn hàng của bạn..."></textarea>
                                            </div>
                                        </div>

                                        <div class="col-lg-5">
                                            <div class="row">
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
                                                            <p>Bạn sẽ được chuyển hướng đến cổng VNPAY để hoàn tất thanh toán.</p>
                                                        </div>
                                                        <div class="term-block">
                                                            <input type="checkbox" id="accept_terms2" required>
                                                            <label for="accept_terms2">Tôi đã đọc và chấp nhận các điều khoản và điều kiện*</label>
                                                        </div>

                                                        <button type="submit" name="action" value="placeOrder" class="place-order w-100">Đặt hàng (VNPAY)</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </main>
        </div>
        <jsp:include page="./common/brand_slider.jsp"></jsp:include>
        <jsp:include page="./common/footer.jsp"></jsp:include>
        <script src="${pageContext.request.contextPath}/customer/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/ajax-mail.js"></script>
        <script src="${pageContext.request.contextPath}/customer/js/custom.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const newAddressForm = document.getElementById('new-address-form');
                const addressRadios = document.querySelectorAll('input[name="addressSelection"]');
                const newAddressInputs = newAddressForm.querySelectorAll('input, select');

                function toggleNewAddressForm(show) {
                    if (show) {
                        newAddressForm.style.display = 'block';
                        newAddressInputs.forEach(input => input.required = true);
                    } else {
                        newAddressForm.style.display = 'none';
                        newAddressInputs.forEach(input => input.required = false);
                    }
                }

                addressRadios.forEach(radio => {
                    radio.addEventListener('change', function () {
                        toggleNewAddressForm(this.value === 'new');
                    });
                });

                const checkedRadio = document.querySelector('input[name="addressSelection"]:checked');
                if (checkedRadio) {
                    toggleNewAddressForm(checkedRadio.value === 'new');
                }
            });
        </script>
    </body>
</html>