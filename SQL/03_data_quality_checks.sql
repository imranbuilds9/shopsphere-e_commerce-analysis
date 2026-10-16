
--                            **Data quality checks and validation**

--row count

SELECT 'customers' AS table_name ,COUNT(*) AS row_count
FROM customers

UNION ALL 

SELECT 'products', COUNT(*) 
FROM products

UNION ALL 

SELECT 'orders' , COUNT(*) 
FROM orders

UNION ALL 

SELECT 'order_items', COUNT(*)
FROM order_items;


-- check for missing values

-- for customers table 

SELECT COUNT(*) FILTER (WHERE first_name is NULL) AS missing_first_names,
       COUNT(*) FILTER (WHERE last_name is NULL) AS missing_last_names,
	   COUNT(*) FILTER (WHERE email is NULL) AS missing_email,
	   COUNT(*) FILTER (WHERE signup_date is NULL) AS missing_signup_date
FROM customers;

--for products table

SELECT COUNT(*) FILTER (WHERE product_name is NULL) AS missing_product_names,
       COUNT(*) FILTER (WHERE category is NULL) AS missing_category,
	   COUNT(*) FILTER (WHERE price is NULL) AS missing_price,
	   COUNT(*) FILTER (WHERE cost is NULL) AS missing_cost
FROM products;

-- for orders table
SELECT COUNT(*) FILTER (WHERE customer_id is NULL) AS missing_customer_id,
	   COUNT(*) FILTER (WHERE order_date is NULL) AS missing_order_date,
	   COUNT(*) FILTER (WHERE status is NULL) AS missing_status
FROM orders;

--for order_items table
SELECT COUNT(*) FILTER (WHERE product_id is NULL) AS missing_product_id,
       COUNT(*) FILTER (WHERE quantity is NULL) AS missing_quantity,
	   COUNT(*) FILTER (WHERE unit_price is NULL) AS missing_unit_price
FROM order_items;


-- checking primary key and duplicates in email


-- Check for duplicate customer IDs
SELECT customer_id, COUNT(*) AS occurrences
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check for duplicate product IDs
SELECT product_id, COUNT(*) AS occurrences
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check for duplicate order IDs
SELECT order_id, COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Check for duplicate customer emails
SELECT email, COUNT(*) AS occurrences
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

--Validation of foreign key relationships

--orders without a valid customer

select o.order_id , c.customer_id
from orders o
left join customers c on o.customer_id = c.customer_id
where c.customer_id is null;

-- order items without a valid order

SELECT oi.product_id , o.order_id
FROM order_items oi
LEFT JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_id IS NULL;

-- order_item without a vaid product

SELECT oi.order_id , p.product_id
FROM products p
right join order_items oi ON p.product_id = oi.product_id
WHERE p.product_id IS NULL;


-- Data validity and business rules checking

-- checking product prices and cost
SELECT *
FROM products 
WHERE price <0 or cost < 0 or price is null or cost is null ;

-- checking order items quantities and prices
SELECT * 
FROM order_items 
WHERE quantity <= 0 or unit_price <0 or quantity is null or unit_price is null;

-- checking order status
SELECT *
FROM orders 
WHERE status not in ('Completed','Cancelled','Returned','Pending') or status is null;

-- checking if order_date predate customer signup_date(registration)
SELECT o.order_id , o.order_date , c.customer_id , c.signup_date
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id and order_date < signup_date;

-- Inspecting the Data Base constraints


SELECT
    conrelid::regclass AS table_name,
    conname AS constraint_name,
    contype AS constraint_type
FROM pg_constraint
WHERE connamespace = 'public'::regnamespace
  AND conrelid IN (
      'customers'::regclass,
      'products'::regclass,
      'orders'::regclass,
      'order_items'::regclass
  )
ORDER BY table_name, constraint_type, constraint_name;
