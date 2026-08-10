/*
=====================================================================================================================
Project    : Financing Analytics SQL
Script     : 15_Insert_FactSales_Actual_2025_Q2.sql
Purpose    : Insert Actual FactSales data for Company A, Q2 2025
Author     : Sergii Khomenko
=====================================================================================================================
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
    AND [Quarter] = 'Q2';

-- Check whether Actual FactSales data for Company A, Q2 2025 is already exists.

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
        'Actual FactSales data for Company A, Q2 2025 is alrady exists',
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
            ('Business Line A',     946.6500,    83.4000,    78950.6700),
            ('Business Line B',     200.2100,   242.4000,    48531.3000),
            ('Business Line C',   11881.1800,    19.7000,   234080.1000),
            ('Business Line D',     508.6500,    14.0400,     7140.8500),
            ('Business Line E',     154.3300,    66.1400,    10207.0100),
            ('Business Line F',      79.7300,    38.2600,     3050.7000),
            ('Business Line G',     848.3100,    24.1800,    20508.0000),
            ('Business Line H',     574.8900,    51.8500,    29807.1200),
            ('Other',                 1.0000,   6058.8900,     6058.8900)       
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

--Validation Total RevenueAmount

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
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D    
    ON SD.DirectionName = D.DirectionName;
*/

INSERT INTO dbo.Factsales
(
    CompanyId,
    ScenarioId,
    PeriodId,
    DirectionId,
    Volume,
    Price,
    RevenueAmount
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

PRINT 'Actual FactSales data for Company A, Q2 2025 has been loaded successfully'        