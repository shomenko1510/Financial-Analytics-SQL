/*
======================================================================================================================
Project    : Financial Analytics SQL
Script     : 15_Insert_FactSales_Actual_2024_Q2
Purpose    : Insert Actual FactSales data for Company A, Q2 2024
Author     : Sergii Khomenko
======================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @PeriodId INT;
DECLARE @ScenarioId INT;

SELECT @CompanyId = CompanyId
FROM dbo.DimCompany
WHERE CompanyName = 'Company A';

SELECT @ScenarioId = ScenarioId
FROM dbo.DimScenario
WHERE ScenarioName = 'Actual';

SELECT @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2024
    AND [Quarter] = 'Q2';

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
        'Actual FactSales data for Company A, Q2 2024 is already excists',
        16,
        1
    )
    RETURN;
END;

; WITH SourceData AS 
(
    SELECT *
    FROM
    (
        VALUES
            ('Business Line A',    949.5900,   75.1000,   71314.3600),
            ('Business Line B',    199.7600,  237.1000,   47364.0400),
            ('Business Line C',   8709.4200,   19.0800,  166178.5000),
            ('Business Line D',      0.0000,    0.0000,       0.0000),
            ('Business Line E',    144.8300,   63.7100,    9226.7200),
            ('Business Line F',    244.7800,   42.1500,   10318.1600),
            ('Business Line G',    399.3400,   24.2700,    9693.1000),
            ('Business Line H',      0.0000,    0.0000,       0.0000),
            ('Other',                1.0000, 5135.3400,    5135.3400)
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

-- Validation Total Amount

/*
SELECT SUM(RevenueAmount) AS TotalRevenue
FROM SourceData;
*/

-- Validation - Previev data before insert

/*
SELECT 
    @CompanyId,
    @ScenarioId,
    @PeriodId,
    D.DirectionId,
    SD.Price,
    SD.Volume,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
ON SD.DirectionName = D.DirectionName;
*/


INSERT INTO dbo.FactSales
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    Volume,
    Price,
    RevenueAmount
)

SELECT
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    D.DirectionId,
    SD.Price,
    SD.Volume,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
ON SD.DirectionName = D.DirectionName;

PRINT 'Actual FactSales data for Company A, Q2 2024 has beeb loaded successfully';
