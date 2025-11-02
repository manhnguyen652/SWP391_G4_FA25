<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Chi tiết sách - Staff Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4F46E5;
                --primary-dark: #4338CA;
                --success-color: #10B981;
                --warning-color: #F59E0B;
                --danger-color: #EF4444;
                --light-bg: #F9FAFB;
                --border-color: #E5E7EB;
            }
            body {
                font-family: 'Inter', sans-serif;
                background: var(--light-bg);
            }
            .staff-header {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                color: white;
                padding: 1.5rem 0;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .detail-card {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-top: 2rem;
            }
            .detail-section {
                margin-bottom: 2rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid var(--border-color);
            }
            .detail-section:last-child {
                border-bottom: none;
            }
            .detail-label {
                font-weight: 600;
                color: #6B7280;
                font-size: 0.875rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                margin-bottom: 0.5rem;
            }
            .detail-value {
                font-size: 1.125rem;
                color: #111827;
                font-weight: 500;
            }
            .badge-modern {
                padding: 0.375rem 0.75rem;
                border-radius: 6px;
                font-weight: 500;
                font-size: 0.75rem;
            }
            .btn-modern {
                border-radius: 8px;
                padding: 0.625rem 1.25rem;
                font-weight: 500;
            }
        </style>
    </head>

    <body>
        <!-- Header -->
        <header class="staff-header">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <a href="home" class="text-white text-decoration-none">
                        <i class="fas fa-book-open me-2"></i><strong>BookStore Management</strong>
                    </a>
                    <a href="book-management" class="btn btn-light btn-sm">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="container my-4">
            <div class="detail-card">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">
                        <i class="fas fa-info-circle me-2"></i>Chi tiết sách
                    </h2>
                    <div class="d-flex gap-2">
                        <a href="book-management?action=edit&bookId=${book.BId}" class="btn btn-warning btn-modern">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa
                        </a>
                        <a href="book-management" class="btn btn-secondary btn-modern">
                            <i class="fas fa-list me-2"></i>Danh sách
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="detail-section">
                            <div class="detail-label">Tên sách</div>
                            <div class="detail-value">${book.BTitle}</div>
                        </div>

                        <div class="detail-section">
                            <div class="detail-label">Mô tả</div>
                            <div class="detail-value">${book.description != null && not empty book.description ? book.description : 'Không có mô tả'}</div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="detail-section">
                                    <div class="detail-label">Năm xuất bản</div>
                                    <div class="detail-value">${book.publicationYear}</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="detail-section">
                                    <div class="detail-label">Giá</div>
                                    <div class="detail-value">
                                        <strong><fmt:formatNumber value="${book.price}" type="number" maxFractionDigits="0"/> ₫</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="detail-section">
                                    <div class="detail-label">Tồn kho</div>
                                    <div class="detail-value">
                                        <c:choose>
                                            <c:when test="${book.stock == 0}">
                                                <span class="badge badge-danger badge-modern">Hết hàng</span>
                                            </c:when>
                                            <c:when test="${book.stock < 10}">
                                                <span class="badge badge-warning badge-modern">${book.stock} (Sắp hết)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-success badge-modern">${book.stock}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="detail-section">
                            <div class="detail-label">Tác giả</div>
                            <div class="detail-value">${book.authorName}</div>
                        </div>

                        <div class="detail-section">
                            <div class="detail-label">Danh mục</div>
                            <div class="detail-value">${book.categoryName}</div>
                        </div>

                        <div class="detail-section">
                            <div class="detail-label">Nhà xuất bản</div>
                            <div class="detail-value">${book.publisherName}</div>
                        </div>

                        <div class="detail-section">
                            <div class="detail-label">Đã bán</div>
                            <div class="detail-value">
                                <span class="badge badge-info badge-modern">${soldCount}</span>
                            </div>
                        </div>

                        <div class="detail-section">
                            <div class="detail-label">Trạng thái</div>
                            <div class="detail-value">
                                <c:choose>
                                    <c:when test="${book.stock == 0}">
                                        <span class="badge badge-danger badge-modern">Hết hàng</span>
                                    </c:when>
                                    <c:when test="${book.stock < 10}">
                                        <span class="badge badge-warning badge-modern">Sắp hết</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-success badge-modern">Còn hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <c:if test="${isInOrder}">
                            <div class="alert alert-warning mt-3">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                Sách này đang có trong đơn hàng, không thể xóa!
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
