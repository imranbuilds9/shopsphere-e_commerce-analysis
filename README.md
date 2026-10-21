# ShopSphere — E-commerce Sales Analysis

## Project Overview
ShopSphere is a fictional e-commerce database project built using PostgreSQL. It demonstrates relational database design, data integrity, data quality validation, and SQL-based business analysis.

## Objectives
- Design a relational database for an online store.
- Implement primary keys, foreign keys, and data constraints.
- Create interconnected sample data.
- Validate data quality and referential integrity.
- Analyze sales performance and customer behavior using SQL.
- Develop business insights and recommendations.

## Business Summary

ShopSphere generated a total of **₹6,66,090 in revenue from completed orders**. The Electronics category accounted for **₹5,86,600 (88.07%)** of completed revenue, indicating a high concentration of revenue in a single category. This dependence could expose the business to risk if demand for electronics declines. ShopSphere should monitor Electronics performance and explore opportunities to increase revenue from other categories.

Repeat customers contributed **87.76% of total completed revenue**, highlighting their importance to the business. ShopSphere should investigate customer retention strategies to encourage repeat purchases and maintain this revenue contribution.

**Laptop Pro 14 generated the highest gross profit, at ₹72,000**, among the products analyzed. ShopSphere should review the product's sales performance, profit margins, and demand before making inventory decisions.

### Limitations

- The dataset is small and fictional, so the findings cannot reliably represent real-world customer or market behaviour.
- The gross-profit calculation uses current product costs for historical orders, which may not match the actual costs at the time of sale. Therefore, calculated gross profit may differ from actual historical gross profit.


## Tools Used

- PostgreSQL
- pgAdmin
- SQL
- Git and GitHub

## Database Schema

The database contains four related tables:

1. **customers**
   - Stores customer details and registration dates.
   - Primary key: customer_id

2. **products**
   - Stores product names, categories, prices, and costs.
   - Primary key: product_id

3. **orders**
   - Stores customer orders, order dates, and order statuses.
   - Primary key: order_id
   - Foreign key: customer_id references customers.customer_id

4. **order_items**
   - Stores the products included in each order, their quantities, and recorded unit prices.
   - Composite primary key: (order_id, product_id)
   - Foreign key: order_id references orders.order_id
   - Foreign key: product_id references products.product_id

### Table Relationships
- One customer can place multiple orders.
- Each order belongs to one customer.
- One order can contain multiple products.
- One product can appear in multiple orders.
- The order_items table connects orders and products.


## Dataset
The project uses fictional sample data stored in PostgreSQL.

| Table - Number of Records |
| Customers - 12 |
| Products - 12 |
| Orders - 24 |
| Order items - 48 |


## Project Structure

The repository contains the following files and folders:

- LICENSE — Project license.
- README.md — Main project documentation.
- data/ — Folder reserved for sample data files.
  - README.md — Information about the sample dataset.
- SQL/ — Folder containing SQL scripts.
  - 01_create_tables.sql — Creates the database tables and constraints.
  - 02_insert_sample_data.sql — Inserts fictional sample records.
  - 03_data_quality_checks.sql — Contains data quality validation queries.


## Data Quality

Validation includes:

- Row-count verification
- Missing-value checks
- Duplicate detection
- Foreign-key and referential-integrity checks
- Valid-value checks
- Date-consistency checks
- Database constraint inspection

## How to Run

1. Create a PostgreSQL database named `shopsphere`.
2. Open the SQL scripts in pgAdmin or another PostgreSQL-compatible SQL editor.
3. Execute the scripts in numerical order, starting with `01_create_tables.sql`.
4. Review the results of `03_data_quality_checks.sql`.

**Important:** These scripts are intended for a fresh database. Do not rerun the table-creation or data-insertion scripts against an already populated database without resetting it appropriately.

## Project Progress

## Project Progress

- [x] Database schema created
- [x] Sample data inserted
- [x] Data quality checks performed
- [x] Sales and revenue analysis
- [x] Product profitability analysis
- [x] Customer behavior and repeat-customer analysis
- [x] Business insights and recommendations
- [ ] Final SQL script organization and documentation review

## Notes
ShopSphere and all customer, product, and order records are fictional and intended for educational and portfolio demonstration purposes.
