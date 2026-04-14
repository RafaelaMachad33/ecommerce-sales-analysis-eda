DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
  InvoiceNo   TEXT,
  StockCode   TEXT,
  Description TEXT,
  Quantity    INTEGER,
  InvoiceDate TEXT,
  UnitPrice   REAL,
  CustomerID  TEXT,
  Country     TEXT
);

CREATE INDEX IF NOT EXISTS idx_sales_invoice_date ON sales(InvoiceDate);
CREATE INDEX IF NOT EXISTS idx_sales_customer     ON sales(CustomerID);
CREATE INDEX IF NOT EXISTS idx_sales_stockcode    ON sales(StockCode);
