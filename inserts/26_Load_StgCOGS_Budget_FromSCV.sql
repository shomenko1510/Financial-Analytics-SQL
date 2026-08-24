USE FinanceAnalyticsPortfolioDB;
GO

-- Validation: present duplicate Budget load

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS
    WHERE CompanyName = 'Cpmpany A'
        AND ScenarioName = 'Budget'
        AND [Year] BETWEEN 2023 AND 2025
)
BEGIN
    RAISERROR
    (
        'StgCOGS data for Company A, 2023 - 2025 already exists',
        16,
        1
    );
    RETURN;
END;
GO

BULK INSERT dbo.StgCOGS
FROM 'D:\GitHub\Executive_Financial_Dashboard\data\COGS_Budget_SQL.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0d0a',
    CODEPAGE = '55001',
    TABLOCK
);
GO

SELECT
    [Year],
    [Quarter],
    ScenarioName,
    COUNT(*) AS CountRows,
    SUM(COGSAmount) AS TotalCOGSAmount
FROM dbo.StgCOGS
WHERE CompanyName = 'Company A'
    AND ScenarioName = 'Budget'
    AND [Year] BETWEEN 2023 AND 2025 
GROUP BY
    [Year],
    [Quarter],
    ScenarioName
ORDER BY 
    [Year],
    [Quarter];    
