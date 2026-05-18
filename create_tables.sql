DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS customer_segments;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS calendar_factors;
DROP TABLE IF EXISTS search_trends;
DROP TABLE IF EXISTS competitor_benchmarks;

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category_id INT REFERENCES categories(category_id),
    cost NUMERIC(10,2),
    retail_price NUMERIC(10,2),
    supplier_name VARCHAR(150),
    gross_margin_pct NUMERIC(6,3)
);

CREATE TABLE customer_segments (
    segment_id INT PRIMARY KEY,
    segment_name VARCHAR(100),
    segment_description TEXT
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    segment_id INT REFERENCES customer_segments(segment_id),
    signup_date DATE,
    region VARCHAR(50)
);

CREATE TABLE calendar_factors (
    calendar_date DATE PRIMARY KEY,
    year INT,
    month INT,
    day_of_week VARCHAR(20),
    season VARCHAR(20),
    is_weekend INT,
    is_holiday INT,
    temperature INT
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE REFERENCES calendar_factors(calendar_date),
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    quantity_sold INT,
    revenue NUMERIC(10,2),
    gross_profit NUMERIC(10,2),
    payment_method VARCHAR(50)
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    inventory_date DATE,
    product_id INT REFERENCES products(product_id),
    stock_level INT,
    reorder_threshold INT,
    units_ordered INT
);

CREATE TABLE search_trends (
    search_id INT PRIMARY KEY,
    search_date DATE REFERENCES calendar_factors(calendar_date),
    search_term VARCHAR(100),
    search_frequency INT
);

CREATE TABLE competitor_benchmarks (
    competitor_id INT PRIMARY KEY,
    competitor_name VARCHAR(100),
    estimated_annual_revenue NUMERIC(12,2),
    avg_gross_margin_pct NUMERIC(6,3),
    top_category VARCHAR(100),
    market_position VARCHAR(150)
);