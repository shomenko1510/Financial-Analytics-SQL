USE FinanceAnalyticsPortfolioDB;
GO

DROP TABLE IF EXISTS dbo.FactSales_Backup;

SELECT *
INTO dbo.FactSales_Backup
FROM dbo.FactSales;

GO

SELECT
    COUNT(*) AS FactSalesRows,
    SUM(RevenueAmount) AS TotalRevenue
FROM dbo.FactSales;

SELECT
    COUNT(*) AS BackupRows,
    SUM(RevenueAmount) AS TotalRevenue
FROM dbo.FactSales_Backup;

TRUNCATE TABLE dbo.FactSales;
