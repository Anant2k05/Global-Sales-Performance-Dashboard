/*
=========================================================
GLOBAL SALES PERFORMANCE ANALYSIS
=========================================================

Project: Global Sales Performance Dashboard

Description:
This file contains SQL queries used for exploratory data
analysis before building the Power BI dashboard.

NOTE:
Query outputs may vary depending on the dataset version
and import configuration.
=========================================================
*/

-- =====================================================
-- 1. Overall Business Summary
-- =====================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_pct,
    ROUND(AVG(discount)*100,2) AS avg_discount_pct
FROM sales;

-- =====================================================
-- 2. Sales by Category
-- =====================================================

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- =====================================================
-- 3. Profit by Category
-- =====================================================

SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_profit DESC;

-- =====================================================
-- 4. Profit Margin by Category
-- =====================================================

SELECT
    category,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM sales
GROUP BY category
ORDER BY profit_margin DESC;

-- =====================================================
-- 5. Sales by Market
-- =====================================================

SELECT
    market,
    ROUND(SUM(sales),2) AS total_sales
FROM sales
GROUP BY market
ORDER BY total_sales DESC;

-- =====================================================
-- 6. Profit by Region
-- =====================================================

SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_profit DESC;

-- =====================================================
-- 7. Top 10 Products by Profit
-- =====================================================

SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- =====================================================
-- 8. Products with High Profit
-- =====================================================

SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM sales
GROUP BY product_name
HAVING SUM(profit) > 10000
ORDER BY total_profit DESC;

-- =====================================================
-- 9. Average Profit for Discounted Orders
-- =====================================================

SELECT
    category,
    ROUND(AVG(profit),2) AS avg_profit
FROM sales
WHERE discount > 0
GROUP BY category
ORDER BY avg_profit DESC;

-- =====================================================
-- 10. Profit Classification using CASE
-- =====================================================

SELECT
    product_name,
    profit,
    CASE
        WHEN profit > 500 THEN 'High Profit'
        WHEN profit > 0 THEN 'Medium Profit'
        ELSE 'Loss'
    END AS profit_status
FROM sales;