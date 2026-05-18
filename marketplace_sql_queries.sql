-- --------------------------------------------------
-- Marketplace Executive KPI Summary
-- --------------------------------------------------

SELECT
    SUM(revenue) AS total_gmv,
    SUM(gross_profit) AS total_gross_profit,
    AVG(revenue) AS avg_transaction_value,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(*) AS total_transactions
FROM sales;

-- --------------------------------------------------
-- Revenue by Product Category
-- --------------------------------------------------

SELECT
    c.category_name,
    SUM(s.revenue) AS total_gmv,
    SUM(s.gross_profit) AS total_profit
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_gmv DESC;


-- --------------------------------------------------
-- Monthly Marketplace Revenue Trends
-- --------------------------------------------------

SELECT
    DATE_TRUNC('month', sale_date) AS revenue_month,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY revenue_month
ORDER BY revenue_month;


-- --------------------------------------------------
-- Customer Segment Revenue Analysis
-- --------------------------------------------------

SELECT
    cs.segment_name,
    SUM(s.revenue) AS total_revenue,
    AVG(s.revenue) AS avg_transaction_value
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
JOIN customer_segments cs
    ON c.segment_id = cs.segment_id
GROUP BY cs.segment_name
ORDER BY total_revenue DESC;


-- --------------------------------------------------
-- Top Products by Revenue
-- --------------------------------------------------

SELECT
    p.product_name,
    SUM(s.revenue) AS total_revenue
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- --------------------------------------------------
-- Monthly Revenue Growth Analysis (CTE)
-- --------------------------------------------------

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS revenue_month,
        SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY revenue_month
)

SELECT
    revenue_month,
    total_revenue
FROM monthly_sales
ORDER BY revenue_month;


-- --------------------------------------------------
-- Rolling 7-Day Revenue Average
-- --------------------------------------------------

SELECT
    sale_date,
    revenue,
    AVG(revenue) OVER (
        ORDER BY sale_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7_day_avg
FROM sales
ORDER BY sale_date;

-- --------------------------------------------------
-- Product Revenue Ranking
-- --------------------------------------------------

SELECT
    p.product_name,
    SUM(s.revenue) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(s.revenue) DESC
    ) AS revenue_rank
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue_rank;


-- --------------------------------------------------
-- Seasonal Marketplace Performance
-- --------------------------------------------------

SELECT
    cf.season,
    SUM(s.revenue) AS total_revenue,
    SUM(s.gross_profit) AS total_profit
FROM sales s
JOIN calendar_factors cf
    ON s.sale_date = cf.calendar_date
GROUP BY cf.season
ORDER BY total_revenue DESC;


-- --------------------------------------------------
-- Search Demand Analysis
-- --------------------------------------------------

SELECT
    search_term,
    SUM(search_frequency) AS total_search_volume
FROM search_trends
GROUP BY search_term
ORDER BY total_search_volume DESC;