--The dataset consists of 6 interconnected relational tables reflecting web traffic, product performance, and sales data for an e-commerce platform:

--1. website_sessions – Captures incoming traffic sessions, referral channels, and user device data.
--2. pageviews – Logs page hits per session to measure user navigation and funnel performance.
--3. orders – Contains order-level metrics including totals, sales revenue, and primary product IDs.
--4. order_items – Details granular purchase records per item associated with completed orders.
--5. order_item_refunds – Tracks returned inventory and corresponding refund amounts.
--6. products – Serves as the dimensional catalog for product offerings and launch dates.

--Tables i'm working with
SELECT * FROM website_sessions
SELECT * FROM pageviews
SELECT * FROM orders
SELECT * FROM order_items
SELECT * FROM order_item_refunds
SELECT * FROM products

----JOIN QUESTION 
--QUESTION 1 ;how many pages visitors viewed during their website sessions
SELECT
w.website_session_id,
COUNT(p.website_pageview_id) AS number_of_pageview 
FROM pageviews p
JOIN website_sessions w
ON w.website_session_id = p.website_session_id
GROUP BY
w.website_session_id
ORDER BY number_of_pageview DESC 

--Question 2
--which product are being purchased by customers
SELECT
p.product_name,
ROUND(SUM (o.price_usd),2) AS price_paid
FROM products p
JOIN orders o
ON p.product_id =o.primary_product_id
GROUP BY
p.product_name
ORDER BY price_paid DESC

--Question 3
--orders that have received refunds
SELECT
o.order_id,
i.order_item_id,
SUM (r.refund_amount_usd) AS refunded_amount
FROM orders o
JOIN order_items i
ON o.order_id = i.order_id
JOIN order_item_refunds r
ON r.order_item_id = i.order_item_id
GROUP BY
o.order_id,
i.order_item_id,
r.refund_amount_usd
ORDER BY refunded_amount DESC

--Question 4
--find where the order total price is above the average total price 
SELECT
(
	SELECT
	AVG (price_usd) AS average_order_price         
	FROM orders         
)
order_id,
user_id,
price_usd
FROM orders
WHERE price_usd > 59.99
ORDER BY price_usd ASC

--Question 5
--find customers who have placed moe than one order
SELECT 
user_id,
COUNT (order_id) AS orders_placed
FROM orders
GROUP BY
user_id
HAVING COUNT (order_id) > 1
ORDER BY orders_placed DESC

--Question 6
-- how much has each product generated,using CTE
with total_price as (
	SELECT 
	p.product_id,
	p.product_name,
	ROUND(SUM (o.price_usd),2) as total_revenue
	FROM products p
	JOIN order_items o
	ON p.product_id = o.product_id
	GROUP BY
	p.product_id,
	p.product_name 
)
SELECT *
FROM total_price
ORDER BY total_revenue DESC

--Question 7
--identifying only products that gave sold 10 unit
with total_unit_solds as (
	SELECT
	p.product_name,
	p.product_id,
	COUNT (o.price_usd) as number_of_units_sold
	FROM products p
	join order_items o
	ON p.product_id = o.product_id
	GROUP BY
	p.product_id,
	p.product_name
)
SELECT 
product_name,
number_of_units_sold
FROM total_unit_solds
WHERE number_of_units_sold >5000
ORDER BY number_of_units_sold DESC

--Question 8
--which product has sold the most unit
with number_of_unit as (
	SELECT
	p.product_id,
	p.product_name,
	COUNT (o.price_usd) as total_units_sold
	FROM products p
	join order_items o
	ON p.product_id = o.product_id
	GROUP BY 
	p.product_id,
	p.product_name
)
SELECT 
product_name,
total_units_sold
FROM number_of_unit
ORDER BY total_units_sold DESC

--Question 9
--customer who have generated the most average revenue
SELECT
(
		SELECT
		o.order_id,
		o.user_id,
		SUM(o.price_usd) as total_revenue
		FROM orders o
) AS totals_revenue
 (
	SELECT
	t.order_id
	AVG (t.total_revenue) as average_revenue
	FROM totals_revenue 
) AS final_average_revenue
 t.order_id,
 f.average_revenue
 FROM total_revenue t
 JOIN final_average_revenue f
 ON  t.order_id = f.order_id
		GROUP BY
		o.order_id,
		o.user_id
ORDER BY average_revenue DESC

--Question 10
--which products are generating the most refunds
SELECT
p.product_name,
r.number_of_refunded_items,
r.total_refund_amount
FROM refunds_account r
(
	SELECT 
	o.product_id
	COUNT (i.order_item_refund_id) as number_of_refunded_items,
	SUM (i.refund_amount_usd) as total_refund_amount
	FROM order_items o
	join order_item_refund o
	ON o.order_id = i.order_id
	GROUP BY 
	o.product_id
) AS refunds_account
join products p
ON p.product_id = r.product_id
GROUP BY
p.product_name,
r.number_of_refunded_items,
r.total_refund_amount



 








			





