-- 03_analysis.sql
-- Analysis queries (SQLite) using the cleaned view: sales_clean

-- 1) Basic KPIs
SELECT
  COUNT(*) AS rows_clean,
  COUNT(DISTINCT InvoiceNo) AS orders,
  COUNT(DISTINCT CustomerID) AS customers_with_id,
  SUM(Revenue) AS total_revenue,
  AVG(Revenue) AS avg_line_revenue
FROM sales_clean;

-- 2) Revenue by month
SELECT
  strftime('%Y-%m', datetime(InvoiceDate)) AS year_month,
  SUM(Revenue) AS revenue
FROM sales_clean
GROUP BY 1
ORDER BY 1;

-- 3) Top 10 products by revenue
SELECT
  StockCode,
  Description,
  SUM(Quantity) AS units_sold,
  SUM(Revenue) AS revenue
FROM sales_clean
GROUP BY 1,2
ORDER BY revenue DESC
LIMIT 10;

-- 4) Top 10 countries by revenue
SELECT
  Country,
  SUM(Revenue) AS revenue,
  COUNT(DISTINCT InvoiceNo) AS orders
FROM sales_clean
GROUP BY 1
ORDER BY revenue DESC
LIMIT 10;

-- 5) Seasonality by weekday (0=Sun ... 6=Sat)
SELECT
  strftime('%w', datetime(InvoiceDate)) AS weekday_num,
  SUM(Revenue) AS revenue
FROM sales_clean
GROUP BY 1
ORDER BY revenue DESC;

-- 6) Top customers (requires CustomerID)
SELECT
  CustomerID,
  COUNT(DISTINCT InvoiceNo) AS orders,
  SUM(Revenue) AS total_spent,
  AVG(Revenue) AS avg_line_revenue
FROM sales_clean
WHERE CustomerID IS NOT NULL AND TRIM(CustomerID) <> ''
GROUP BY 1
ORDER BY total_spent DESC
LIMIT 20;

-- 7) RFM (simple)
WITH base AS (
  SELECT
    CustomerID,
    MAX(date(datetime(InvoiceDate))) AS last_purchase_date,
    COUNT(DISTINCT InvoiceNo) AS frequency,
    SUM(Revenue) AS monetary
  FROM sales_clean
  WHERE CustomerID IS NOT NULL AND TRIM(CustomerID) <> ''
  GROUP BY 1
),
ref AS (
  SELECT MAX(date(datetime(InvoiceDate))) AS ref_date
  FROM sales_clean
)
SELECT
  b.CustomerID,
  CAST(julianday(r.ref_date) - julianday(b.last_purchase_date) AS INT) AS recency_days,
  b.frequency,
  b.monetary
FROM base b
CROSS JOIN ref r
ORDER BY b.monetary DESC
LIMIT 50;
