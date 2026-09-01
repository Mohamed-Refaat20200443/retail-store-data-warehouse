USE Retail_Store_DWS;
GO

-- ------------------------------------------------------------
-- Dim_Date
-- ------------------------------------------------------------
CREATE TABLE Dim_Date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day INT NOT NULL,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

-- ------------------------------------------------------------
-- Dim_Customers
-- ------------------------------------------------------------
CREATE TABLE Dim_Customers (
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    registration_date DATE,
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BIT NOT NULL DEFAULT 1
);

-- ------------------------------------------------------------
-- Dim_Category
-- ------------------------------------------------------------
CREATE TABLE Dim_Category (
    category_key INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT NOT NULL,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- ------------------------------------------------------------
-- Dim_Product
-- ------------------------------------------------------------
CREATE TABLE Dim_Product (
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    category_key INT NOT NULL,
    unit_cost DECIMAL(10,2),

    FOREIGN KEY (category_key)
        REFERENCES Dim_Category(category_key)
);

-- ------------------------------------------------------------
-- Dim_Region
-- ------------------------------------------------------------
CREATE TABLE Dim_Region (
    region_key INT IDENTITY(1,1) PRIMARY KEY,
    region_name VARCHAR(50) NOT NULL UNIQUE
);

-- ------------------------------------------------------------
-- Dim_Store
-- ------------------------------------------------------------
CREATE TABLE Dim_Store (
    store_key INT IDENTITY(1,1) PRIMARY KEY,
    store_id INT NOT NULL,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    region_key INT,
    store_type VARCHAR(20),
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BIT NOT NULL DEFAULT 1,

    FOREIGN KEY (region_key)
        REFERENCES Dim_Region(region_key)
);

-- ------------------------------------------------------------
-- Fact_Sales
-- ------------------------------------------------------------
CREATE TABLE Fact_Sales (
    sales_key INT IDENTITY(1,1) PRIMARY KEY,
    date_key INT NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    store_key INT NOT NULL,
    order_id INT NOT NULL,
    order_channel VARCHAR(20),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    sales_amount DECIMAL(12,2) NOT NULL,
    cost_amount DECIMAL(12,2) NOT NULL,
    profit DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (date_key)
        REFERENCES Dim_Date(date_key),

    FOREIGN KEY (customer_key)
        REFERENCES Dim_Customers(customer_key),

    FOREIGN KEY (product_key)
        REFERENCES Dim_Product(product_key),

    FOREIGN KEY (store_key)
        REFERENCES Dim_Store(store_key)
);

-- ------------------------------------------------------------
-- ReturnFact
-- ------------------------------------------------------------
CREATE TABLE ReturnFact (
    return_key INT IDENTITY(1,1) PRIMARY KEY,
    date_key INT NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    store_key INT NOT NULL,
    refund_amount DECIMAL(10,2) NOT NULL,
    return_quantity INT NOT NULL,

    FOREIGN KEY (date_key)
        REFERENCES Dim_Date(date_key),

    FOREIGN KEY (customer_key)
        REFERENCES Dim_Customers(customer_key),

    FOREIGN KEY (product_key)
        REFERENCES Dim_Product(product_key),

    FOREIGN KEY (store_key)
        REFERENCES Dim_Store(store_key)
);