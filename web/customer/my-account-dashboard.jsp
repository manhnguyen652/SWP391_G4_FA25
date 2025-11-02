<%@page contentType="text/html" pageEncoding="UTF-8"%>
<h3>Dashboard</h3>
<hr style="border-top: 1px dotted #ccc; margin-bottom: 20px;">

<p>Hello, <b>${sessionScope.account.l_name} ${sessionScope.account.f_name}</b>!</p>
<p>
    From your account dashboard, you can easily check and view your recent orders,
    manage your shipping and billing addresses, and edit your password and account details.
</p>
<p>
    <a href="${pageContext.request.contextPath}/logout" class="btn" style="background:#62ab00; color:white; padding:8px 16px; border-radius:4px;">
        <i class="fa fa-sign-out"></i> Logout
    </a>
</p>
