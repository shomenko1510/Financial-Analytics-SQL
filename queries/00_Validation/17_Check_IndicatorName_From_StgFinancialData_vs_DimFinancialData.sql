USE FinanceAnalyticsPortfolioDB;
GO

SELECT DISTINCT
    SF.IndicatorName
FROM dbo.StgFinancialData AS SF

LEFT JOIN dbo.DimFinancialIndicator AS FI
    ON SF.IndicatorName = FI.IndicatorName

WHERE FI.IndicatorId IS NULL

ORDER BY SF.IndicatorName;
GO 

SELECT
    COUNT(DISTINCT SF.IndicatorName) AS StgIndicatorCount,
    COUNT(DISTINCT FI.IndicatorName) AS MappedIndicatorCount

FROM dbo.StgFinancialData AS SF 

LEFT JOIN dbo.DimFinancialIndicator AS FI
    ON SF.IndicatorName = FI.IndicatorName;
