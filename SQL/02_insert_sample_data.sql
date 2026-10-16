-- **inserting data into tables**

--inserting data into customers


INSERT INTO customers (
    first_name,
    last_name,
    email,
    city,
    signup_date
)
VALUES
    ('Aarav', 'Sharma', 'aarav.sharma@example.com', 'Hyderabad', '2025-01-10'),
    ('Priya', 'Reddy', 'priya.reddy@example.com', 'Bengaluru', '2025-01-15'),
    ('Rahul', 'Verma', 'rahul.verma@example.com', 'Mumbai', '2025-02-02'),
    ('Ananya', 'Iyer', 'ananya.iyer@example.com', 'Chennai', '2025-02-18'),
    ('Vikram', 'Patel', 'vikram.patel@example.com', 'Ahmedabad', '2025-03-05'),
    ('Sneha', 'Nair', 'sneha.nair@example.com', 'Kochi', '2025-03-12'),
    ('Arjun', 'Mehta', 'arjun.mehta@example.com', 'Pune', '2025-03-25'),
    ('Kavya', 'Rao', 'kavya.rao@example.com', 'Hyderabad', '2025-04-08'),
    ('Rohan', 'Gupta', 'rohan.gupta@example.com', 'Delhi', '2025-04-20'),
    ('Meera', 'Das', 'meera.das@example.com', 'Kolkata', '2025-05-01'),
    ('Ishaan', 'Kulkarni', 'ishaan.kulkarni@example.com', 'Pune', '2025-05-15'),
    ('Diya', 'Thomas', 'diya.thomas@example.com', 'Kochi', '2025-06-01');

SELECT * FROM customers;

--Inserting data into products

INSERT INTO products (
      product_name,
	  category,
	  price,
	  cost
)
VALUES ('Laptop Pro 14', 'Electronics', 75000.00, 60000.00),
    ('Wireless Mouse', 'Accessories', 1200.00, 650.00),
    ('Mechanical Keyboard', 'Accessories', 3500.00, 2100.00),
    ('Smartphone X', 'Electronics', 45000.00, 36000.00),
    ('USB-C Charger', 'Accessories', 1800.00, 900.00),
    ('Bluetooth Headphones', 'Electronics', 5500.00, 3200.00),
    ('Cotton T-Shirt', 'Clothing', 799.00, 350.00),
    ('Running Shoes', 'Clothing', 2999.00, 1700.00),
    ('Coffee Maker', 'Home Appliances', 4200.00, 2800.00),
    ('Air Fryer', 'Home Appliances', 6500.00, 4300.00),
    ('Smart Watch', 'Electronics', 8500.00, 5200.00),
    ('Laptop Backpack', 'Accessories', 2200.00, 1100.00);

SELECT * FROM products;

-- inserting data into orders

INSERT INTO orders (
       order_id,
	   customer_id,
	   order_date,
	   status
)
OVERRIDING SYSTEM VALUE
VALUES (1001, 1, '2025-01-12', 'Completed'),
    (1002, 2, '2025-01-18', 'Completed'),
    (1003, 1, '2025-01-25', 'Completed'),
    (1004, 3, '2025-02-05', 'Completed'),
    (1005, 4, '2025-02-20', 'Cancelled'),
    (1006, 2, '2025-02-25', 'Completed'),
    (1007, 5, '2025-03-07', 'Completed'),
    (1008, 6, '2025-03-15', 'Completed'),
    (1009, 3, '2025-03-22', 'Returned'),
    (1010, 7, '2025-03-28', 'Completed'),
    (1011, 1, '2025-04-02', 'Completed'),
    (1012, 8, '2025-04-10', 'Completed'),
    (1013, 9, '2025-04-22', 'Pending'),
    (1014, 2, '2025-04-28', 'Completed'),
    (1015, 10, '2025-05-03', 'Completed'),
    (1016, 5, '2025-05-12', 'Completed'),
    (1017, 11, '2025-05-18', 'Cancelled'),
    (1018, 6, '2025-05-22', 'Completed'),
    (1019, 12, '2025-06-03', 'Completed'),
    (1020, 7, '2025-06-08', 'Completed'),
    (1021, 8, '2025-06-12', 'Completed'),
    (1022, 9, '2025-06-18', 'Returned'),
    (1023, 10, '2025-06-22', 'Completed'),
    (1024, 1, '2025-06-28', 'Completed');

SELECT * FROM orders;

--inserting data into order_items

INSERT INTO order_items(
         order_id,
		 product_id,
		 quantity,
		 unit_price
)
VALUES  (1001, 1, 1, 75000.00),
        (1001, 2, 2, 1200.00),
        (1002, 4, 1, 45000.00),
        (1002, 5, 1, 1800.00),
	    (1003, 3, 1, 3500.00),
	    (1003, 6, 1, 5500.00),
	    (1004, 1, 1, 74000.00),
	    (1004, 12, 1, 2200.00),
	    (1005, 7, 2, 799.00),
	    (1005, 8, 1, 2999.00),
	    (1006, 4, 1, 45000.00),
	    (1006, 6, 2, 5300.00),
	    (1007, 9, 1, 4200.00),
	    (1007, 10, 1, 6500.00),
	    (1008, 7, 3, 799.00),
	    (1008, 8, 1, 2999.00),
	    (1009, 11, 1, 8500.00),
	    (1009, 5, 2, 1800.00),
	    (1010, 2, 1, 1200.00),
	    (1010, 3, 1, 3500.00),
	    (1011, 1, 1, 75000.00),
	    (1011, 11, 1, 8500.00),
	    (1012, 4, 1, 44000.00),
	    (1012, 5, 2, 1700.00),
	    (1013, 9, 1, 4200.00),
	    (1013, 10, 1, 6300.00),
	    (1014, 6, 1, 5500.00),
	    (1014, 12, 2, 2200.00),
	    (1015, 7, 2, 799.00),
	    (1015, 8, 1, 2999.00),
	    (1016, 1, 1, 75000.00),
	    (1016, 2, 1, 1200.00),
	    (1017, 4, 1, 45000.00),
	    (1017, 11, 1, 8500.00),
	    (1018, 9, 1, 4000.00),
	    (1018, 10, 1, 6200.00),
	    (1019, 3, 1, 3500.00),
	    (1019, 5, 1, 1800.00),
	    (1020, 7, 1, 799.00),
	    (1020, 8, 2, 2999.00),
	    (1021, 4, 1, 45000.00),
	    (1021, 6, 1, 5500.00),
	    (1022, 11, 1, 8200.00),
	    (1022, 12, 1, 2200.00),
	    (1023, 9, 1, 4200.00),
	    (1023, 10, 1, 6500.00),
	    (1024, 1, 1, 73000.00),
	    (1024, 2, 2, 1100.00);

SELECT * FROM order_items;