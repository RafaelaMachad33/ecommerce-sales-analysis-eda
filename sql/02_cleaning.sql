DROP VIEW IF EXISTS sales_clean;

CREATE VIEW sales_clean AS
SELECT
  InvoiceNo,
  StockCode,
  Description,
  Quantity,
  InvoiceDate,
  UnitPrice,
  CustomerID,
  Country,
  (Quantity * UnitPrice) AS Revenue
FROM sales
WHERE 1=1
  AND Quantity > 0
  AND UnitPrice > 0
  AND InvoiceDate IS NOT NULL
  AND TRIM(InvoiceDate) <> ''
  AND InvoiceNo NOT LIKE 'C%';
