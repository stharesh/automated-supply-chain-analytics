-- =========================================================
-- Automated Supply Chain Analytics
-- Database Schema
-- =========================================================

-- Customer dimension
CREATE TABLE dim_customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(150),
    city VARCHAR(150),
    currency VARCHAR(10)
);


-- Product dimension
CREATE TABLE dim_products (
    product_id BIGINT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price_INR NUMERIC(12,2),
    price_USD NUMERIC(12,2)
);


-- Customer order fulfillment targets
CREATE TABLE dim_targets_orders (
    customer_id INTEGER PRIMARY KEY,
    "ontime_target%" INTEGER,
    "infull_target%" INTEGER,
    "otif_target%" INTEGER,

    FOREIGN KEY (customer_id)
        REFERENCES dim_customers(customer_id)
);


-- Detailed order-line fact table
CREATE TABLE fact_order_line (
    order_id VARCHAR(50),
    order_placement_date DATE,
    customer_id INTEGER,
    product_id BIGINT,
    order_qty INTEGER,
    agreed_delivery_date DATE,
    actual_delivery_date DATE,
    delivery_qty INTEGER,
    "In Full" INTEGER,
    "On Time" INTEGER,
    "On Time In Full" INTEGER,

    FOREIGN KEY (customer_id)
        REFERENCES dim_customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES dim_products(product_id)
);


-- Order-level fulfillment aggregate
CREATE TABLE fact_aggregate (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id INTEGER,
    order_placement_date DATE,
    on_time INTEGER,
    in_full INTEGER,
    otif INTEGER,

    FOREIGN KEY (customer_id)
        REFERENCES dim_customers(customer_id)
);