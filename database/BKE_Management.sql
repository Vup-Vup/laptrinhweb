CREATE DATABASE BKE_Management;
GO
USE BKE_Management;
GO

-- Bảng users
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    user_name VARCHAR(25) NOT NULL,
    user_email VARCHAR(55) NOT NULL UNIQUE,
    user_pass VARCHAR(255) NOT NULL,
    updated_at DATETIME DEFAULT GETDATE(),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng products
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DOUBLE PRECISION NOT NULL,
    product_description TEXT NOT NULL,
    updated_at DATETIME DEFAULT GETDATE(),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng orders
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    updated_at DATETIME DEFAULT GETDATE(),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Bảng order_details
CREATE TABLE order_details (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    updated_at DATETIME DEFAULT GETDATE(),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
go
INSERT INTO users (user_name, user_email, user_pass) VALUES
('Nguyen Van A', 'nguyenvana@example.com', 'password123'),
('Tran Thi B', 'tranthib@example.com', 'password456');

INSERT INTO products (product_name, product_price, product_description) VALUES
('Laptop Dell XPS', 25000000, 'Laptop cao cấp của Dell'),
('iPhone 15 Pro', 30000000, 'Điện thoại flagship của Apple'),
('Tai nghe Sony WH-1000XM5', 8000000, 'Tai nghe chống ồn cao cấp của Sony');

INSERT INTO orders (user_id) VALUES
(1), (2);

INSERT INTO order_details (order_id, product_id) VALUES
(1, 1),
(1, 3),
(2, 2);

go
-- Thêm người dùng mới
INSERT INTO users (user_name, user_email, user_pass) VALUES
('Hoang Minh Khoa', 'hoangminhk@example.com', 'pass111'),
('Dang Thi Lan', 'danglan@example.com', 'pass222'),
('Nguyen Van Tien', 'nguyenvant@example.com', 'pass333'),
('Le Thi Hoa', 'lethih@example.com', 'pass444');

-- Thêm sản phẩm mới
INSERT INTO products (product_name, product_price, product_description) VALUES
('Asus ROG Strix G15', 27000000, 'Laptop gaming mạnh mẽ của Asus'),
('iPad Pro 12.9', 32000000, 'Máy tính bảng cao cấp của Apple'),
('Sony PlayStation 5', 18000000, 'Máy chơi game thế hệ mới của Sony'),
('Bose QuietComfort 45', 9000000, 'Tai nghe chống ồn cao cấp của Bose'),
('LG OLED CX 55 Inch', 35000000, 'TV OLED 4K cao cấp của LG');

-- Tạo đơn hàng mới
INSERT INTO orders (user_id) VALUES
(1), (2), (3), (4), (1);

-- Chi tiết đơn hàng
INSERT INTO order_details (order_id, product_id) VALUES
(1, 1), (1, 3), 
(2, 2), (2, 4), 
(3, 5), 
(4, 1), (4, 2), 
(5, 3), (5, 5);

go
INSERT INTO users (user_name, user_email, user_pass) VALUES
('Minh Anh', 'minhanh@gmail.com', 'pass111'),  -- Bắt đầu bằng 'M', Gmail
('Hoang An', 'hoangan@yahoo.com', 'pass222'),  -- Có chữ 'a'
('Truong Thi Mai', 'truongmai@gmail.com', 'pass333'), -- Gmail, có 'i', dài hơn 5
('Nguyen Van B', 'nguyenvanb@gmail.com', 'pass444'),  -- Gmail, có 'a'
('Mai Hoa', 'maih@mail.com', 'pass555'),  -- Bắt đầu 'M', có 'a'
('Tran Binh', 'tranbinh@gmail.com', 'pass666'), -- Gmail, có 'i', dài hơn 5
('Linh Chi', 'linhchi@gmail.com', 'pass777'), -- Gmail, có 'i', kết thúc 'i'
('Duy Pham', 'duypham@yahoo.com', 'pass888'), -- Có chữ 'a'
('Bao Ngoc', 'baongoc@hotmail.com', 'pass999'), -- Có chữ 'a'
('Ngoc Minh', 'ngocminh@gmail.com', 'pass101') -- Gmail, có 'i'
;

INSERT INTO products (product_name, product_price, product_description) VALUES
('Laptop Dell XPS', 25000000, 'Laptop cao cấp của Dell'),
('iPhone 15 Pro', 30000000, 'Điện thoại flagship của Apple'),
('Tai nghe Sony WH-1000XM5', 8000000, 'Tai nghe chống ồn cao cấp của Sony'),
('Bose QuietComfort 45', 9000000, 'Tai nghe chống ồn cao cấp của Bose'),
('Sony PlayStation 5', 18000000, 'Máy chơi game thế hệ mới của Sony'),
('LG OLED CX 55 Inch', 35000000, 'TV OLED 4K cao cấp của LG'),
('Asus ROG Strix G15', 27000000, 'Laptop gaming mạnh mẽ của Asus'),
('iPad Pro 12.9', 32000000, 'Máy tính bảng cao cấp của Apple');


INSERT INTO orders (user_id) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO order_details (order_id, product_id) VALUES
(1, 1), (1, 3), -- Người dùng 1 mua Laptop Dell XPS, Tai nghe Sony
(2, 2), (2, 4), -- Người dùng 2 mua iPhone 15 Pro, Bose QuietComfort
(3, 5), -- Người dùng 3 mua PlayStation 5
(4, 1), (4, 2), -- Người dùng 4 mua Laptop Dell, iPhone 15 Pro
(5, 3), (5, 5), -- Người dùng 5 mua Tai nghe Sony, PlayStation 5
(6, 6), -- Người dùng 6 mua LG OLED CX 55
(7, 7), (7, 8), -- Người dùng 7 mua Asus ROG, iPad Pro
(8, 4), -- Người dùng 8 mua Bose QuietComfort
(9, 2), -- Người dùng 9 mua iPhone 15 Pro
(10, 8); -- Người dùng 10 mua iPad Pro


