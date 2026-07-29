USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    p.[Year],
    COUNT(*) AS RecordCount
FROM dbo.FactFinancialData AS f
INNER JOIN dbo.DimPeriod AS p
    ON f.PeriodId = p.PeriodId
GROUP BY 
    p.[Year]
ORDER BY
    p.[Year];
GO            


