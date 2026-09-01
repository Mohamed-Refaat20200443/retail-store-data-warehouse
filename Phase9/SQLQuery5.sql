INSERT INTO Retail_Store_DWS.dbo.Dim_Category
(
    category_id,
    category_name
)
SELECT
    category_id,
    category_name
FROM Retail_Store.dbo.Categories;


-----------------------------------------------------------------------------------------------------------
---Dim-Region

INSERT INTO Retail_Store_DWS.dbo.Dim_Region
(
    region_name
)
SELECT DISTINCT
    region
FROM Retail_Store.dbo.Stores;

-----------------------------------------------------------------------------------------------------------------------
-----Dim-Customer
INSERT INTO Retail_Store_DWS.dbo.Dim_Customers
(
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    registration_date,
    start_date,
    end_date,
    is_current
)
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    registration_date,
    GETDATE(),
    NULL,
    1
FROM Retail_Store.dbo.Customers;


-------------------------------------------------------------------------------------------------
----Dim_Product

INSERT INTO Retail_Store_DWS.dbo.Dim_Product
(
    product_id,
    product_name,
    category_key,
    unit_cost
)
SELECT
    p.product_id,
    p.product_name,
    c.category_key,
    p.unit_cost
FROM Retail_Store.dbo.Products p
JOIN Retail_Store_DWS.dbo.Dim_Category c
ON p.category_id = c.category_id;

-----------------------------------------------------------------------------------------------
----Dim_Store

INSERT INTO Retail_Store_DWS.dbo.Dim_Store
(
    store_id,
    store_name,
    city,
    region_key,
    store_type,
    start_date,
    end_date,
    is_current
)
SELECT
    s.store_id,
    s.store_name,
    s.city,
    r.region_key,
    s.store_type,
    GETDATE(),
    NULL,
    1
FROM Retail_Store.dbo.Stores s
JOIN Retail_Store_DWS.dbo.Dim_Region r
ON s.region = r.region_name;
-------------------------------------------------------------------------------
----Dim-Date

USE Retail_Store_DWS;
GO

DECLARE @StartDate DATE = '2024-01-01';
DECLARE @EndDate DATE = '2026-12-31';


WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO Dim_Date
    (
        date_key,
        full_date,
        day,
        month,
        quarter,
        year
    )
    VALUES
    (
        CONVERT(INT, FORMAT(@StartDate,'yyyyMMdd')),
        @StartDate,
        DAY(@StartDate),
        MONTH(@StartDate),
        DATEPART(QUARTER,@StartDate),
        YEAR(@StartDate)
    );


    SET @StartDate = DATEADD(DAY,1,@StartDate);

END;


----------------------------------------------------------------------------------------------------
----Fact_sales


INSERT INTO Retail_Store_DWS.dbo.Fact_Sales
(
    date_key,
    customer_key,
    product_key,
    store_key,
    order_id,
    order_channel,
    quantity,
    unit_price,
    sales_amount,
    cost_amount,
    profit
)
SELECT
    d.date_key,
    c.customer_key,
    p.product_key,
    s.store_key,
    o.order_id,
    o.order_channel,
    oi.quantity,
    oi.unit_price,

    oi.quantity * oi.unit_price AS sales_amount,

    oi.quantity * p.unit_cost AS cost_amount,

    (oi.quantity * oi.unit_price) -
    (oi.quantity * p.unit_cost) AS profit

FROM Retail_Store.dbo.Orders o

JOIN Retail_Store.dbo.Order_Items oi
ON o.order_id = oi.order_id

JOIN Retail_Store_DWS.dbo.Dim_Customers c
ON o.customer_id = c.customer_id
AND c.is_current = 1

JOIN Retail_Store_DWS.dbo.Dim_Product p
ON oi.product_id = p.product_id

JOIN Retail_Store_DWS.dbo.Dim_Store s
ON o.store_id = s.store_id
AND s.is_current = 1

JOIN Retail_Store_DWS.dbo.Dim_Date d
ON CAST(o.order_date AS DATE) = d.full_date;



-----------------------------------------------------------------------------------------------------------------------------
-----Fact-Return

INSERT INTO Retail_Store_DWS.dbo.ReturnFact
(
    date_key,
    customer_key,
    product_key,
    store_key,
    refund_amount,
    return_quantity
)

SELECT

    d.date_key,
    c.customer_key,
    p.product_key,
    s.store_key,

    r.refund_amount,

    oi.quantity


FROM Retail_Store.dbo.Returns r


JOIN Retail_Store.dbo.Order_Items oi
ON r.order_item_id = oi.order_item_id


JOIN Retail_Store.dbo.Orders o
ON oi.order_id = o.order_id


JOIN Retail_Store_DWS.dbo.Dim_Customers c
ON o.customer_id = c.customer_id
AND c.is_current = 1


JOIN Retail_Store_DWS.dbo.Dim_Product p
ON oi.product_id = p.product_id


JOIN Retail_Store_DWS.dbo.Dim_Store s
ON o.store_id = s.store_id
AND s.is_current = 1


JOIN Retail_Store_DWS.dbo.Dim_Date d
ON r.return_date = d.full_date;

