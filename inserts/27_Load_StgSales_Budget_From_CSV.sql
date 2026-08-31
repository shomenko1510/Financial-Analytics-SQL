USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgSales
    WHERE CompanyName = 'Company A'
    AND ScenarioName = 'Budget'
    AND [Year] BETWEEN 2023 AND 2025
)
BEGIN
    RAISERROR
    (
        'Budget StgSales data for Company A? 2023 - 2025 already exists',
        16,
        1
    );
    RETURN;
END;

BULK INSERT dbo.StgSales
FROM 'D:\GitHub\Executive_Financial_Dashboard\data\Sales_Budget_SQL.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

SELECT
    [Year],
    [Quarter],
    ScenarioName,
    COUNT(*) AS CountRows,
    SUM(RevenueAmount) AS TotalRevenue
FROM dbo.StgSales
WHERE ScenarioName = 'Budget'
GROUP BY
    [Year],
    [Quarter],
    ScenarioName
ORDER BY
    [Year],
    [Quarter];          