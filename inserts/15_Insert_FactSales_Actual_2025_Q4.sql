/*
===============================================================================================
Project   : Financial Analytics SQL
Script    : 15_Insert_FactSales_Actual_2025_Q4
Purpose   : Insert Actual FactSales data for Company A, Q4 2025
Author    : Sergii Khomenko
===============================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @ScenarioId INT;
DECLARE @PeriodId INT;

SELECT @CompanyId = CompanyId
FROM dbo.DimCompany
WHERE CompanyName = 'Company A';

SELECT @ScenarioId = ScenarioId
FROM dbo.DimScenario
WHERE ScenarioName = 'Actual';

SELECT @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2025
    AND [Quarter] = 'Q4'

--Check whether the data is already exists

IF EXISTS
(
    SELECT 1
    FROM dbo.FactSales
    WHERE @CompanyId = CompanyId
        AND @ScenarioId = ScenarioId
        AND @PeriodId = PeriodId
)
BEGIN
    RAISERROR
    (
        'Actual FactSales data for Company A, Q4 2025 is already exists',
        16,
        1
    )
    RETURN;
END;

;WITH SourceData AS
(
    SELECT *
    FROM
    (
        VALUES
        ('Business Line A',  763.4400,    84.5000,    64510.9500),
        ('Business Line B',  105.8800,   235.8900,    24975.7100),
        ('Business Line C', 7827.8100,    15.9700,   124980.8000),
        ('Business Line D',  136.5900,    22.1400,     3024.6100),
        ('Business Line E',   71.4300,    61.5400,     4396.3000),
        ('Business Line F',  136.6500,    42.3200,     5782.6200),
        ('Business Line G',  727.8800,    25.6200,    18646.1000),
        ('Business Line H',  174.4300,    47.1100,     8217.9800),
        ('Other',              1.0000,  2990.7600,     2990.7600)   
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

-- Validation Total RevenueAmount
/*
SELECT SUM(RevenueAmount) AS TotalRevenue
FROM SourceData;
*/

--Validation - Previev data before insert.

/*
SELECT
    @CompanyId,
    @ScenarioId,
    @PeriodId,
    D.DirectionId,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
    ON SD.DirectionName = D.DirectionName;
*/

INSERT INTO dbo.FactSales
(
    CompanyId,
    ScenarioId,
    PeriodId,
    D.DirectionId,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
)
SELECT
    @CompanyId,
    @ScenarioId,
    @PeriodId,
    D.DirectionId,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
    ON SD.DirectionName = D.DirectionName;

PRINT 'Actual FactSales data for Company A, Q4 2025 has been loaded successfully';

