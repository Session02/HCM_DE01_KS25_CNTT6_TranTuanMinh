CREATE DATABASE sale_management;
USE sale_management;

CREATE TABLE product (
	pro_id VARCHAR (20) PRIMARY KEY,
    pro_name VARCHAR (100) NOT NULL,
    brand VARCHAR (50),
    price DECIMAL (10,2),
    stock INT
);

CREATE TABLE customer (
	customer_id VARCHAR (20) PRIMARY KEY,
    full_name VARCHAR (100) NOT NULL,
    email VARCHAR (100),
    phone VARCHAR (15),
    address VARCHAR (200)
);

CREATE TABLE orders (
	order_id VARCHAR (20) PRIMARY KEY,
    order_date DATE,
    total_amount DECIMAL (10,2),
    customer_id VARCHAR (20),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

CREATE TABLE order_detail (
	order_id VARCHAR (20),
    pro_id VARCHAR (20),
    quantity INT,
    sale_price DECIMAL (10,2),
    PRIMARY KEY (order_id, pro_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
	FOREIGN KEY (pro_id) REFERENCES product (pro_id)
);

INSERT INTO product 
VALUES ('P01', 'Macbook Air M2', 'Apple', 28000000, 10),
('P02', 'Iphone 15 Pro', 'Apple', 25000000, 15),
('P03', 'Chuột logitech', 'Logitech', 25000000, 50),
('P04', 'Bàn phím Akko', 'Akko', 15000000, 20),
('P05', 'Màn hình Dell', 'Dell', 12000000, 8);

INSERT INTO customer
VALUES ('C01', 'Nguyen Van A', 'avn@gmail.com', 0903699666, 'Hà Nội'),
('C02', 'Nguyen Van E', 'evn@gmail.com', 0903799666, 'Hải Phòng'),
('C03', 'Nguyen Van B', 'bvn@gmail.com', 0903599666, 'TP.HCM'),
('C04', 'Nguyen Van C', 'cvn@gmail.com', NULL, 'Đà nẵng'),
('C05', 'Nguyen Van D', 'dvn@gmail.com', NULL, 'Cần Thơ');

INSERT INTO orders 
VALUES ('DH01', '2026-04-20', 28000000, 'C01'),
('DH02', '2026-04-20', 28000000, 'C02'),
('DH03', '2026-04-21', 50000000, 'C03'),
('DH04', '2026-04-22', 85000000, 'C04'),
('DH05', '2026-04-23', 40000000, 'C05');

INSERT INTO order_detail
VALUES ('DH01', 'P01', 1, 28000000),
('DH02', 'P02', 1, 25000000),
('DH03', 'P03', 1, 250000),
('DH04', 'P04', 1, 15000000),
('DH05', 'P05', 1, 12000000);

SET SQL_SAFE_UPDATES = 0;
-- DELETE FROM order_detail;
-- DELETE FROM orders;
-- DELETE FROM customer;
-- DELETE FROM product;

UPDATE product
SET price = price * 1.1
WHERE brand = 'Apple';

DELETE FROM customer
WHERE phone IS NULL;

SELECT *
FROM product 
WHERE price BETWEEN 10000000 AND 20000000;

SELECT p.pro_name
FROM product p
JOIN order_detail od ON p.pro_id = od.pro_id
WHERE od.order_id = 'DH01';

SELECT o.order_id, o.order_date
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE c.address = 'TP.HCM';