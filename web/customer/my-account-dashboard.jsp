<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



<div class="container mt-4 mb-5">
    <div class="card shadow-sm p-4" style="border-radius: 12px;">
        <h3 class="text-success mb-3">
            <i class="fa fa-tachometer" aria-hidden="true"></i> Dashboard
        </h3>
        <hr style="border-top: 1px dotted #ccc; margin-bottom: 20px;">

        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <p class="mb-3">
                    Xin chào, 
                    <b>${sessionScope.account.l_name} ${sessionScope.account.f_name}</b> 👋
                </p>

                <p>
                    Từ trang dashboard của tài khoản, bạn có thể dễ dàng:
                </p>
                <ul>
                    <li>Xem và theo dõi các đơn hàng gần đây</li>
                    <li>Quản lý địa chỉ giao hàng và thanh toán</li>
                    <li>Thay đổi mật khẩu hoặc chỉnh sửa thông tin tài khoản</li>
                </ul>

                <a href="${pageContext.request.contextPath}/logout"
                   class="btn btn-success mt-3"
                   style="background:#62ab00; border:none;">
                    <i class="fa fa-sign-out"></i> Đăng xuất
                </a>
            </c:when>      
        </c:choose>
    </div>
</div>


