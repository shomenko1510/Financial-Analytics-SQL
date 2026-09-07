USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCapEx
    WHERE CompanyName = 'Company A'
        AND ScenarioName = 'Actual'
        AND [Year] BETWEEN 2023 AND 2025
)
BEGIN
    RAISERROR
    (
        'StgCapEx Actual data for 2023-2025 already exists.',
        16,
        1
    );
END
ELSE
BEGIN

    BULK INSERT dbo.StgCapEx
    FROM 'D:\GitHub\Financial-Analytics-SQL\data\CapEx_Actual_SQL.csv'
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
    SUM(CapExAmount) AS TotalCapExAmount
FROM dbo.StgCapEx
WHERE ScenarioName = 'Actual'
GROUP BY
    [Year],
    [Quarter],
    ScenarioName

ORDER BY
    [Year],
    [Quarter];
GO            