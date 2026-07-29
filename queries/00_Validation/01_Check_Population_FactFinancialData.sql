USE FinanceAnalyticsPortfolioDB;
GO

SELECT 
    f.FinancialDataId,
    f.CompanyId,
    f.PeriodId,
    f.ScenarioId,
    f.IndicatorId,
    f.Amount
FROM dbo.FactFinancialData AS f
ORDER BY
    f.PeriodId,
    f.IndicatorId;
GO    