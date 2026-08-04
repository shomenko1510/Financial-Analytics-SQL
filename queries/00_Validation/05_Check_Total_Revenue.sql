USE FinanceAnalyticsPortfolioDB;
GO

SELECT 
    SD.DirectionName,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount,
    SD.Volume * SD.Price AS CalculatedRevenue,
    SD.RevenueAmount - (SD.Volume * SD.Price) AS Difference
FROM SourceData AS SD
ORDER BY SD.DirectionName;    
