# Sample Data

## Overview
This folder is reserved for sample data files used in the ShopSphere E-commerce Sales Analysis project.

## Data Source
The project currently uses fictional sample data inserted directly into PostgreSQL using SQL scripts stored in the `sql/` directory.


The dataset contains:

- **12 customers** — customer details and signup dates.
- **12 products** — product names, categories, prices, and costs.
- **24 orders** — order dates, customer references, and order statuses.
- **48 order items** — products purchased, quantities, and unit prices.

## Data Format
Currently, no separate CSV or other data files are required. The sample records are maintained in `sql/02_insert_sample_data.sql`.

## Notes
- All records are fictional and intended for learning and portfolio demonstration.
- Database validation queries are maintained in `sql/03_data_quality_checks.sql`.
- This folder may contain exported datasets in the future if they are needed for additional analysis.