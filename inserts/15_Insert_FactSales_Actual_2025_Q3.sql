/*
======================================================================================================================
Project    : Financial Analytics SQL
Script     : 15_Insert_FactSales_Actual_2025_Q3
Purpose    : Insert Actual FactSales data for Company A, Q3 2025
Author     : Sergii Khomenko
======================================================================================================================
*/

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
    AND [Quarter] = 'Q3';

--Check wheter Actual FactSales data for Company A, Q3 2025 is already exists;

IF EXISTS
(
    SELECT 1
    FROM FactSales
    WHERE @CompanyId = CompanyId
        AND @ScenarioId = ScenarioId
        AND @PeriodId = PeriodId     
)
BEGIN
    RAISERROR
    (
        'Actual FactSAles data for Company A, Q3 2025 is already exists',
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
            ('Business Line A',    763.4400,    83.6000,     63823.8500),
            ('Business Line B',    105.8800,   235.4500,     24929.2300),
            ('Business Line C',   7827.8100,    20.0000,    156560.8000),
            ('Business Line D',    136.5900,    17.9700,      2454.3900),
            ('Business Line E',     71.4300,    67.5800,      4827.3100),
            ('Business Line F',    136.6500,    36.3600,      4969.0600),
            ('Business Line G',    727.8800,    23.1800,     16869.2000),
            ('Business Line H',    174.4300,    47.1100,      8217.9800),
            ('Other',                1.0000,  2990.7600,      2990.7600)  
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

INSERT INTO dbo.FactSales
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

PRINT 'Actual FactSales data for Company A, Q3 2025 has been loaded successfully'           