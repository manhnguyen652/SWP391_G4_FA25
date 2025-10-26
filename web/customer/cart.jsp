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
                                    <li class="breadcrumb-item active">Giỏ hàng</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </section>
                <main class="cart-page-main-block inner-page-sec-padding-bottom">
                    <div class="cart_area cart-area-padding  ">
                        <div class="container">
                            <div class="page-section-title">
                                <h1>Giỏ hàng của bạn</h1>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <form action="cart" method="POST" id="cart-form">
                                        <div class="cart-table table-responsive mb--40">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th class="pro-checkbox text-center">
                                                            <input type="checkbox" id="select-all">
                                                        </th>
                                                        <th class="pro-thumbnail">Ảnh</th>
                                                        <th class="pro-title">Sản phẩm</th>
                                                        <th class="pro-price">Giá</th>
                                                        <th class="pro-quantity">Số lượng</th>
                                                        <th class="pro-subtotal">Tổng</th>
                                                        <th class="pro-remove"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach var="item" items="${cartItems}">
                                                    <tr>
                                                        <td class="pro-checkbox text-center">
                                                            <input type="checkbox" class="item-checkbox" 
                                                                   name="selectedItems" 
                                                                   value="${item.cartItemId}"
                                                                   data-price="${item.price}">
                                                        </td>
                                                        <td class="pro-thumbnail">
                                                            <a href="home?state=detail&bookId=${item.bookId}">
                                                                <img src="customer/image/products/product-1.jpg" alt="Product">
                                                            </a>
                                                        </td>
                                                        <td class="pro-title"><a href="home?state=detail&bookId=${item.bookId}">${item.title}</a></td>
                                                        <td class="pro-price"><span><fmt:formatNumber value="${item.price}" pattern="#,##0" /> VND</span></td>
                                                        <td class="pro-quantity">
                                                            <div class="pro-qty">
                                                                <div class="count-input-block">
                                                                    <input type="number" class="form-control text-center cart-quantity-input" 
                                                                           value="${item.quantity}" 
                                                                           name="quantity_${item.cartItemId}"
                                                                           min="1"
                                                                           data-item-id="${item.cartItemId}">
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="pro-subtotal"><span><fmt:formatNumber value="${item.total}" pattern="#,##0" /> VND</span></td>
                                                        <td class="pro-remove">
                                                            <a href="cart?action=delete&itemId=${item.cartItemId}">
                                                                <i class="far fa-trash-alt"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                            </div>
                            <div class="col-12">
                                <div class="cart-section-2">
                                    <div class="row">
                                        <div class="col-lg-6 col-12 mb--30 mb-lg--0">
                                            <div class="cart-block-title">
                                                <h2> </h2>
                                            </div>
                                            <div class="product-slider sb-slick-slider" data-slick-setting='{
                                                 "autoplay": true,
                                                 "autoplaySpeed": 8000,
                                                 "slidesToShow": 2
                                                 }' data-slick-responsive='[
                                                 {"breakpoint":992, "settings": {"slidesToShow": 2} },
                                                 {"breakpoint":768, "settings": {"slidesToShow": 3} },
                                                 {"breakpoint":575, "settings": {"slidesToShow": 2} },
                                                 {"breakpoint":480, "settings": {"slidesToShow": 1} },
                                                 {"breakpoint":320, "settings": {"slidesToShow": 1} }
                                                 ]'>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-12 d-flex">
                                            <div class="cart-summary">
                                                <div class="cart-summary-wrap">
                                                    <h4><span>Tổng kết giỏ hàng</span></h4>
                                                    <p>Tổng phụ <span class="text-primary"><fmt:formatNumber value="${subTotal}" pattern="#,##0" /> VND</span></p>
                                                    <p>Phí vận chuyển <span class="text-primary">Miễn phí</span></p>
                                                    <h2>Tổng cộng <span class="text-primary" id="selected-total">0 VND</span></h2>
                                                </div>
                                                <div class="cart-summary-button">
                                                    <button type="submit" name="action" value="checkout" class="checkout-btn c-btn btn--primary" form="cart-form">
                                                        Thanh toán
                                                    </button>
                                                    <button type="submit" name="action" value="update" class="update-btn c-btn btn-outlined" form="cart-form">
                                                        Quay lại trang chủ
                                                    </button>
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
                const selectAllCheckbox = document.getElementById('select-all');
                const itemCheckboxes = document.querySelectorAll('.item-checkbox');
                const quantityInputs = document.querySelectorAll('.cart-quantity-input');
                const selectedTotalElement = document.getElementById('selected-total');

                const formatter = new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND',
                    minimumFractionDigits: 0
                });

                function updateSelectedTotal() {
                    let total = 0;
                    document.querySelectorAll('.item-checkbox').forEach(checkbox => {
                        if (checkbox.checked) {
                            const row = checkbox.closest('tr');
                            const price = parseFloat(checkbox.dataset.price);
                            const quantity = parseInt(row.querySelector('.cart-quantity-input').value);

                            if (!isNaN(price) && !isNaN(quantity)) {
                                total += price * quantity;
                            }
                        }
                    });
                    selectedTotalElement.innerText = formatter.format(total).replace(' ₫', ' VND');
                }

                function updateSelectAllCheckbox() {
                    const allCheckboxes = document.querySelectorAll('.item-checkbox');
                    const allChecked = allCheckboxes.length > 0 && Array.from(allCheckboxes).every(cb => cb.checked);
                    selectAllCheckbox.checked = allChecked;
                }

                function updateQuantityInDatabase(itemId, quantity) {
                    fetch('update-cart-quantity', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: new URLSearchParams({
                            'itemId': itemId,
                            'quantity': quantity
                        })
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    console.log('Cập nhật số lượng thành công (ID: ' + itemId + ', SL: ' + quantity + ')');
                                } else {
                                    console.error('Lỗi khi cập nhật số lượng:', data.message);
                                    alert('Lỗi cập nhật số lượng, vui lòng tải lại trang.');
                                }
                            })
                            .catch(error => {
                                console.error('Lỗi fetch:', error);
                                alert('Đã xảy ra lỗi kết nối. Vui lòng tải lại trang.');
                            });
                }

                selectAllCheckbox.addEventListener('change', function () {
                    document.querySelectorAll('.item-checkbox').forEach(checkbox => {
                        checkbox.checked = selectAllCheckbox.checked;
                    });
                    updateSelectedTotal();
                });

                itemCheckboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', function () {
                        updateSelectedTotal();
                        updateSelectAllCheckbox();
                    });
                });

                quantityInputs.forEach(input => {
                    input.addEventListener('change', function () {
                        const row = this.closest('tr');
                        const checkbox = row.querySelector('.item-checkbox');
                        const itemId = this.dataset.itemId;
                        const quantity = parseInt(this.value);
                        const price = parseFloat(checkbox.dataset.price);

                        const rowTotalElement = row.querySelector('.pro-subtotal span');
                        if (rowTotalElement && !isNaN(price) && !isNaN(quantity)) {
                            rowTotalElement.innerText = formatter.format(price * quantity).replace(' ₫', ' VND');
                        }

                        if (checkbox.checked) {
                            updateSelectedTotal();
                        }

                        if (!isNaN(quantity) && itemId) {
                            updateQuantityInDatabase(itemId, quantity);
                        }

                        if (quantity <= 0) {
                            row.remove();
                            updateSelectedTotal();
                            updateSelectAllCheckbox();
                        }
                    });
                });

                updateSelectedTotal();
            });
        </script>
    </body>
</html>