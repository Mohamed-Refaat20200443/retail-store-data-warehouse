--1) Top N Customers by Revenue

SELECT TOP 10
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS Total_Revenue,
    COUNT(DISTINCT f.order_id) AS Total_Orders
FROM Fact_Sales f
JOIN Dim_Customers c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Total_Revenue DESC;


--2) Monthly Revenue Trend

SELECT
    d.year,
    d.month,
    SUM(f.sales_amount) AS Revenue
FROM Fact_Sales f
JOIN Dim_Date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
ORDER BY
    d.year,
    d.month;


--3) Yearly Revenue Trend

SELECT
    d.year,
    SUM(f.sales_amount) AS Revenue
FROM Fact_Sales f
JOIN Dim_Date d
ON f.date_key=d.date_key

GROUP BY d.year
ORDER BY d.year;

--4) Best Products by Category

SELECT
    c.category_name,
    p.product_name,
    SUM(f.quantity) AS Units_Sold,
    SUM(f.sales_amount) AS Revenue
FROM Fact_Sales f
JOIN Dim_Product p
    ON f.product_key = p.product_key
JOIN Dim_Category c
    ON p.category_key = c.category_key
GROUP BY
    c.category_name,
    p.product_name
ORDER BY
    c.category_name,
    Revenue DESC;


--5) Best Products by Region (Store)

WITH ProductRevenue AS
(
    SELECT
        r.region_name,
        p.product_name,
        SUM(f.sales_amount) AS Revenue,
        RANK() OVER
        (
            PARTITION BY r.region_name
            ORDER BY SUM(f.sales_amount) DESC
        ) AS ProductRank
    FROM Fact_Sales f
    JOIN Dim_Product p
        ON f.product_key = p.product_key
    JOIN Dim_Store s
        ON f.store_key = s.store_key
    JOIN Dim_Region r
        ON s.region_key = r.region_key
    GROUP BY
        r.region_name,
        p.product_name
)
SELECT
    region_name,
    product_name,
    Revenue
FROM ProductRevenue
WHERE ProductRank = 1
ORDER BY region_name;

--6) Customer Retention

SELECT

c.customer_id,

c.first_name,

COUNT(DISTINCT d.month) AS Active_Months

FROM Fact_Sales f

JOIN Dim_Customers c

ON f.customer_key=c.customer_key

JOIN Dim_Date d

ON f.date_key=d.date_key

GROUP BY

c.customer_id,

c.first_name

ORDER BY Active_Months DESC;


---7) The customer whose last purchase was more than 90 days ago.

SELECT

c.customer_id,

c.first_name,

MAX(d.full_date) AS Last_Order_Date

FROM Fact_Sales f

JOIN Dim_Customers c

ON f.customer_key=c.customer_key

JOIN Dim_Date d

ON f.date_key=d.date_key

GROUP BY

c.customer_id,

c.first_name

HAVING MAX(d.full_date)
<
DATEADD(day,-90,GETDATE());

---8) Rolling Average (7 Days)


SELECT
    d.full_date,
    SUM(f.sales_amount) AS Daily_Revenue,

    AVG(SUM(f.sales_amount)) OVER
    (
        ORDER BY d.full_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Rolling_Avg

FROM Fact_Sales f
JOIN Dim_Date d
    ON f.date_key = d.date_key

GROUP BY d.full_date
ORDER BY d.full_date;