CREATE DATABASE shopsphere ;

--creating customers table

CREATE TABLE customers (
      customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	  first_name VARCHAR(50) NOT NULL,
	  last_name VARCHAR(50) NOT NULL,
	  email VARCHAR(250) NOT NULL UNIQUE,
	  city VARCHAR(100),
	  signup_date DATE NOT NULL DEFAULT CURRENT_DATE 
);

--creating products table

CREATE TABLE products (
     product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	 product_name VARCHAR(150) NOT NULL,
	 category VARCHAR(100) NOT NULL,
	 price NUMERIC(10,2) NOT NULL CHECK(price>=0),
	 cost NUMERIC(10,2) NOT NULL CHECK(cost>=0)
);

--creating orders table

CREATE TABLE orders (
      order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	  customer_id INT NOT NULL,
	  order_date DATE NOT NULL DEFAULT CURRENT_DATE,
	  status VARCHAR(50) DEFAULT 'Pending' CHECK (status IN ('Pending','Completed','Cancelled','Returned')),
	  CONSTRAINT fk_orders_to_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--creating order_items table

CREATE TABLE order_items (
      order_id INT NOT NULL,
	  product_id INT NOT NULL,
	  quantity INT CHECK(quantity > 0),
	  unit_price NUMERIC(10,2) CHECK(unit_price >= 0),
	  PRIMARY KEY (order_id , product_id),
	  CONSTRAINT fk_items_to_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
	  CONSTRAINT fk_items_to_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--checking if all the tables are created

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
