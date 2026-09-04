USE FinanceAnalyticsPortfolioDB;
GO


IF EXISTS 
(
    SELECT 1
    FROM dbo.StgWorkingCapital
    WHERE CompanyName = 'Company A'
        AND ScenarioName = 'Actual'
        AND [Year] BETWEEN 2023 AND 2025
)
BEGIN
    RAISERROR
    (
        'StgWorkingCapital Actual data for Company A, 2023 - 2025 already exists',
        16,
        1
    );
    RETURN;
END;
BULK INSERT dbo.StgWorkingCapital
FROM 'D:\GitHub\Financial-Analytics-SQL\data\WorkingCapital_Actual_SQL.csv'
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
    SUM(WorkingCapitalAmount) AS TotalWorkingCapitalAmount
FROM dbo.StgWorkingCapital
WHERE ScenarioName = 'Actual'
GROUP BY
    [Year],
    [Quarter],
    ScenarioName
ORDER BY
    [Year],
    [Quarter];
