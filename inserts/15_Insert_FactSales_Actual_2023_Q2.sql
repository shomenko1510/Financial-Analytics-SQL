/*
==========================================================================
Project   : Financial Analytics SQL
Script    : 15_Insert_FactSales_Actual_2023_Q2.sql
Purpose   : Insert actual FactSale data for Q2 2023
Author    : Sergii Khomenko
==========================================================================
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
WHERE [Year] = 2023
    AND [Quarter] = 'Q2';

--Check whether the data has already been loaded    
IF EXISTS
(
    SELECT 1
    FROM dbo.FactSales
    WHERE @CompanyId = CompanyId
        AND @PeriodId = PeriodId
        AND @ScenarioId = ScenarioId 
)
BEGIN
    RAISERROR
    (
        'FactSales Actual data for Company A, Q1 2023 is already exists',
        16,
        1
    );
    RETURN;
END;
;WITH SourceData AS
(
    SELECT *
    FROM
    (
        VALUES
            ('Business Line A',   729.4500,    73.1000,   53322.8000),
            ('Business Line B',   343.7200,   216.4000,   52741.9800),
            ('Business Line C', 11737.2700,    15.8000,  185495.0000),
            ('Business Line D',     0.0000,     0.0000,       0.0000),
            ('Business Line E',   172.0200,    63.2800,   10884.9700),
            ('Business Line F',   256.4500,    37.7700,    9686.2600),
            ('Business Line G',   150.1600,    27.2800,    4095.8000),
            ('Business Line H',    21.7800,    35.4000,     771.0300),
            ('Other',               1.0000,  4837.2400,    4837.2400) 
    ) AS V     

    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)
--Check Total Revenue.
/*
SELECT SUM(RevenueAmount)
FROM SourceData AS SD;
*/ 
 -- Check difference 
/*
SELECT 
    SD.DirectionNane,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount,
    SD.Volume * SD.Price AS RevenueCalcualtion,
    SD.RevenueAmount - (SD.Volume * SD.Price) AS Difference  
FROM SourceData AS SD
ORDER BY DirectionName;
*/

INSERT INTO dbo.FactSales
(
    CompanyId, 
    PeriodId,
    ScenarioId,
    DirectionID,
    Volume,
    Price,
    RevenueAmount
)
SELECT
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    D.DirectionId,
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
ON SD.DirectionName = D.DirectionName;    

PRINT 'FactSales Actual 2023 Q2 inserted successfully';




