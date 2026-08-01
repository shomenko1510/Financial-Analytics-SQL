/*
=================================================================================================================
Project   : Financial Analitics SQL
Script    : 15_Insert_FactSales_Actual_2023_Q1.sql
Purpose   : Populate the FactSales table 
Author    : Sergii Khomenko
=================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @ScenarioId INT;
DECLARE @PeriodId INT;

SELECT 
    @CompanyId = CompanyId
FROM dbo.DimCompany
WHERE CompanyName = 'Company A';

SELECT
    @ScenarioId = ScenarioId
FROM dbo.DimScenario
WHERE ScenarioName = 'Actual';


SELECT
    @PeriodId = PeriodId
FROM dbo.DimPeriod
WHERE [Year] = 2023
    AND Quarter = 'Q1';

--Check whether the data has already been loaded

IF EXISTS
(
    SELECT 1
    FROM dbo.FactSales
    WHERE CompanyId = @CompanyId
        AND PeriodId = @PeriodId
        AND ScenarioId = @ScenarioId    
)
BEGIN 
    RAISERROR
    (
        'FactSales Actual data for Company A, Q1 2023 already exists.',
        16,
        1
    );
    RETURN;
END;    

; WITH SourceData AS
(
    SELECT * 
    FROM
    (
        VALUES
            ('Business Line A',   503.4000,    72.4600,  36476.3600),
            ('Business Line B',   195.1200,   211.4500,  41258.6900),
            ('Business Line C',  9363.6800,    15.5500,  145585.5000),
            ('Business Line D',     0.0000,     0.0000,       0.0000),
            ('Business Line E',   151.8500,    65.6500,    9969.3500),
            ('Business Line F',   184.8400,    38.1500,    7051.7600),
            ('Business Line G',     1.1900,    25.0000,      29.8000),
            ('Business Line H',     0.0000,     0.0000,       0.0000),
            ('Other',               1.0000,  4191.0800,    4191.0800) 
    ) AS V
    (
        DirectionName,
        Volume,
        Price,
        RevenueAmount
    )
)

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
    SD.Volume,
    SD.Price,
    SD.RevenueAmount
FROM SourceData AS SD
INNER JOIN dbo.DimDirection AS D
    ON SD.DirectionName = D.DirectionName;

PRINT 'FactSales Actual 2023 Q1 loaded successfully.';        
