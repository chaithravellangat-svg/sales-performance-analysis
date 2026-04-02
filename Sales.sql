-- ================================
-- SALES PERFORMANCE ANALYSIS
-- ================================

-- Use database
USE sales_project;

-- Preview data
SELECT * 
FROM train 
LIMIT 10;

-- Total number of records
SELECT COUNT(*) AS total_records 
FROM train;

-- ================================
-- DATA CLEANING
-- ================================

-- Disable safe updates (temporary)
SET SQL_SAFE_UPDATES = 0;

-- Convert Order Date from text to DATE format
UPDATE train
SET order_date_clean = STR_TO_DATE(`Order Date`, '%d/%m/%Y');

-- Verify date conversion
SELECT `Order Date`, order_date_clean 
FROM train 
LIMIT 5;

-- ================================
-- SALES ANALYSIS
-- ================================

-- 1. Sales by Region
SELECT 
    Region, 
    SUM(Sales) AS total_sales
FROM train
GROUP BY Region
ORDER BY total_sales DESC;

-- 2. Sales by Category
SELECT 
    Category, 
    SUM(Sales) AS total_sales
FROM train
GROUP BY Category
ORDER BY total_sales DESC;

-- 3. Monthly Sales Trend
SELECT 
    DATE_FORMAT(order_date_clean, '%Y-%m') AS month,
    SUM(Sales) AS monthly_sales
FROM train
GROUP BY month
ORDER BY month;

-- ================================
-- CUSTOMER ANALYSIS
-- ================================

-- Top 10 Customers by Sales
SELECT 
    `Customer Name`,
    SUM(Sales) AS total_spent
FROM train
GROUP BY `Customer Name`
ORDER BY total_spent DESC
LIMIT 10;