# Sample Data

The files in this directory are reduced sample datasets included to demonstrate the structure and relationships of the supply-chain analytics model.

They are separate from the full analysis dataset used to generate the KPI results described in the main README.

## Included Files

| File | Purpose |
|---|---|
| `dim_customers_sample.csv` | Customer master data |
| `dim_products_sample.csv` | Product master data |
| `dim_targets_orders_sample.csv` | Customer-level fulfillment targets |
| `fact_order_line_sample.csv` | Detailed order-line transactions |
| `fact_aggregate_sample.csv` | Order-level fulfillment performance |

## Table Grain

- **Order-line fact:** one record per order-product line.
- **Order aggregate fact:** one record per order.

The sample data is intentionally smaller than the dataset used for the full analysis, so running calculations against these files will not reproduce the KPI figures shown in the main README.

The sample files are provided so that the database structure, relationships, and analytical fields can be inspected without exposing the full analysis dataset.
