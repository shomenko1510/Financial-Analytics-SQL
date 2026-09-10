USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgFinancialData
    WHERE CompanyName = 'Company A'
        AND ScenarioName = 'Budget'
        AND [Year] BETWEEN 2023 AND 2025       
)
BEGIN
    RAISERROR
    (
        'StgFinancialData Budget data for Company A, 2023 - 2025 already exists',
        16,
        1
    );
END
ELSE
BEGIN

    BULK INSERT dbo.StgFinancialData
    FROM 'D:\GitHub\Financial-Analytics-SQL\data\Cash_Flow_Budget_SQL.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        CODEPAGE = '65001',
        TABLOCK
    );
END;
GO

SELECT
    [Year],
    [Quarter],
    ScenarioName,
    COUNT(*) AS CountRows 
FROM dbo.StgFinancialData

WHERE ScenarioName = 'Budget'

GROUP BY
    [Year],
    [Quarter],
    ScenarioName
ORDER BY
    [Year],
    [QUarter],
    ScenarioName;       