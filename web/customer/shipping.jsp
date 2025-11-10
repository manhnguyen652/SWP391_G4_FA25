<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Shipping Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/plugins.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/customer/css/main.css" />
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/customer/image/favicon.ico">
<style>
    body { background-color: #f9f9f9; }
    .sidebar { background-color: #fff; border-right: 1px solid #ddd; height: 100vh; padding-top: 20px; }
    .sidebar h4 { margin-bottom: 1rem; color: #7bb241; font-weight: 600; }
    .sidebar a { color: #333; text-decoration: none; display: block; padding: 8px 15px; border-radius: 5px; transition: 0.2s; }
    .sidebar a:hover, .sidebar a.active { background-color: #7bb241; color: white; }
    .btn--primary { background-color: #7bb241 !important; color: white !important; border: none; }
    .btn--primary:hover { background-color: #689a36 !important; }
    .table-actions button { margin-right: 5px; }
    .search-bar { display: flex; gap: 10px; margin-bottom: 1rem; }
</style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar">
            <h4>Shipping</h4>
            <a href="shipping" class="${empty param.filter ? 'active' : ''}">All Orders</a>
            <a href="shipping?filter=pending" class="${param.filter == 'pending' ? 'active' : ''}">Pending</a>
            <a href="shipping?filter=shipping" class="${param.filter == 'shipping' ? 'active' : ''}">Shipping</a>
            <a href="shipping?filter=delivered" class="${param.filter == 'delivered' ? 'active' : ''}">Delivered</a>
            <a href="shipping?filter=canceled" class="${param.filter == 'canceled' ? 'active' : ''}">Canceled</a>
        </div>
        <div class="col-md-10 p-4">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-3">
                <h3>Shipping List</h3>
                <form class="search-bar" action="shipping" method="get">
                    <input type="hidden" name="filter" value="${param.filter}">
                    <input type="text" name="q" class="form-control" placeholder="Search customer..." value="${param.q}">
                    <select name="sort" class="form-select">
                        <option value="">Sort by</option>
                        <option value="date_desc" ${param.sort == 'date_desc' ? 'selected' : ''}>Newest</option>
                        <option value="date_asc" ${param.sort == 'date_asc' ? 'selected' : ''}>Oldest</option>
                        <option value="name_asc" ${param.sort == 'name_asc' ? 'selected' : ''}>Customer A-Z</option>
                        <option value="name_desc" ${param.sort == 'name_desc' ? 'selected' : ''}>Customer Z-A</option>
                    </select>
                    <button class="btn btn--primary" type="submit">Search</button>
                </form>
            </div>
            <c:if test="${not empty flash}">
                <div class="alert ${flashType == 'success' ? 'alert-success' : 'alert-danger'}" role="alert">${flash}</div>
            </c:if>
            <div class="row g-3 mb-4">
                <c:set var="counterPending" value="${statusCounters['Pending'] != null ? statusCounters['Pending'] : 0}" />
                <c:set var="counterShipping" value="${statusCounters['Shipping'] != null ? statusCounters['Shipping'] : 0}" />
                <c:set var="counterDelivered" value="${statusCounters['Delivered'] != null ? statusCounters['Delivered'] : 0}" />
                <c:set var="counterCanceled" value="${statusCounters['Canceled'] != null ? statusCounters['Canceled'] : 0}" />
                <div class="col-sm-6 col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <span class="badge bg-warning text-dark mb-2">Pending</span>
                            <h4>${counterPending}</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <span class="badge bg-info text-dark mb-2">Shipping</span>
                            <h4>${counterShipping}</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <span class="badge bg-success mb-2">Delivered</span>
                            <h4>${counterDelivered}</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <span class="badge bg-danger mb-2">Canceled</span>
                            <h4>${counterCanceled}</h4>
                        </div>
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-hover bg-white">
                <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Order</th>
                        <th>Customer</th>
                        <th>Order Date</th>
                        <th>Delivery Date</th>
                        <th>Status</th>
                        <th>Address</th>
                        <th>Paid</th>
                        <th>Shipping Fee</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="rowBase" value="${(currentPage - 1) * pageSize}" />
                    <c:choose>
                        <c:when test="${not empty shipments}">
                            <c:forEach var="shipment" items="${shipments}" varStatus="loop">
                                <tr>
                                    <td>${rowBase + loop.index + 1}</td>
                                    <td>#${shipment.orderId}</td>
                                    <td>${shipment.customerName}</td>
                                    <td><fmt:formatDate value="${shipment.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty shipment.deliveryDate}">
                                                <fmt:formatDate value="${shipment.deliveryDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${shipment.status == 'Pending'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                                            <c:when test="${shipment.status == 'Shipping'}"><span class="badge bg-info text-dark">Shipping</span></c:when>
                                            <c:when test="${shipment.status == 'Delivered'}"><span class="badge bg-success">Delivered</span></c:when>
                                            <c:otherwise><span class="badge bg-danger">Canceled</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${empty shipment.deliveryAddress ? '-' : shipment.deliveryAddress}</td>
                                    <td>${empty shipment.paymentStatus ? '-' : shipment.paymentStatus}</td>
                                    <td><fmt:formatNumber value="${shipment.shippingFee}" type="currency" currencySymbol="₫" /></td>
                                    <td class="table-actions">
                                        <form action="shipping" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="${shipment.id}">
                                            <button name="action" value="start" class="btn btn-sm btn--primary"
                                                ${shipment.status == 'Pending' || shipment.status == 'Confirmed' ? '' : 'disabled'}>Start</button>
                                        </form>
                                        <form action="shipping" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="${shipment.id}">
                                            <button name="action" value="complete" class="btn btn-sm btn-success"
                                                ${shipment.status == 'Shipping' ? '' : 'disabled'}>Complete</button>
                                        </form>
                                        <form action="shipping" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="${shipment.id}">
                                            <button name="action" value="cancel" class="btn btn-sm btn-danger"
                                                ${shipment.status == 'Delivered' || shipment.status == 'Canceled' ? 'disabled' : ''}>Cancel</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="10" class="text-center py-4">Không có đơn hàng phù hợp với tiêu chí hiện tại.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <nav>
                <ul class="pagination">
                    <c:forEach var="p" begin="1" end="${totalPages}">
                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                            <a class="page-link" href="shipping?page=${p}&filter=${param.filter}&q=${param.q}&sort=${param.sort}">${p}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
