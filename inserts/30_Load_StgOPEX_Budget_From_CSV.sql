USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgOPEX
    WHERE CompanyName = 'Company A'
    AND ScenarioName = 'Budget'
    AND [Year] BETWEEN 2023 AND 2025
)
BEGIN
    RAISERROR
    (
            'Budget StgOPEX data for Company A, 2023-2025 already exists ',
            16,
            1
    )
    RETURN;
END;

BULK INSERT dbo.StgOPEX
FROM 'D:\GitHub\Financial-Analytics-SQL\data\OPEX_Budget_SQL.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

SELECT
    [Year],
    [Quarter],
    ScenarioName,
    COUNT(*) AS CountRows,
    SUM(OPEXAmount) AS TotalOPEXAmount
FROM dbo.StgOPEX
WHERE ScenarioName = 'Budget'
GROUP BY
    [Year],
    [Quarter],
    ScenarioName
ORDER BY
    [Year],
    [Quarter];        