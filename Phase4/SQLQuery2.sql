use Retail_Store;


----Query 1 – Top 10 Best-Selling Products

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM Order_Items oi
JOIN Products p
    ON oi.product_id = p.product_id
JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.order_date >= DATEADD(MONTH,-3,GETDATE())
GROUP BY p.product_name
ORDER BY total_quantity DESC;



--Query 2 – Revenue by Sales Channel

SELECT
    o.order_channel,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM Orders o
JOIN Order_Items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_channel;


--Query 3 – Top Spending Customers

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_Items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;



--Query 4 – Sales by Category

SELECT
    c.category_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM Categories c
JOIN Products p
    ON c.category_id = p.category_id
JOIN Order_Items oi
    ON p.product_id = oi.product_id
GROUP BY c.category_name;


--Query 5 – Return Rate by Store

SELECT
    s.store_name,
    COUNT(r.return_id) AS total_returns
FROM Stores s
JOIN Orders o
    ON s.store_id = o.store_id
JOIN Order_Items oi
    ON o.order_id = oi.order_id
LEFT JOIN Returns r
    ON oi.order_item_id = r.order_item_id
GROUP BY s.store_name
ORDER BY total_returns DESC;