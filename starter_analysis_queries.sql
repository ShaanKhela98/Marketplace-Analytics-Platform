-- Total revenue and gross profit
SELECT ROUND(SUM(revenue),2) AS total_revenue, ROUND(SUM(gross_profit),2) AS total_gross_profit, ROUND(SUM(gross_profit)/SUM(revenue),3) AS gross_margin_pct FROM sales;

-- Revenue by category
SELECT c.category_name, ROUND(SUM(s.revenue),2) AS total_revenue, ROUND(SUM(s.gross_profit),2) AS total_gross_profit
FROM sales s JOIN products p ON s.product_id=p.product_id JOIN categories c ON p.category_id=c.category_id
GROUP BY c.category_name ORDER BY total_revenue DESC;

-- Monthly revenue trend
SELECT strftime('%Y-%m', sale_date) AS month, ROUND(SUM(revenue),2) AS monthly_revenue
FROM sales GROUP BY month ORDER BY month;

-- Top products by gross profit
SELECT p.product_name, c.category_name, ROUND(SUM(s.gross_profit),2) AS gross_profit
FROM sales s JOIN products p ON s.product_id=p.product_id JOIN categories c ON p.category_id=c.category_id
GROUP BY p.product_name, c.category_name ORDER BY gross_profit DESC LIMIT 10;

-- Search trends
SELECT search_term, SUM(search_frequency) AS total_searches
FROM search_trends GROUP BY search_term ORDER BY total_searches DESC;
