# Automated Supply Chain Analytics Pipeline

## Project Overview

This project demonstrates an automated, AI-assisted supply-chain analytics workflow for regional monthly sales and fulfillment data.

Monthly CSV files for multiple regions are received through Gmail. An n8n workflow extracts the files and loads the data into PostgreSQL hosted in Supabase, where it is organized in a fact-and-dimension model.

Quadratic AI connects to the Supabase data for natural-language KPI exploration and customer-fulfillment analysis. During analysis, Quadratic AI can also retrieve live USD-to-INR exchange rates from the Open Exchange Rates API to support currency-normalized comparisons.

> **What this project demonstrates:** automated data ingestion, cloud-hosted PostgreSQL data modeling, AI-assisted analytics, and live external-data enrichment. The reported KPIs and insights were generated in Quadratic AI—not with hand-written analytical SQL queries.

## Project Architecture

```text
Gmail
  |
  | Daily regional sales/order files
  v
n8n Workflow Automation
  |
  | Extract CSV files
  v
PostgreSQL
  |
  | Insert records
  v
Supabase
  |
  +-----------------------------+
  |                             |
  v                             v
Dimension Tables              Fact Tables
  |                             |
  +-- dim_customers             +-- fact_order_line
  +-- dim_products              +-- fact_aggregate
  +-- dim_targets_orders
  |
  v
Quadratic AI + Open Exchange Rates API
  |
  v
KPIs & Business Analysis
  |
  v
Supply Chain Insights
```

## Data Pipeline

### 1. Regional CSV data in Gmail

Regional monthly sales and fulfillment CSV files are received through Gmail.

The automation workflow is triggered when the relevant email arrives.

### 2. Automated CSV Extraction

The workflow extracts the incoming CSV files from the email.

The workflow uses separate extraction and load paths for the incoming data files.

This reduces the manual work of downloading attachments and preparing files for loading.

### 3. PostgreSQL Data Ingestion

The extracted CSV data is inserted into PostgreSQL by the n8n workflow.

This automates the repetitive process of downloading files and manually loading them into the database.

### 4. Supabase

The PostgreSQL database is managed through Supabase.

The analytical model contains five main tables.

## Database Model

### Dimension Tables

#### `dim_customers`

Stores customer master information.

Key attributes:

- Customer ID
- Customer name
- City
- Currency

#### `dim_products`

Stores product master information.

Key attributes:

- Product ID
- Product name
- Category
- Price in INR
- Price in USD

#### `dim_targets_orders`

Stores customer-level fulfillment targets.

Key metrics:

- On-Time target
- In-Full target
- OTIF target

### Fact Tables

#### `fact_order_line`

Contains detailed order-line transaction data.

**Grain:** one record per order-product line.

Key fields include:

- Order ID
- Order placement date
- Customer ID
- Product ID
- Order quantity
- Agreed delivery date
- Actual delivery date
- Delivery quantity
- In-Full indicator
- On-Time indicator
- OTIF indicator

#### `fact_aggregate`

Contains order-level fulfillment performance.

**Grain:** one record per order.

Key fields include:

- Order ID
- Customer ID
- Order placement date
- On-Time indicator
- In-Full indicator
- OTIF indicator

## Supply Chain KPIs

The data was analyzed using Quadratic AI to calculate key supply-chain performance indicators.

| KPI | Definition |
|---|---|
| Total Order Lines | Number of order lines |
| Total Orders | Number of distinct orders |
| Line Fill Rate | Percentage of order lines delivered in full |
| Volume Fill Rate | Delivered quantity divided by ordered quantity |
| On-Time Delivery % | Percentage of orders delivered on time |
| In-Full Delivery % | Percentage of orders delivered in full |
| OTIF % | Percentage of orders delivered both on time and in full |

## Quadratic AI Analysis

Quadratic AI is the analytical layer after the database is populated. It pulls the connected Supabase data and uses natural-language prompts to calculate KPIs and explore business questions.

The project does not claim that the KPI calculations were authored as SQL queries. The analysis was generated in the Quadratic interface using prompts such as:

- What is the overall order fulfillment performance?
- What is the On-Time Delivery percentage?
- What is the In-Full Delivery percentage?
- What is the overall OTIF percentage?
- Which customers have the highest order value?
- Which customers have the lowest OTIF performance?
- Which customers are below their OTIF target?
- Which customers require attention based on fulfillment performance?
- What are the major supply-chain performance gaps?

### Live currency conversion

For cross-region comparisons, a Quadratic prompt uses an app ID from [Open Exchange Rates](https://openexchangerates.org/) to retrieve the live USD-to-INR exchange rate at analysis time. This enables currency-normalized value analysis alongside the operational KPIs.

The app ID is configured in Quadratic and is not stored in this repository. Because the rate is live, converted results can change over time; this project does not claim to maintain a historical exchange-rate snapshot.

## Example Analysis

The Quadratic analysis generated KPIs from the full analysis dataset, which is not the same as the reduced sample dataset committed to this repository. The sample files are provided to demonstrate the data structure and relationships; they do not reproduce the KPI totals below.

The analysis generated KPIs including:

- **Total Order Lines:** 1,000
- **Total Orders:** 572
- **Line Fill Rate:** 62.3%
- **Volume Fill Rate:** 96.5%
- **On-Time Delivery:** 58.5%
- **In-Full Delivery:** 48.4%
- **OTIF:** 25.4%

Customer-level analysis was also performed in Quadratic AI using:

- Order Value
- OTIF %
- In-Full %
- On-Time %

These metrics help identify customers with fulfillment-performance gaps.

## Business Value

The project automates a repetitive data-ingestion process in which monthly regional files are received through email.

Instead of manually:

1. Opening the email
2. Downloading attachments
3. Processing the CSV files
4. Loading the data into a database
5. Preparing the data for analysis

the workflow automates the ingestion stage and makes the data available for downstream analysis.

This creates a simple pipeline from **operational data to business insights**.

## Technologies Used

- Gmail
- n8n
- CSV
- PostgreSQL
- Supabase
- Quadratic AI
- Open Exchange Rates API
- GitHub

## Repository Structure

```text
automated-supply-chain-analytics/
|
+-- database/
|   +-- schema.sql
|
+-- sample_data/
|   +-- README.md
|   +-- dim_customers_sample.csv
|   +-- dim_products_sample.csv
|   +-- dim_targets_orders_sample.csv
|   +-- fact_order_line_sample.csv
|   +-- fact_aggregate_sample.csv
|
+-- quadratic/
|   +-- business_questions.md
|
+-- screenshots/
|   +-- automation_workflow.png
|   +-- supabase_tables.png
|   +-- quadratic_analysis.png
|
+-- .gitignore
+-- README.md
```

## Screenshots

### Automation Workflow

![Automation Workflow](screenshots/automation_workflow.png)

### Supabase Database

![Supabase Database](screenshots/supabase_tables.png)

### Quadratic AI Analysis

![Quadratic AI Analysis](screenshots/quadratic_analysis.png)

## Future Improvements

Potential enhancements include:

- Automated data validation
- Duplicate-record detection
- Error handling and workflow logging
- Automated KPI reporting
- Power BI dashboard integration
- Regional performance dashboards
- Automated customer target comparison
- Alerts for low OTIF performance

## Skills Demonstrated

- Data pipeline automation
- Email-based data ingestion
- CSV processing
- n8n workflow automation
- PostgreSQL
- Supabase
- Fact and dimension modeling
- Supply-chain analytics
- AI-assisted KPI analysis
- Live API data enrichment
- Currency-normalized analysis
- Customer performance analysis
- Business question formulation
