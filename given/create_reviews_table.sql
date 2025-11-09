-- Script để tạo bảng reviews trong database
USE BookStoreDB;
GO

-- Tạo bảng reviews
CREATE TABLE reviews (
    id INT PRIMARY KEY IDENTITY(1,1),
    b_id INT NOT NULL, -- book_id
    u_id INT NOT NULL, -- user_id (account)
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5), -- Đánh giá từ 1-5 sao
    comment NVARCHAR(MAX), -- Nội dung đánh giá
    created_date DATETIME DEFAULT GETDATE(), -- Ngày tạo
    FOREIGN KEY (b_id) REFERENCES books(b_id) ON DELETE CASCADE,
    FOREIGN KEY (u_id) REFERENCES account(u_id) ON DELETE CASCADE
);
GO

-- Tạo index để tối ưu truy vấn
CREATE INDEX idx_reviews_book_id ON reviews(b_id);
CREATE INDEX idx_reviews_user_id ON reviews(u_id);
GO

-- Ràng buộc: Mỗi user chỉ có thể review một sách một lần
CREATE UNIQUE INDEX idx_reviews_unique_user_book ON reviews(u_id, b_id);
GO

