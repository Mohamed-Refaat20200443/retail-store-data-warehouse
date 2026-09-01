use Retail_Store ;

-- =========================
-- Customers
-- =========================
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    registration_date DATE
);

-- =========================
-- Stores
-- =========================
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    region VARCHAR(50),
    store_type VARCHAR(20) CHECK (store_type IN ('Store','Online'))
);

-- =========================
-- Categories
-- =========================
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- =========================
-- Products
-- =========================
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    unit_cost DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
);

-- =========================
-- Orders
-- =========================
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_channel VARCHAR(20)
        CHECK (order_channel IN ('Store','Online')),
    order_status VARCHAR(20)
        CHECK (order_status IN ('Pending','Completed','Cancelled')),

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (store_id)
        REFERENCES Stores(store_id)
);

-- =========================
-- Order Items
-- =========================
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

-- =========================
-- Returns
-- =========================
CREATE TABLE Returns (
    return_id INT PRIMARY KEY,
    order_item_id INT NOT NULL,
    return_date DATE,
    refund_amount DECIMAL(10,2),
    reason VARCHAR(200),

    FOREIGN KEY (order_item_id)
        REFERENCES Order_Items(order_item_id)
);


INSERT INTO Customers (customer_id, first_name, last_name, email, phone, registration_date) VALUES
(1, 'Ahmed',  'Hassan',   'ahmed.hassan@mail.com',  '01011112222', '2023-01-15'),
(2, 'Sara',   'Mostafa',  'sara.mostafa@mail.com',  '01022223333', '2023-02-20'),
(3, 'Omar',   'Khaled',   'omar.khaled@mail.com',   '01033334444', '2023-03-05'),
(4, 'Mona',   'Ali',      'mona.ali@mail.com',      '01044445555', '2023-04-10'),
(5, 'Youssef','Ibrahim',  'youssef.ibrahim@mail.com','01055556666','2023-05-25'),
(6, 'Nour',   'Adel',     'nour.adel@mail.com',     '01066667777', '2023-06-30'),
(7, 'Karim',  'Fathy',    'karim.fathy@mail.com',   '01077778888', '2023-07-14'),
(8, 'Laila',  'Sami',     'laila.sami@mail.com',    '01088889999', '2023-08-19');



INSERT INTO Stores (store_id, store_name, city, region, store_type) VALUES
(1, 'Downtown Branch',   'Cairo',        'Cairo',       'Store'),
(2, 'Nasr City Branch',  'Cairo',        'Cairo',       'Store'),
(3, 'Alexandria Branch', 'Alexandria',   'Alexandria',  'Store'),
(4, 'Online Store',      'N/A',          'National',    'Online');
 

 INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen'),
(4, 'Sports & Outdoors');


INSERT INTO Products (product_id, product_name, category_id, unit_price, unit_cost) VALUES
(1, 'Wireless Mouse',        1, 250.00,  120.00),
(2, 'Bluetooth Headphones',  1, 950.00,  500.00),
(3, 'Men''s T-Shirt',        2, 180.00,  70.00),
(4, 'Women''s Jacket',       2, 650.00,  300.00),
(5, 'Non-Stick Frying Pan',  3, 320.00,  150.00),
(6, 'Coffee Maker',          3, 1200.00, 650.00),
(7, 'Yoga Mat',              4, 220.00,  90.00),
(8, 'Running Shoes',         4, 1100.00, 550.00);



INSERT INTO Orders (order_id, customer_id, store_id, order_date, order_channel, order_status) VALUES
(1, 1, 1, '2024-01-05 10:30:00', 'Store',  'Completed'),
(2, 2, 4, '2024-01-06 14:15:00', 'Online', 'Completed'),
(3, 3, 2, '2024-01-08 09:00:00', 'Store',  'Completed'),
(4, 4, 4, '2024-01-10 18:45:00', 'Online', 'Pending'),
(5, 1, 4, '2024-01-12 11:20:00', 'Online', 'Completed'),
(6, 5, 3, '2024-01-15 16:00:00', 'Store',  'Cancelled'),
(7, 6, 4, '2024-01-18 13:10:00', 'Online', 'Completed'),
(8, 7, 1, '2024-01-20 10:00:00', 'Store',  'Completed'),
(9, 8, 4, '2024-01-22 20:30:00', 'Online', 'Completed'),
(10,3, 2, '2024-01-25 12:00:00', 'Store',  'Completed');
 

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1,  1, 1, 2, 250.00),
(2,  1, 3, 1, 180.00),
(3,  2, 2, 1, 950.00),
(4,  3, 5, 1, 320.00),
(5,  3, 6, 1, 1200.00),
(6,  4, 7, 3, 220.00),
(7,  5, 4, 1, 650.00),
(8,  5, 8, 1, 1100.00),
(9,  6, 1, 1, 250.00),
(10, 7, 2, 2, 950.00),
(11, 8, 3, 4, 180.00),
(12, 9, 6, 1, 1200.00),
(13, 9, 7, 2, 220.00),
(14, 10,8, 1, 1100.00);
 

INSERT INTO Returns (return_id, order_item_id, return_date, refund_amount, reason) VALUES
(1, 2,  '2024-01-09', 180.00, 'Wrong size'),
(2, 6,  '2024-01-16', 660.00, 'Order cancelled before shipping'),
(3, 11, '2024-01-24', 180.00, 'Item damaged on arrival');




UPDATE Orders
SET order_status = 'Completed'
WHERE order_id = 4;
 

UPDATE Products
SET unit_price = 1050.00,
    unit_cost  = 560.00
WHERE product_id = 2;


UPDATE Customers
SET phone = '01099998888'
WHERE customer_id = 9;


UPDATE Returns
SET refund_amount = 150.00,
    reason = 'Item damaged on arrival - partial refund after inspection'
WHERE return_id = 3;


INSERT INTO Orders 
(order_id, customer_id, store_id, order_date, order_channel, order_status)
VALUES
(11, 2, 1, '2025-01-05 11:30:00', 'Store',  'Completed'),
(12, 5, 4, '2025-02-10 15:20:00', 'Online', 'Completed'),
(13, 1, 3, '2025-03-18 12:10:00', 'Store',  'Completed'),
(14, 8, 4, '2025-04-22 19:30:00', 'Online', 'Completed'),
(15, 6, 2, '2025-06-15 09:45:00', 'Store',  'Cancelled'),
(16, 3, 4, '2025-08-01 17:00:00', 'Online', 'Completed'),
(17, 7, 1, '2025-10-12 13:25:00', 'Store',  'Completed'),
(18, 4, 4, '2025-12-20 21:00:00', 'Online', 'Completed');

INSERT INTO Order_Items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(15, 11, 2, 1, 1050.00),
(16, 11, 7, 2, 220.00),

(17, 12, 6, 1, 1200.00),
(18, 12, 3, 3, 180.00),

(19, 13, 5, 2, 320.00),
(20, 13, 8, 1, 1100.00),

(21, 14, 4, 1, 650.00),
(22, 14, 2, 1, 1050.00),

(23, 15, 1, 2, 250.00),

(24, 16, 6, 1, 1200.00),
(25, 16, 7, 2, 220.00),

(26, 17, 3, 5, 180.00),
(27, 17, 5, 1, 320.00),

(28, 18, 8, 2, 1100.00),
(29, 18, 2, 1, 1050.00);


INSERT INTO Orders 
(order_id, customer_id, store_id, order_date, order_channel, order_status)
VALUES
(19, 1, 4, '2026-01-10 14:00:00', 'Online', 'Completed'),
(20, 2, 1, '2026-02-05 10:15:00', 'Store', 'Completed'),
(21, 5, 3, '2026-03-12 16:40:00', 'Store', 'Completed'),
(22, 8, 4, '2026-04-20 20:30:00', 'Online', 'Completed'),
(23, 6, 2, '2026-05-18 11:00:00', 'Store', 'Pending'),
(24, 7, 4, '2026-06-25 18:20:00', 'Online', 'Completed'),
(25, 3, 1, '2026-07-15 09:30:00', 'Store', 'Completed');


INSERT INTO Order_Items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(30, 19, 2, 1, 1050.00),
(31, 19, 6, 1, 1200.00),

(32, 20, 1, 3, 250.00),
(33, 20, 3, 2, 180.00),

(34, 21, 8, 1, 1100.00),
(35, 21, 7, 2, 220.00),

(36, 22, 4, 2, 650.00),
(37, 22, 2, 1, 1050.00),

(38, 23, 5, 1, 320.00),

(39, 24, 6, 2, 1200.00),
(40, 24, 3, 1, 180.00),

(41, 25, 8, 1, 1100.00),
(42, 25, 1, 2, 250.00);

INSERT INTO Returns
(return_id, order_item_id, return_date, refund_amount, reason)
VALUES
(4, 18, '2025-02-15', 540.00, 'Customer changed mind'),
(5, 23, '2025-06-20', 500.00, 'Product issue'),
(6, 27, '2025-10-20', 320.00, 'Wrong product'),

(7, 31, '2026-01-20', 1200.00, 'Damaged item'),
(8, 36, '2026-04-25', 650.00, 'Wrong size'),
(9, 41, '2026-07-20', 1100.00, 'Customer request');


