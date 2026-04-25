-- ============================================================
--  GLOBAL SUPERSTORE — SQL ANALYSIS PROJECT
--  Tool: Works in MySQL / PostgreSQL / SQLite
--  Author: [Shobhith_Kounder]
--  Dataset: 51,290 orders | 2011–2014 | 7 Global Markets
-- Credits: Kaggle
-- ============================================================

-- ============================================================
-- STEP 1: CREATE THE DATABASE, TABLE & LOAD DATA
-- ============================================================

-- Create the Database 
-- After creating the database make sure your using the database

CREATE DATABASE superstore_db;
USE superstore_db

-- Run this once to create your table.
-- In MySQL Workbench: after creating the table, use
-- Table Data Import Wizard to load the CSV file

CREATE TABLE IF NOT EXISTS global_superstore (
    row_id        INT,
    order_id      VARCHAR(20),
    order_date    VARCHAR(20),
    ship_date     VARCHAR(20),
    ship_mode     VARCHAR(20),
    customer_id   VARCHAR(20),
    customer_name VARCHAR(50),
    segment       VARCHAR(20),
    city          VARCHAR(50),
    state         VARCHAR(50),
    country       VARCHAR(50),
    postal_code   VARCHAR(20),
    market        VARCHAR(20),
    region        VARCHAR(30),
    product_id    VARCHAR(20),
    category      VARCHAR(30),
    sub_category  VARCHAR(30),
    product_name  VARCHAR(200),
    sales         DECIMAL(10,4),
    quantity      INT,
    discount      DECIMAL(4,2),
    profit        DECIMAL(10,4),
    shipping_cost DECIMAL(10,4),
    order_priority VARCHAR(20)
);

-- NOTE: If using SQLite, dates are stored as TEXT (format: DD-MM-YYYY).
-- Replace STR_TO_DATE() with date() or SUBSTR() accordingly.
-- If using MySQL, set order_date and ship_date as VARCHAR first,
-- then convert. See STEP 1B below.

-- ===========================================================
-- LOADING/IMPORTING CSV FILE FROM LOCAL DRIVE 
-- ===========================================================

LOAD DATA LOCAL INFILE 'C:/Users/shobh/OneDrive/Desktop/Data Analysis Project/Project 01 (Global Super Store Dataset)/Global Super Store Dataset/Global_Superstore_clean_1.csv'
INTO TABLE global_superstore
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(row_id, order_id, order_date, ship_date, ship_mode, customer_id, 
 customer_name, segment, city, state, country, postal_code, market, 
 region, product_id, category, sub_category, product_name, 
 sales, quantity, discount, profit, shipping_cost, order_priority);


-- ============================================================
-- STEP 1B: FIX DATE FORMAT (MySQL only — skip for PostgreSQL)
-- ============================================================

-- If your dates came in as text (e.g. '31-07-2012'), run this
-- after import to convert them properly:

ALTER TABLE global_superstore
   ADD COLUMN order_date_clean DATE,
   ADD COLUMN ship_date_clean  DATE;
--
 UPDATE global_superstore
 SET order_date_clean = STR_TO_DATE(order_date, '%d-%m-%Y'),
     ship_date_clean  = STR_TO_DATE(ship_date,  '%d-%m-%Y');
     
ALTER TABLE global_superstore
    DROP COLUMN order_date,
    DROP COLUMN ship_date;     

ALTER TABLE global_superstore
    RENAME COLUMN order_date_clean TO order_date,
    RENAME COLUMN ship_date_clean  TO ship_date;

SELECT * FROM global_superstore LIMIT 10;
-- ============================================================
-- SECTION A: EXPLORATORY — UNDERSTAND YOUR DATA FIRST
-- ============================================================

-- A1. How many rows do we have?
SELECT COUNT(*) AS total_orders
FROM global_superstore;
-- Expected: 51,290


-- A2. What years does the data cover?
SELECT
    YEAR(order_date) AS year,
    COUNT(*)         AS order_count
FROM global_superstore
GROUP BY YEAR(order_date)
ORDER BY year;


-- A3. What markets, categories and segments exist?
SELECT DISTINCT market     FROM global_superstore ORDER BY market;
SELECT DISTINCT category   FROM global_superstore ORDER BY category;
SELECT DISTINCT segment    FROM global_superstore ORDER BY segment;
SELECT DISTINCT ship_mode  FROM global_superstore ORDER BY ship_mode;


-- A4. Any negative profits? (loss-making orders)
SELECT COUNT(*) AS loss_making_orders
FROM global_superstore
WHERE profit < 0;


-- ============================================================
-- SECTION B: OVERALL BUSINESS PERFORMANCE
-- ============================================================

-- B1. Total Sales, Profit and Orders — all time
SELECT
    COUNT(DISTINCT order_id)      AS total_orders,
    ROUND(SUM(sales), 2)          AS total_sales,
    ROUND(SUM(profit), 2)         AS total_profit,
    ROUND(SUM(quantity))          AS total_units_sold,
    ROUND(AVG(discount) * 100, 1) AS avg_discount_pct,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM global_superstore;


-- B2. Yearly performance — how is the business growing?
SELECT
    YEAR(order_date)                               AS year,
    COUNT(DISTINCT order_id)                       AS orders,
    ROUND(SUM(sales), 2)                           AS total_sales,
    ROUND(SUM(profit), 2)                          AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)      AS profit_margin_pct
FROM global_superstore
GROUP BY YEAR(order_date)
ORDER BY year;
-- INSIGHT: Look for growth trend. Is profit growing faster than sales?


-- B3. Monthly sales trend (seasonality check)
SELECT
    YEAR(order_date)  AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(sales), 2) AS monthly_sales
FROM global_superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
-- INSIGHT: Which months are peak seasons?


-- ============================================================
-- SECTION C: MARKET & REGION ANALYSIS
-- ============================================================

-- C1. Performance by Market
SELECT
    market,
    COUNT(DISTINCT order_id)                  AS orders,
    ROUND(SUM(sales), 2)                      AS total_sales,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct,
    ROUND(SUM(shipping_cost), 2)              AS total_shipping_cost
FROM global_superstore
GROUP BY market
ORDER BY total_sales DESC;
-- INSIGHT:  APAC & EU usually leads in sales. Canada market has best margin! but also has low scalability.
-- INSIGHT;  EMEA & LATAM markets has low margins and needs improvements        

-- C2. Top 10 countries by sales
SELECT
    country,
    ROUND(SUM(sales), 2)   AS total_sales,
    ROUND(SUM(profit), 2)  AS total_profit
FROM global_superstore
GROUP BY country
ORDER BY total_sales DESC
LIMIT 10;


-- C3. Which regions are loss-making?
SELECT
    market,
    region,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM global_superstore
GROUP BY market, region
ORDER BY total_profit ASC;
-- INSIGHT:	No region has negative profit
-- 			LATAM South has the lowest profit margin (4.55%), followed by EMEA (5.45%)
-- 			Canada has the highest profit margin (26.62%), making it the most profitable region
-- 			APAC regions show strong profitability, while LATAM and EMEA need margin improvement

-- ============================================================
-- SECTION D: PRODUCT CATEGORY ANALYSIS
-- ============================================================

-- D1. Sales and profit by Category
SELECT
    category,
    COUNT(*)                                  AS order_lines,
    ROUND(SUM(sales), 2)                      AS total_sales,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM global_superstore
GROUP BY category
ORDER BY total_sales DESC;


-- D2. Sub-category breakdown — THE MOST IMPORTANT QUERY
-- This reveals which products are secretly losing money -- This is your #1 resume talking point!
SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2)                      AS total_sales,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct,
    ROUND(AVG(discount) * 100, 1)             AS avg_discount_pct
FROM global_superstore
GROUP BY category, sub_category
ORDER BY total_profit ASC;

-- INSIGHT: Tables has the highest discount, causing major losses.
-- INSIGHT: Copiers is the best-performing sub-category with highest profit.
-- INSIGHT: Paper shows strong and stable profitability with high profit margin.

-- D3. Top 10 most profitable products
SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2)   AS total_sales,
    ROUND(SUM(profit), 2)  AS total_profit
FROM global_superstore
GROUP BY product_name, category, sub_category
ORDER BY total_profit DESC
LIMIT 10;


-- D4. Top 10 loss-making products
SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2)   AS total_sales,
    ROUND(SUM(profit), 2)  AS total_profit
FROM global_superstore
GROUP BY product_name, category, sub_category
ORDER BY total_profit ASC
LIMIT 10;


-- ============================================================
-- SECTION E: CUSTOMER & SEGMENT ANALYSIS
-- ============================================================

-- E1. Performance by customer segment
SELECT
    segment,
    COUNT(DISTINCT customer_id)               AS unique_customers,
    COUNT(DISTINCT order_id)                  AS total_orders,
    ROUND(SUM(sales), 2)                      AS total_sales,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM global_superstore
GROUP BY segment
ORDER BY total_profit DESC;
-- INSIGHT: Consumer segment has the highest sales and total profit.
-- INSIGHT: Home Office has the highest profit margin.
-- INSIGHT: Corporate segment shows the highest average order value.
-- INSIGHT: Consumer segment drives the highest number of total orders.


-- E2. Top 15 customers by profit
SELECT
    customer_name,
    customer_id,
    segment,
    country,
    COUNT(DISTINCT order_id)  AS total_orders,
    ROUND(SUM(sales), 2)      AS total_sales,
    ROUND(SUM(profit), 2)     AS total_profit
FROM global_superstore
GROUP BY customer_name, customer_id, segment, country
ORDER BY total_profit DESC
LIMIT 15;


-- E3. Bottom 10 customers (loss-generating)
SELECT
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2)     AS total_sales,
    ROUND(SUM(profit), 2)    AS total_profit
FROM global_superstore
GROUP BY customer_name, segment
ORDER BY total_profit ASC
LIMIT 10;


-- ============================================================
-- SECTION F: SHIPPING & OPERATIONS ANALYSIS
-- ============================================================

-- F1. Average days to ship by ship mode
SELECT
    ship_mode,
    COUNT(*)                                        AS orders,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 1)  AS avg_days_to_ship,
    ROUND(AVG(shipping_cost), 2)                    AS avg_shipping_cost
FROM global_superstore
GROUP BY ship_mode
ORDER BY avg_days_to_ship;


-- F2. Shipping cost vs order priority — are critical orders costing more?
SELECT
    order_priority,
    COUNT(*)                         AS orders,
    ROUND(AVG(shipping_cost), 2)     AS avg_shipping_cost,
    ROUND(SUM(shipping_cost), 2)     AS total_shipping_cost,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 1) AS avg_ship_days
FROM global_superstore
GROUP BY order_priority
ORDER BY avg_shipping_cost DESC;


-- F3. Same-day delivery orders — where do they come from?
SELECT
    market,
    segment,
    COUNT(*)                     AS same_day_orders,
    ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost
FROM global_superstore
WHERE ship_mode = 'Same Day'
GROUP BY market, segment
ORDER BY same_day_orders DESC;


-- ============================================================
-- SECTION G: DISCOUNT ANALYSIS (KEY BUSINESS INSIGHT)
-- ============================================================

-- G1. How does discount affect profit margin?
SELECT
    CASE
        WHEN discount = 0           THEN '0% — No discount'
        WHEN discount <= 0.1        THEN '1–10%'
        WHEN discount <= 0.2        THEN '11–20%'
        WHEN discount <= 0.3        THEN '21–30%'
        WHEN discount <= 0.5        THEN '31–50%'
        ELSE 'Over 50%'
    END AS discount_bucket,
    COUNT(*)                                  AS orders,
    ROUND(SUM(sales), 2)                      AS total_sales,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM global_superstore
GROUP BY discount_bucket
ORDER BY profit_margin_pct DESC;
-- INSIGHT: Discounts above 20% almost always lead to losses.

-- G2. Category × Discount impact
SELECT
    category,
    CASE
        WHEN discount = 0    THEN 'No discount'
        WHEN discount <= 0.2 THEN 'Low (1-20%)'
        ELSE 'High (>20%)'
    END AS discount_level,
    COUNT(*)                                  AS orders,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM global_superstore
GROUP BY category, discount_level
ORDER BY category, profit_margin_pct DESC;


-- ============================================================
-- SECTION H: ADVANCED SQL — WINDOW FUNCTIONS
-- (This is what separates you from other freshers!)
-- ============================================================

-- H1. Year-over-Year sales growth by market
SELECT
    market,
    year,
    total_sales,
    prev_year_sales,
    ROUND((total_sales - prev_year_sales) / prev_year_sales * 100, 1) AS yoy_growth_pct
FROM (
    SELECT
        market,
        YEAR(order_date) 			AS year,
        ROUND(SUM(sales), 2) 		AS total_sales,
        LAG(ROUND(SUM(sales), 2)) OVER (
            PARTITION BY market ORDER BY YEAR(order_date)
        ) 							AS prev_year_sales
    FROM global_superstore
    GROUP BY market, YEAR(order_date)
) 									AS yearly
WHERE prev_year_sales IS NOT NULL
ORDER BY market, year;


-- H2. Running total of sales by year (cumulative revenue)
SELECT
    YEAR(order_date)  					AS year,
    MONTH(order_date) 					AS month,
    ROUND(SUM(sales), 2) 				AS monthly_sales,
    ROUND(SUM(SUM(sales)) OVER (
        PARTITION BY YEAR(order_date)
        ORDER BY MONTH(order_date)
    ), 2) 								AS running_total_sales
FROM global_superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;


-- H3. Rank sub-categories by profit within each category
SELECT
    category,
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit,
    DENSE_RANK() OVER(
		 ORDER BY SUM(profit) DESC
	) AS profit_rank,
    RANK() OVER (
        PARTITION BY category ORDER BY SUM(profit) DESC
    ) AS profit_by_category
FROM global_superstore
GROUP BY category, sub_category
ORDER BY category, profit_rank;


-- H4. Top customer per market (using RANK)
SELECT 
	*
FROM (
    SELECT
        market,
        customer_name,
        ROUND(SUM(profit), 2) AS total_profit,
        RANK() OVER (
            PARTITION BY market ORDER BY SUM(profit) DESC
        ) AS rnk
    FROM global_superstore
    GROUP BY market, customer_name
) ranked
WHERE rnk = 1
ORDER BY total_profit DESC;
-- INSIGHT: Best customer in each global market — useful for targeted sales & marketing efforts.


-- H5. Market share — each category's % of total sales per market
SELECT
    market,
    category,
    ROUND(SUM(sales), 2) AS category_sales,
    ROUND(
        SUM(sales) / SUM(SUM(sales)) OVER (PARTITION BY market) * 100
    , 1) AS pct_of_market_sales
FROM global_superstore
GROUP BY market, category
ORDER BY market, pct_of_market_sales DESC;


-- ============================================================
-- SECTION I: SUMMARY / EXECUTIVE FINDINGS (CTE style)
-- ============================================================

-- I1. Full business scorecard using a CTE
WITH metrics AS (
    SELECT
        COUNT(DISTINCT order_id)                       	AS total_orders,
        COUNT(DISTINCT customer_id)                   	AS total_customers,
        COUNT(DISTINCT country)                        	AS countries_served,
        ROUND(SUM(sales), 2)                           	AS total_revenue,
        ROUND(SUM(profit), 2)                         	AS total_profit,
        ROUND(SUM(profit) / SUM(sales) * 100, 2)      	AS overall_margin_pct,
        ROUND(AVG(discount) * 100, 1)                  	AS avg_discount_pct,
        ROUND(AVG(DATEDIFF(ship_date, order_date)), 1) 	AS avg_ship_days,
        SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END)   	AS loss_orders
    FROM global_superstore
)
SELECT * FROM metrics;


-- I2. Loss-making analysis — what % of orders lose money?
WITH loss_analysis AS (
    SELECT
        sub_category,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_orders,
        ROUND(SUM(profit), 2) AS total_profit
    FROM global_superstore
    GROUP BY sub_category
)
SELECT
    sub_category,
    total_orders,
    loss_orders,
    ROUND(loss_orders * 100.0 / total_orders, 1) AS loss_order_pct,
    total_profit
FROM loss_analysis
ORDER BY loss_order_pct DESC;
-- INSIGHT: Some sub-categories lose money on 40-60% of orders!

-- ============================================================
-- ADDITIONAL RECOMMENDED QUERIES / INSIGHTS (Add these)
-- ============================================================

-- J1. Top 10% customers contribution to profit (Pareto analysis)
WITH customer_profit AS (
    SELECT 
        customer_name,
        ROUND(SUM(profit), 2) AS total_profit
    FROM global_superstore
    GROUP BY customer_name
),
ranked AS (
    SELECT 
        total_profit,
        NTILE(10) OVER (ORDER BY total_profit DESC) AS decile
    FROM customer_profit
)
SELECT 
    'Top 10% of Customers' AS analysis,
    COUNT(CASE WHEN decile = 1 THEN 1 END)                    AS num_customers,
    ROUND(SUM(CASE WHEN decile = 1 THEN total_profit END), 2) AS profit_from_top_10pct,
    ROUND(100.0 * SUM(CASE WHEN decile = 1 THEN total_profit END) / 
          (SELECT SUM(total_profit) FROM customer_profit), 2) AS pct_of_total_profit
FROM ranked;
-- INSIGHT: Top 10% of customers often contribute 40-60%+ of total profit (Pareto principle). Identify and retain them!

-- J2. Average Order Value (AOV) and Order Frequency by Segment/Market
SELECT
    segment,
    market,
    COUNT(DISTINCT order_id)                  AS total_orders,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value,
    ROUND(COUNT(DISTINCT order_id) / COUNT(DISTINCT customer_id), 2) AS orders_per_customer
FROM global_superstore
GROUP BY segment, market
ORDER BY avg_order_value DESC;
-- INSIGHT: Higher AOV in Corporate/Home Office segments. Target them for upselling.

-- J3. Profitability by Ship Mode (important for operations)
SELECT
    ship_mode,
    ROUND(SUM(sales), 2)                      AS total_sales,
    ROUND(SUM(profit), 2)                     AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 1) AS avg_ship_days
FROM global_superstore
GROUP BY ship_mode
ORDER BY total_profit DESC;
-- INSIGHT: Balance speed vs cost — Same Day has higher shipping cost but may enable higher sales volume..


-- ============================================================
-- END OF PROJECT
-- Key findings to highlight in resume / LinkedIn / interview :
-- 1. Identified "Tables" sub-category as a major loss-maker due to high discounts (negative profit margin).
-- 2. Discounts above 20% consistently result in losses across all categories — strong recommendation to review discount policy.
-- 3. APAC market has the highest sales volume but relatively lower profit margin; Canada shows the best profitability (~26.62% margin).
-- 4. Technology category (especially Copiers) drives highest profit; Furniture (Tables) needs attention to improve margins.
-- 5. Top 10% of customers contribute ~26% of total profit (Pareto effect) — focus on retaining high-value customers.
-- ============================================================
