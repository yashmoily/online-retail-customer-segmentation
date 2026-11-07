USE OnlineRetail;
GO

--1) Final RFM Base query
-- Customer purchase metrics
WITH PurchaseMetrics AS
(SELECT CustomerID,MAX(InvoiceDateTime) AS LastPurchaseDate,COUNT(DISTINCT InvoiceNo) AS Frequency
FROM dbo.vw_OnlineRetail_ProductSales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID),

-- Customer net monetary value
NetMonetary AS
(SELECT CustomerID,SUM(LineRevenue) AS Monetary
FROM dbo.vw_OnlineRetail_NetSales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID)

-- Combine customer metrics
SELECT P.CustomerID,P.LastPurchaseDate,P.Frequency,N.Monetary
FROM PurchaseMetrics P
LEFT JOIN NetMonetary N
ON P.CustomerID = N.CustomerID
ORDER BY P.CustomerID;



--2) RFM Validation Summary
go
WITH PurchaseMetrics AS
(SELECT CustomerID,MAX(InvoiceDateTime) AS LastPurchaseDate,COUNT(DISTINCT InvoiceNo) AS Frequency
FROM dbo.vw_OnlineRetail_ProductSales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID),

NetMonetary AS
(SELECT CustomerID,SUM(LineRevenue) AS Monetary
FROM dbo.vw_OnlineRetail_NetSales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID),

RFM_Base AS
(SELECT P.CustomerID,P.LastPurchaseDate,P.Frequency,N.Monetary
FROM PurchaseMetrics P
LEFT JOIN NetMonetary N
ON P.CustomerID = N.CustomerID)

SELECT
COUNT(*) AS TotalCustomers,
SUM(Frequency) AS TotalPurchaseFrequency,
SUM(Monetary) AS TotalNetMonetary,
MIN(LastPurchaseDate) AS EarliestLastPurchase,
MAX(LastPurchaseDate) AS LatestLastPurchase,
SUM(CASE WHEN Monetary <= 0 THEN 1 ELSE 0 END)
AS CustomersWithNonPositiveMonetary,
SUM(CASE WHEN Monetary IS NULL THEN 1 ELSE 0 END)
AS CustomersWithMissingMonetary
FROM RFM_Base;





-- 3) Unidentified Customer Invoices
SELECT COUNT(DISTINCT InvoiceNo) AS UnidentifiedCustomerInvoices
FROM dbo.vw_OnlineRetail_ProductSales
WHERE CustomerID IS NULL;


-- 4) Non-positive Monetary Customers
WITH PurchaseMetrics AS
(SELECT CustomerID,MAX(InvoiceDateTime) AS LastPurchaseDate,COUNT(DISTINCT InvoiceNo) AS Frequency
FROM dbo.vw_OnlineRetail_ProductSales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID),

NetMonetary AS
(SELECT CustomerID,SUM(LineRevenue) AS Monetary
FROM dbo.vw_OnlineRetail_NetSales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID)

SELECT P.CustomerID,P.Frequency,N.Monetary
FROM PurchaseMetrics P
INNER JOIN NetMonetary N
ON P.CustomerID = N.CustomerID
WHERE N.Monetary <= 0
ORDER BY N.Monetary;


-- 5) Positive Sales vs Cancellation Values
SELECT CustomerID,SUM( CASE WHEN InvoiceNo NOT LIKE 'C%' THEN LineRevenue ELSE 0 END) AS PositiveSales,
SUM(CASE WHEN InvoiceNo LIKE 'C%' THEN LineRevenue ELSE 0 END) AS CancellationValue,
SUM(LineRevenue) AS NetMonetary
FROM dbo.vw_OnlineRetail_NetSales
WHERE CustomerID IN (17548, 16546, 12346, 12558,16878, 18268, 13364, 12607,14557, 12454, 13762, 13672,18274, 14792)
GROUP BY CustomerID
ORDER BY NetMonetary;
