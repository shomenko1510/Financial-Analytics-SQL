USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgFinancialData
    WHERE CompanyName = 'Company A'
        AND ScenarioName = 'Actual'
        AND [Year] BETWEEN 2023 AND 2025      
)
BEGIN
    RAISERROR
    (
        'StgFinancialData Actual data for Company A, 2023-2025 already exists.',
        16,
        1
    );
END
ELSE
BEGIN

    BULK INSERT dbo.StgFinancialData
    FROM 'D:\GitHub\Financial-Analytics-SQL\data\Cash_Flow_Actual_SQL.csv'
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
    COUNT(*) AS CountRows,
    SUM(Amount) AS TotalAmount

FROM dbo.StgFinancialData
WHERE ScenarioName = 'Actual'

GROUP BY
    [Year],
    [Quarter],
    ScenarioName

ORDER BY
    [Year],
    [Quarter];
GO        
