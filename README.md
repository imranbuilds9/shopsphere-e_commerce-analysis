# ShopSphere — E-commerce Sales Analysis

## Project Overview
ShopSphere is a fictional e-commerce database project built using PostgreSQL. The project focuses on relational database design, data integrity, data quality validation, and SQL-based business analysis.

## Objectives
- Design a relational database for an online store.
- Implement primary keys, foreign keys, and data constraints.
- Create realistic, interconnected sample data.
- Validate data quality and referential integrity.
- Develop SQL queries to investigate sales performance and customer behavior in later project stages.

## Tools Used
- PostgreSQL
- pgAdmin
- SQL
- Git and GitHub

## Database Schema
The database contains four tables:

|   Table     |               Description                                |
| customers   | Customer details and registration dates                  |
| products    | Product names, categories, prices, and costs             |
| orders      | Customer orders, dates, and statuses                     |
| order_items | Products, quantities, and prices recorded for each order |

## Project Structure

shopsphere-ecommerce-analysis/
├── README.md
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_insert_sample_data.sql
│   └── 03_data_quality_checks.sql
└── data/
    └── README.md

## Current Progress
- [x] Database schema created
- [x] Sample data inserted
- [x] Data quality checks performed
- [ ] Sales analysis
- [ ] Business insights and recommendations

## Data Quality
Validation includes row counts, missing-value checks, duplicate detection, foreign key relationship checks, valid-value checks, date consistency, and inspection of database constraints.

## How to Run
1. Create a PostgreSQL database named `shopsphere`.
2. Open the SQL scripts in pgAdmin or another PostgreSQL-compatible SQL editor.
3. Execute the scripts in numerical order, starting with `01_create_tables.sql`.
4. Review the results of `03_data_quality_checks.sql`.

The scripts are intended for a fresh database. Do not rerun the table-creation or data-insertion scripts against an already populated database without resetting it appropriately.

## Notes
ShopSphere and its customer, product, and order records are fictional and intended for educational purposes.
