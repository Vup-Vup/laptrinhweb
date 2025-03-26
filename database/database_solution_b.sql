﻿--1 Liệt kê các hóa đơn của khách hàng
SELECT u.user_id, u.user_name, o.order_id
FROM users u
JOIN orders o ON u.user_id = o.user_id;

go
--2. Liệt kê số lượng các hóa đơn của khách hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS so_don_hang
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;

--3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT o.order_id, COUNT(od.product_id) AS so_san_pham
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

--4. Liệt kê thông tin mua hàng của người dùng (gom nhóm theo đơn hàng)
SELECT o.user_id, u.user_name, o.order_id, STRING_AGG(p.product_name, ', ') AS danh_sach_san_pham
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY o.user_id, u.user_name, o.order_id
ORDER BY o.order_id;

--5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT TOP 7 u.user_id, u.user_name, COUNT(o.order_id) AS so_luong_don_hang
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY so_luong_don_hang DESC;

--6. Liệt kê 7 người dùng mua sản phẩm có tên 'Samsung' hoặc 'Apple'
SELECT DISTINCT TOP 7 u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%'
ORDER BY u.user_id;

--7. Liệt kê danh sách mua hàng của user bao gồm giá tiền mỗi đơn hàng
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS tong_tien
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;

--8. Liệt kê mỗi user với đơn hàng có giá tiền lớn nhất
SELECT user_id, user_name, order_id, tong_tien
FROM (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS tong_tien,
           RANK() OVER (PARTITION BY u.user_id ORDER BY SUM(p.product_price) DESC) AS rank
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS subquery
WHERE rank = 1;

--9. Liệt kê mỗi user với đơn hàng có giá tiền nhỏ nhất
SELECT user_id, user_name, order_id, tong_tien, so_san_pham
FROM (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS tong_tien, COUNT(od.product_id) AS so_san_pham,
           RANK() OVER (PARTITION BY u.user_id ORDER BY SUM(p.product_price) ASC) AS rank
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS subquery
WHERE rank = 1;
--10. Liệt kê mỗi user với đơn hàng có số sản phẩm nhiều nhất
SELECT user_id, user_name, order_id, tong_tien, so_san_pham
FROM (
    SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) AS tong_tien, COUNT(od.product_id) AS so_san_pham,
           RANK() OVER (PARTITION BY u.user_id ORDER BY COUNT(od.product_id) DESC) AS rank
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) AS subquery
WHERE rank = 1;


