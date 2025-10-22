-- Tạo cơ sở dữ liệu mới (tùy chọn, bạn có thể chạy script trong một DB đã có)
create database BookStoreDB;
-- Sử dụng cơ sở dữ liệu vừa tạo
USE BookStoreDB;
GO

-- Bảng lưu các quyền hạn (ví dụ: Admin, User)
CREATE TABLE permission (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL
);
GO

-- Bảng lưu các trạng thái của đơn hàng (ví dụ: Đang xử lý, Đã giao, Đã hủy)
CREATE TABLE status (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL
);
GO

-- Bảng lưu thông tin nhà xuất bản
CREATE TABLE publishers (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL,
    addr NVARCHAR(255),
    phone NVARCHAR(255)
);
GO

-- Bảng lưu thông tin tác giả
CREATE TABLE authors (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL,
    bio NVARCHAR(255) -- Biography
);
GO

-- Bảng lưu danh mục sách
CREATE TABLE category (
    id INT PRIMARY KEY IDENTITY(1,1),
    cate_name NVARCHAR(255) NOT NULL
);
GO

-- Bảng tài khoản người dùng
CREATE TABLE account (
    u_id INT PRIMARY KEY IDENTITY(1,1),
    u_email NVARCHAR(255) NOT NULL UNIQUE,
    u_pass NVARCHAR(255) NOT NULL,
    permission_id INT,
    f_name NVARCHAR(255),
    l_name NVARCHAR(255),
    dob DATE,
    FOREIGN KEY (permission_id) REFERENCES permission(id)
);
GO

-- Bảng thông tin chi tiết của người dùng
CREATE TABLE user_information (
    id INT PRIMARY KEY IDENTITY(1,1),
    phone NVARCHAR(255),
    country NVARCHAR(255),
    zip_code NVARCHAR(255),
    addr NVARCHAR(255),
    u_id INT UNIQUE, -- Mỗi tài khoản chỉ có một thông tin chi tiết
    FOREIGN KEY (u_id) REFERENCES account(u_id)
);
GO

-- Bảng sách
CREATE TABLE books (
    b_id INT PRIMARY KEY IDENTITY(1,1),
    b_title NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    publication_year INT,
    price DECIMAL(18, 2) NOT NULL,
    stock INT NOT NULL,
    p_id INT, -- publisher_id
    a_id INT, -- author_id
    c_id INT, -- category_id
    FOREIGN KEY (p_id) REFERENCES publishers(id),
    FOREIGN KEY (a_id) REFERENCES authors(id),
    FOREIGN KEY (c_id) REFERENCES category(id)
);
GO

-- Bảng hình ảnh của sách (một sách có thể có nhiều ảnh)
CREATE TABLE book_images (
    id INT PRIMARY KEY IDENTITY(1,1),
    img_url NVARCHAR(255) NOT NULL,
    b_id INT,
    FOREIGN KEY (b_id) REFERENCES books(b_id)
);
GO

-- Bảng đơn hàng
CREATE TABLE [order] ( -- "order" là từ khóa trong SQL, nên đặt trong dấu ngoặc vuông
    id INT PRIMARY KEY IDENTITY(1,1),
    u_id INT,
    total_amount DECIMAL(18, 2),
    create_date DATETIME DEFAULT GETDATE(),
    status_id INT,
    FOREIGN KEY (u_id) REFERENCES account(u_id),
    FOREIGN KEY (status_id) REFERENCES status(id)
);
GO

-- Bảng chi tiết đơn hàng (các sản phẩm trong một đơn hàng)
CREATE TABLE order_details (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    b_id INT,
    quantity INT,
    price_per_item DECIMAL(18, 2),
    FOREIGN KEY (order_id) REFERENCES [order](id),
    FOREIGN KEY (b_id) REFERENCES books(b_id)
);
GO

-- Bảng giỏ hàng
CREATE TABLE cart (
    id INT PRIMARY KEY IDENTITY(1,1),
    u_id INT UNIQUE, -- Mỗi người dùng có một giỏ hàng
    FOREIGN KEY (u_id) REFERENCES account(u_id)
);
GO

-- Bảng các sản phẩm trong giỏ hàng
CREATE TABLE cart_items (
    id INT PRIMARY KEY IDENTITY(1,1),
    cart_id INT,
    b_id INT,
    quantity INT,
    FOREIGN KEY (cart_id) REFERENCES cart(id),
    FOREIGN KEY (b_id) REFERENCES books(b_id)
);
GO

-- Bảng danh sách yêu thích
CREATE TABLE wishlist (
    id INT PRIMARY KEY IDENTITY(1,1),
    u_id INT UNIQUE, -- Mỗi người dùng có một danh sách yêu thích
    FOREIGN KEY (u_id) REFERENCES account(u_id)
);
GO

-- Bảng các sản phẩm trong danh sách yêu thích
CREATE TABLE wishlist_items (
    id INT PRIMARY KEY IDENTITY(1,1),
    wishlist_id INT,
    b_id INT,
    FOREIGN KEY (wishlist_id) REFERENCES wishlist(id),
    FOREIGN KEY (b_id) REFERENCES books(b_id)
);
GO

-- Bảng so sánh sản phẩm
CREATE TABLE compares (
    id INT PRIMARY KEY IDENTITY(1,1),
    u_id INT UNIQUE, -- Mỗi người dùng có một danh sách so sánh
    FOREIGN KEY (u_id) REFERENCES account(u_id)
);
GO

-- Bảng các sản phẩm trong danh sách so sánh
CREATE TABLE compare_item (
    id INT PRIMARY KEY IDENTITY(1,1),
    compare_id INT,
    b_id INT,
    FOREIGN KEY (compare_id) REFERENCES compare(id),
    FOREIGN KEY (b_id) REFERENCES books(b_id)
);
GO

--Bảng feedback
CREATE TABLE feedback (
    id INT PRIMARY KEY IDENTITY(1,1),
    u_id INT NOT NULL,                -- Người gửi feedback
    b_id INT NULL,                    -- (Tùy chọn) Feedback cho sách nào
    content NVARCHAR(MAX) NOT NULL,   -- Nội dung feedback
    created_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT 'pending', -- Trạng thái: pending / approved / rejected
    FOREIGN KEY (u_id) REFERENCES account(u_id),
    FOREIGN KEY (b_id) REFERENCES books(b_id)
);
GO


-- Chèn dữ liệu cho các bảng không có khóa ngoại (bảng gốc)
-- 1. Bảng permission
INSERT INTO permission (name) VALUES
('Admin'),
('User'),
('Staff'),
('Shipper');
GO

-- 2. Bảng status
INSERT INTO status (name) VALUES
(N'Đang chờ xử lý'),
(N'Đã xác nhận'),
(N'Đang giao hàng'),
(N'Đã giao hàng'),
(N'Đã hủy');
GO

-- 3. Bảng publishers
INSERT INTO publishers (name, addr, phone) VALUES
(N'Nhà Xuất Bản Trẻ', N'161B Lý Chính Thắng, Quận 3, TP. HCM', '02839316289'),
(N'Nhà Xuất Bản Kim Đồng', N'55 Quang Trung, Hai Bà Trưng, Hà Nội', '02439434730'),
(N'Bloomsbury Publishing', 'London, UK', '442076315600');
GO

-- 4. Bảng authors
INSERT INTO authors (name, bio) VALUES
(N'Nguyễn Nhật Ánh', N'Một trong những nhà văn thành công nhất viết sách cho tuổi thơ và tuổi mới lớn tại Việt Nam.'),
(N'J.K. Rowling', N'Tác giả người Anh, nổi tiếng với bộ truyện Harry Potter.'),
(N'Paulo Coelho', N'Tiểu thuyết gia người Brasil, tác giả của "Nhà giả kim".');
GO

-- 5. Bảng category
INSERT INTO category (cate_name) VALUES
(N'Văn học thiếu nhi'),
(N'Tiểu thuyết kỳ ảo'),
(N'Phát triển bản thân'),
(N'Khoa học');
GO

-- Chèn dữ liệu cho các bảng phụ thuộc
-- 6. Bảng account
-- LƯU Ý: Trong thực tế, mật khẩu phải được băm (hashed) trước khi lưu.
INSERT INTO account (u_email, u_pass, permission_id, f_name, l_name, dob) VALUES
('admin@bookstore.com', 'admin_password_123', 1, N'Văn', N'Quản trị', '1990-01-15'),
('nguyenvana@example.com', 'user_pass_A', 2, N'An', N'Nguyễn Văn', '1998-05-20'),
('tranthib@example.com', 'user_pass_B', 2, N'Bình', N'Trần Thị', '2001-11-30');
GO

-- 7. Bảng user_information (liên kết với account)
INSERT INTO user_information (phone, country, zip_code, addr, u_id) VALUES
('0987654321', 'Việt Nam', '100000', N'Số 1, Đường ABC, Hà Nội', 2),
('0123456789', 'Việt Nam', '700000', N'Số 2, Đường XYZ, TP.HCM', 3);
GO

-- 8. Bảng books (liên kết với publishers, authors, category)
INSERT INTO books (b_title, description, publication_year, price, stock, p_id, a_id, c_id) VALUES
(N'Cho Tôi Xin Một Vé Đi Tuổi Thơ', N'Một câu chuyện cảm động về tuổi thơ.', 2008, 80000, 100, 1, 1, 1),
(N'Harry Potter và Hòn Đá Phù Thủy', N'Tập đầu tiên của bộ truyện Harry Potter.', 1997, 150000, 50, 3, 2, 2),
(N'Nhà Giả Kim', N'Hành trình đi tìm kho báu của cậu bé chăn cừu Santiago.', 1988, 95000, 75, 1, 3, 3);
GO

-- 9. Bảng book_images (liên kết với books)
INSERT INTO book_images (img_url, b_id) VALUES
('https://example.com/images/ve-di-tuoi-tho.jpg', 1),
('https://example.com/images/harry-potter-1.jpg', 2),
('https://example.com/images/nha-gia-kim.jpg', 3);
GO

-- Chèn dữ liệu cho các giao dịch của người dùng
-- 10. Tạo giỏ hàng và thêm sản phẩm cho người dùng
-- Giả sử người dùng `u_id = 2` (Nguyễn Văn An) có giỏ hàng
INSERT INTO cart (u_id) VALUES (2);
DECLARE @cartIdAn INT = SCOPE_IDENTITY(); -- Lấy ID của giỏ hàng vừa tạo
INSERT INTO cart_items (cart_id, b_id, quantity) VALUES
(@cartIdAn, 2, 1), -- 1 cuốn Harry Potter
(@cartIdAn, 3, 1); -- 1 cuốn Nhà Giả Kim
GO

-- 11. Tạo danh sách yêu thích và thêm sản phẩm
-- Giả sử người dùng `u_id = 3` (Trần Thị Bình) có wishlist
INSERT INTO wishlist (u_id) VALUES (3);
DECLARE @wishlistIdBinh INT = SCOPE_IDENTITY();
INSERT INTO wishlist_items (wishlist_id, b_id) VALUES
(@wishlistIdBinh, 1); -- Thích cuốn 'Cho Tôi Xin Một Vé Đi Tuổi Thơ'
GO

-- 12. Tạo một đơn hàng đã hoàn thành
-- Giả sử người dùng `u_id = 2` (Nguyễn Văn An) đã đặt một đơn hàng trước đây
INSERT INTO [order] (u_id, total_amount, create_date, status_id) VALUES
(2, 80000, '2025-09-20 10:30:00', 4); -- status_id = 4 (Đã giao hàng)
DECLARE @orderIdAn INT = SCOPE_IDENTITY();
INSERT INTO order_details (order_id, b_id, quantity, price_per_item) VALUES
(@orderIdAn, 1, 1, 80000); -- Đặt 1 cuốn 'Cho Tôi Xin Một Vé Đi Tuổi Thơ'
GO

-- 13. Tạo một đơn hàng đang chờ xử lý
-- Giả sử người dùng `u_id = 3` (Trần Thị Bình) vừa đặt hàng
INSERT INTO [order] (u_id, total_amount, create_date, status_id) VALUES
(3, 245000, GETDATE(), 1); -- status_id = 1 (Đang chờ xử lý)
DECLARE @orderIdBinh INT = SCOPE_IDENTITY();
INSERT INTO order_details (order_id, b_id, quantity, price_per_item) VALUES
(@orderIdBinh, 2, 1, 150000), -- 1 cuốn Harry Potter
(@orderIdBinh, 3, 1, 95000);  -- 1 cuốn Nhà Giả Kim
GO

PRINT 'Sample data inserted successfully.';

--14. Feedback dữ liệu
INSERT INTO feedback (u_id, b_id, content, status)
VALUES 
(2, 1, N"Sách rất hay, đọc lại tuổi thơ!", 'approved'),
(3, 2, N"Chờ sách giao lâu quá!", 'pending'),
(3, 3, N"Chất lượng in ổn, nội dung truyền cảm hứng.", 'approved');
GO
