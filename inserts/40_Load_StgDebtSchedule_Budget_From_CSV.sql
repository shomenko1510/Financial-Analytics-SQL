USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgDebtSchedule
    WHERE CompanyName = 'Company A' 
        AND ScenarioName = 'Budget'
        AND [Year] BETWEEN 2023 AND 2025     
) 
BEGIN
    RAISERROR
    (
        'Budget StgDebtSchedual data for Company A, 2023 - 2025 already exists',
        16,
        1
    );
END
ELSE
BEGIN
    BULK INSERT dbo.StgDebtSchedule
    FROM 'D:\GitHub\Financial-Analytics-SQL\data\DebtSchedule_Budget_SQL.csv'
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
FROM dbo.StgDebtSchedule
WHERE ScenarioName = 'Budget'

GROUP BY
    [Year],
    [Quarter],
    ScenarioName

ORDER BY
    [Year],
    [Quarter],
    ScenarioName;    


