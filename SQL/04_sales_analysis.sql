-- =====================================================
-- ShopSphere E-commerce Sales Analysis
-- Database: PostgreSQL
-- Purpose: Analyze sales performance and customer behavior
-- =====================================================

-- SECTION 1 : Overall Revenue Analysis
-- 1) How much revenue we generated from the completed orders ?

SELECT sum(oi.unit_price * oi.quantity) as revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
where o.status = 'Completed';


-- 2) How much revenue did each completed order generate ?

SELECT o.order_id , sum(oi.unit_price * oi.quantity) AS order_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY o.order_id 
ORDER BY order_revenue DESC;

--  SECTION 2: Category Revenue Analysis
-- 3) Which product categories generate the most revenue ?

SELECT p.category , sum(oi.unit_price * oi.quantity) as revenue 
from order_items oi
join orders o on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
where o.status = 'Completed'
group by p.category 
order by revenue DESC;


-- 4) What percentage of our total completed revenue comes from each category ?

SELECT p.category , sum(oi.unit_price * oi.quantity) as revenue 
       ,  round((sum(oi.unit_price * oi.quantity)*100 / sum(sum(oi.unit_price * oi.quantity)) over()),2)
	      as revenue_percentage
from order_items oi
join orders o on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
where o.status = 'Completed'
group by p.category 
order by revenue DESC;

--  SECTION 3: Monthly Sales and Trend Analysis
-- 5) How does our revenue change from month to month ?

SELECT DATE_TRUNC('month',o.order_date)::DATE as revenue_month,
       sum(oi.unit_price * oi.quantity) as revenue
FROM orders o 
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_TRUNC('month',o.order_date) :: DATE
ORDER BY revenue_month;


-- 6) Compared with the previous month, how much did revenue increase or decrease ?

WITH monthly_sales AS (SELECT DATE_TRUNC('month',o.order_date)::DATE as revenue_month,
						       sum(oi.unit_price * oi.quantity) as monthly_revenue
						FROM orders o 
						JOIN order_items oi ON o.order_id = oi.order_id
						WHERE o.status = 'Completed'
						GROUP BY DATE_TRUNC('month',o.order_date) :: DATE
						 ),
		sales_prev_month_revenue AS (SELECT revenue_month, 
		                                monthly_revenue,
										lag(monthly_revenue) over(order by revenue_month) 
										      as prev_month_revenue
		                          from monthly_sales
								  order by revenue_month)
								  
SELECT revenue_month , monthly_revenue , prev_month_revenue,
	   ROUND((monthly_revenue - prev_month_revenue) *100 / 
	             NULLIF(prev_month_revenue,0)::NUMERIC,2) AS mom_growth_percentage
FROM sales_prev_month_revenue
order by revenue_month ;


-- 7) Why was March revenue so much lower than the other months ?

SELECT DATE_TRUNC('month',o.order_date) :: DATE  AS order_month,
       count(DISTINCT o.order_id) AS completed_orders,
	   SUM(oi.unit_price * oi.quantity) as monthly_revenue,
	   ROUND(SUM(oi.unit_price * oi.quantity)/(count(DISTINCT o.order_id)) ,2) as average_revenue_per_order
FROM orders o 
join order_items oi ON o.order_id = oi.order_id 
where o.status = 'Completed'
group by DATE_TRUNC('month',o.order_date) :: DATE
order by order_month ;

-- 8) Which products and quantities contributed to March's low revenue?

SELECT o.order_id,
       o.order_date,
	   p.product_name,
	   p.category,
	   oi.unit_price,
	   oi.quantity,
	   (oi.unit_price * oi.quantity) as item_revenue
FROM orders o 
join order_items oi ON o.order_id = oi.order_id
join products p ON oi.product_id = p.product_id
where o.status= 'Completed' AND order_date >= '2025-03-01' AND order_date <'2025-04-01'
order by order_id , product_name;

--  SECTION 4: Product Performance and Profitability
-- 9) Which individual products contribute the most revenue from completed orders ?

SELECT p.product_name,
       p.category,
	   sum(oi.quantity) as units_sold,
	   sum(oi.quantity * oi.unit_price) as total_revenue
From orders o
join order_items oi ON o.order_id = oi.order_id
join products p ON p.product_id = oi.product_id
where o.status = 'Completed'
group by p.product_id , p.product_name , p.category
order by total_revenue DESC ;


-- 10) Which products generate the most gross profit after accounting for product costs ?
--      Gross Profit= (Unit Price - Unit Cost)* Quantity

SELECT p.product_name ,
       p.category,
	   sum(oi.quantity) as units_sold,
	   sum(oi.unit_price * oi.quantity) as total_revenue,
	   sum(oi.quantity * p.cost) as total_product_cost,
	   sum(oi.quantity * (oi.unit_price - p.cost)) as gross_profit
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
where o.status = 'Completed'
group by p.product_name , p.product_id , p.category
order by gross_profit DESC ; 


-- 11) Which products retain the largest percentage of their revenue after product costs ?
--        Gross Profit Margin % = (gross profit / revenue) * 100

SELECT p.product_name ,
	   sum(oi.unit_price * oi.quantity) as total_revenue,
	   sum(oi.quantity * p.cost) as total_product_cost,
	   sum(oi.quantity * (oi.unit_price - p.cost)) as gross_profit,
	   ROUND(sum(oi.quantity * (oi.unit_price - p.cost))*100 /
	         NULLIF(sum(oi.unit_price * oi.quantity),0),2):: NUMERIC as gross_profit_margin_percentage
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
where o.status = 'Completed'
group by p.product_name , p.product_id
order by gross_profit_margin_percentage DESC ; 

--   SECTION 5: Order Analysis
-- 12) How many orders are Completed, Pending, Cancelled, or Returned, 
--        and what percentage of all orders does each status represent?

SELECT status,
      count(*) as total_orders,
	  round((count(*)*100.0 /sum(count(*)) over()),2)as percentage_of_orders
FROM orders
group by status
order by total_orders DESC ;


-- 13) How much revenue does the business generate, on average, from each completed order ?

SELECT SUM(oi.quantity * oi.unit_price) as total_revenue,
       round(sum(oi.quantity * oi.unit_price)/ nullif(count(distinct o.order_id),0),2) as average_revenue
FROM orders o
join order_items oi ON oi.order_id = o.order_id
where o.status = 'Completed' ;


-- 14) Do larger orders generate more revenue, and how many items does each completed order contain ?

SELECT o.order_id , sum(oi.quantity) as total_quantity , 
       sum(oi.unit_price * oi.quantity) as total_order_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY o.order_id
ORDER BY o.order_id ;


-- 15) Which completed orders contain the most units, regardless of their revenue ?

SELECT o.order_id , sum(oi.quantity) as items_sold 
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY o.order_id
ORDER BY items_sold DESC;

--  SECTION 6: Customer Revenue and Repeat Purchases
-- 16) Which customers contribute the most revenue to ShopSphere ?

SELECT c.customer_id , c.first_name , c.last_name , sum(oi.unit_price * oi.quantity) as total_revenue
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
where o.status = 'Completed'
group by c.customer_id
order by total_revenue DESC ;

-- 17) How many completed orders has each customer placed, and how much revenue have they generated?

SELECT c.customer_id , c.first_name , c.last_name , count(DISTINCT o.order_id) as total_orders,
       sum(oi.unit_price * oi.quantity ) as total_revenue
FROM customers c
join orders o ON c.customer_id = o.customer_id
join order_items oi ON oi.order_id = o.order_id
where o.status = 'Completed'
group by c.customer_id 
order by total_revenue DESC;

-- 18) Which customers spend the most per completed order on average ?

SELECT c.customer_id , c.first_name , c.last_name , count(DISTINCT o.order_id) as total_orders,
       sum(oi.unit_price * oi.quantity ) as total_revenue,
	   ROUND((sum(oi.unit_price * oi.quantity )/ nullif(count(DISTINCT o.order_id),0)),2) 
	         as avg_order_value
FROM customers c
join orders o ON c.customer_id = o.customer_id
join order_items oi ON oi.order_id = o.order_id
where o.status = 'Completed'
group by c.customer_id 
order by avg_order_value DESC;


-- 19) Which customers have made at least two completed orders, and how much revenue have they generated ?

SELECT c.customer_id , c.first_name ,c.last_name ,
       count(distinct o.order_id) as total_orders,
	   sum(oi.unit_price * oi.quantity ) as total_revenue
FROM customers c
join orders o ON c.customer_id = o.customer_id
join order_items oi ON oi.order_id = o.order_id
where o.status = 'Completed'
group by c.customer_id 
having count(distinct o.order_id)>=2
order by total_orders DESC , total_revenue DESC;


-- 20) How much of ShopSphere's completed-order revenue is generated 
--         by customers who have placed at least two completed orders?

WITH cust_revenue AS(SELECT c.customer_id , COUNT(DISTINCT o.order_id) as total_orders,
                            sum(oi.unit_price * oi.quantity) as customer_revenue
					 FROM orders o
					 join order_items oi ON o.order_id = oi.order_id
					 join customers c ON c.customer_id = o.customer_id
					 where o.status = 'Completed'
					 group by c.customer_id
					 order by customer_revenue DESC)
					 
SELECT sum(customer_revenue) FILTER(WHERE total_orders >=2 ) as repeat_customer_revenue,
       sum (customer_revenue) as total_revenue,
	   round(100* sum(customer_revenue) FILTER(WHERE total_orders >=2 )/ 
	            nullif(sum (customer_revenue),0),2) as repeat_cust_revenue_percent
FROM cust_revenue; 

--  SECTION 7: Customer Retention and Segmentation
-- 21) Find customers who have placed orders but have never completed an order
--       to investigate the customer retention.

SELECT c.customer_id , c.first_name , c.last_name , count(o.order_id) as total_orders ,
       count(o.order_id) FILTER(where o.status = 'Completed') as total_completed_orders
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING count(o.order_id) FILTER(where o.status = 'Completed') = 0 AND count(o.order_id) >=1;


-- 22) Which customers exist in the customers table but have no matching record in orders ?

SELECT c.customer_id , c.first_name , c.last_name , count(o.order_id) as total_orders
FROM customers c 
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING count(o.order_id) = 0;


-- 23) What percentage of each customer's orders have been completed ?

SELECT c.customer_id , c.first_name , c.last_name , count(o.order_id) as total_orders ,
       count(o.order_id) FILTER(where o.status = 'Completed') as total_completed_orders,
	   ROUND( count(o.order_id) FILTER(where o.status = 'Completed')*100.0/
	         NULLIF (count(o.order_id),0),2) AS completed_orders_percentage
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC , completed_orders_percentage DESC;


-- 24) How many orders does each customer have in each status — Completed, Pending, Cancelled, and Returned ?

SELECT c.customer_id , c.first_name, c.last_name ,
       count(o.order_id) FILTER (WHERE o.status = 'Completed') as completed_orders,
	   count(o.order_id) FILTER (WHERE o.status = 'Pending') as pending_orders,
	   count(o.order_id) FILTER (WHERE o.status = 'Cancelled') as cancelled_orders,
	   count(o.order_id) FILTER (WHERE o.status = 'Returned') as returned_orders
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
order by c.customer_id;


-- 25) Classify customers based on their total revenue from completed orders ?
--      Use three categories:
--         High Value: total completed revenue of ₹75,000 or more
--         Medium Value: total completed revenue from ₹20,000 up to, but not including, ₹75,000
--         Low Value: total completed revenue below ₹20,000

SELECT c.customer_id , c.first_name ,c.last_name ,
       coalesce(sum(oi.unit_price * oi.quantity) FILTER(where o.status = 'Completed'),0) as total_revenue,
	   case when sum(oi.unit_price * oi.quantity)  FILTER(where o.status = 'Completed') >= 75000 then 'HIGH VALUE'
	        when sum(oi.unit_price * oi.quantity)  FILTER(where o.status = 'Completed') >= 20000
			      and sum(oi.unit_price * oi.quantity)  FILTER(where o.status = 'Completed') < 75000 then 'MEDIUM VALUE'
			ELSE 'LOW VALUE' END AS customer_segment
FROM customers c 
LEFT JOIN orders o ON o.customer_id = c.customer_id 
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id
ORDER BY total_revenue DESC ;

