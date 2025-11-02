<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><c:choose><c:when test="${not empty book}">Chỉnh sửa sách</c:when><c:otherwise>Thêm sách mới</c:otherwise></c:choose> - Staff Dashboard</title>
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
                --dark-color: #1F2937;
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
            .staff-nav {
                background: white;
                border-bottom: 1px solid var(--border-color);
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }
            .staff-nav .nav-link {
                padding: 1rem 1.5rem;
                color: #6B7280;
                font-weight: 500;
                transition: all 0.3s ease;
                border-bottom: 3px solid transparent;
            }
            .staff-nav .nav-link.active {
                color: var(--primary-color);
                border-bottom-color: var(--primary-color);
                background: var(--light-bg);
            }
            .form-card {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-top: 2rem;
            }
            .form-card .card-header {
                margin-bottom: 2rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid var(--border-color);
            }
            .form-card .card-title {
                font-size: 1.5rem;
                font-weight: 600;
                margin: 0;
            }
            .form-label {
                font-weight: 500;
                color: var(--dark-color);
                margin-bottom: 0.5rem;
            }
            .form-control, .form-select {
                border-radius: 8px;
                border: 1px solid var(--border-color);
                padding: 0.75rem;
                transition: all 0.3s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            }
            .btn-modern {
                border-radius: 8px;
                padding: 0.625rem 1.25rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }
            .btn-primary-modern {
                background: var(--primary-color);
                color: white;
                border: none;
            }
            .btn-primary-modern:hover {
                background: var(--primary-dark);
                color: white;
            }
            .btn-secondary-modern {
                background: #6B7280;
                color: white;
                border: none;
            }
            .required-field::after {
                content: " *";
                color: var(--danger-color);
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

        <!-- Navigation -->
        <nav class="staff-nav">
            <div class="container">
                <ul class="nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="book-management"><i class="fas fa-book me-2"></i>Quản lý sản phẩm</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="container my-4">
            <div class="form-card">
                <div class="card-header">
                    <h2 class="card-title">
                        <i class="fas fa-<c:choose><c:when test="${not empty book}">edit</c:when><c:otherwise>plus</c:otherwise></c:choose> me-2"></i>
                        <c:choose>
                            <c:when test="${not empty book}">Chỉnh sửa sách</c:when>
                            <c:otherwise>Thêm sách mới</c:otherwise>
                        </c:choose>
                    </h2>
                </div>

                <!-- Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Form -->
                <form method="post" action="book-management">
                    <input type="hidden" name="action" value="${not empty book ? 'update' : 'add'}">
                    <c:if test="${not empty book}">
                        <input type="hidden" name="bookId" value="${book.BId}">
                    </c:if>

                    <div class="row">
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label for="title" class="form-label required-field">Tên sách</label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       value="${book.BTitle}" required>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="5">${book.description}</textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="publicationYear" class="form-label required-field">Năm xuất bản</label>
                                        <input type="number" class="form-control" id="publicationYear" name="publicationYear" 
                                               value="${book.publicationYear}" min="1900" max="2100" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="price" class="form-label required-field">Giá (₫)</label>
                                        <input type="number" class="form-control" id="price" name="price" 
                                               value="${book.price}" min="0" step="1000" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="stock" class="form-label required-field">Tồn kho</label>
                                        <input type="number" class="form-control" id="stock" name="stock" 
                                               value="${book.stock}" min="0" required>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="mb-3">
                                <label for="authorId" class="form-label required-field">Tác giả</label>
                                <select class="form-select" id="authorId" name="authorId" required>
                                    <option value="">-- Chọn tác giả --</option>
                                    <c:forEach var="author" items="${authors}">
                                        <option value="${author.id}" ${book.AId == author.id ? 'selected' : ''}>
                                            ${author.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="categoryId" class="form-label required-field">Danh mục</label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" ${book.CId == category.id ? 'selected' : ''}>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="publisherId" class="form-label required-field">Nhà xuất bản</label>
                                <select class="form-select" id="publisherId" name="publisherId" required>
                                    <option value="">-- Chọn nhà xuất bản --</option>
                                    <c:forEach var="publisher" items="${publishers}">
                                        <option value="${publisher.id}" ${book.PId == publisher.id ? 'selected' : ''}>
                                            ${publisher.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="book-management" class="btn btn-secondary-modern btn-modern">
                            <i class="fas fa-times me-2"></i>Hủy
                        </a>
                        <button type="submit" class="btn btn-primary-modern btn-modern">
                            <i class="fas fa-save me-2"></i>Lưu
                        </button>
                    </div>
                </form>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
