# E-commerce Sales Analysis — EDA (Excel + SQLite)

Exploratory analysis of the **Online Retail II** dataset (500k+ transactions).  
Investigated **revenue trends**, **top-selling products**, **seasonality**, and **customer purchasing behaviour**.

## Stack
- Excel (Power Query, Pivot Tables, Dashboard)
- SQL (SQLite)

## Dataset
- Source: https://www.kaggle.com/datasets/mashlyn/online-retail-ii-uci
- Main fields: InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country

> Note: Raw data is not included in this repo due to size/licensing.  
> Download it from Kaggle and import it into SQLite.

## Business Questions
1. How does revenue change over time?
2. What are the top-selling products by units and revenue?
3. Is there seasonality by month / weekday?
4. Which countries contribute most to revenue?
5. What does customer behaviour look like (RFM-style)?

## Data Cleaning (high level)
- Filtered invalid rows (Quantity <= 0, UnitPrice <= 0)
- Standardized date parsing for time-based analysis
- Created `Revenue = Quantity * UnitPrice`
- Optional: excluded cancelled invoices (InvoiceNo starting with "C")

## Key Insights
- **Top country (#1) + revenue**
- **Top product (#1) + revenue**
- **Month with the highest revenue**

## How to reproduce (SQLite)
1. Create a SQLite database (e.g., `ecommerce.db`)
2. Run `sql/01_create_tables.sql`
3. Import the dataset into table `sales`
4. Run `sql/02_cleaning.sql` and `sql/03_analysis.sql`

## License
MIT
