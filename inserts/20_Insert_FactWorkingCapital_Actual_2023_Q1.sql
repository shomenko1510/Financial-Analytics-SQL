/*
================================================================================================================
Project    : Financial Analitics SQL
Script     : 20_Insert_FactWorkingCapital_Actual_2023_Q1
Purpose    : Insert actual Working Capital data for Q1 2023
Author     : Sergii Khomenko
================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

DECLARE @CompanyId INT;
DECLARE @PeriodId INT;
DECLARE @ScenarioId INT;

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
    AND [Quarter] = 'Q1';

IF EXISTS
(
    SELECT 1
    FROM dbo.FactWorkingCapital
    WHERE @CompanyId = CompanyId
        AND @PeriodId = PeriodId
        AND @ScenarioId = ScenarioId
)        
BEGIN
    RAISERROR
    (
        'FactWorking Capital Actual data for Company A, Q1 2023 already exists.',
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
            ('Inventory',     'Total Inventory',           CAST(176313.39 AS DECIMAL(18,4))),
            ('Receivables',   'Total Trade Receivables',   CAST(109364.80 AS DECIMAL(18,4))),
            ('Payables',      'Total Payables',            CAST(21185.39 AS DECIMAL(18,4)))
           
    ) AS V
    (
        WorkingCapitalCategory,
        WorkingCapitalItem,
        WorkingCapitalAmount
    )
);

-- Validation - Preview Data before INSERT
/*
SELECT
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    WC.WorkingCapitalId,
    SD.WorkingCapitalAmount
FROM SourceData AS SD

INNER JOIN dbo.DimWorkingCapital AS WC
    ON SD.WorkingCapitalCategory = WC.WorkingCapitalCategory
    AND SD.WorkingCapitalItem = WC.WorkingCapitalItem;

*/
--Insert data into FactWorkingCapital

INSERT INTO dbo.FactWorkingCapital
(
    CompanyId,
    PeriodId,
    ScenarioId, 
    WorkingCapitalId,
    WorkingCapitalAmount
)
SELECT
    @CompanyId,
    @PeriodId,
    @ScenarioId,
    WC.WorkingCapitalId,
    SD.WorkingCapitalAmount
FROM Sourcedata AS SD
INNER JOIN dbo.DimWorkingCapital AS WC
    ON SD.WorkingCapitalCategory = WC.WorkingCapitalCategory
    AND SD.WorkingCapitalItem = WC.WorkingCapitalItem;

PRINT 'FactWorkingCapital Actual 2023 Q1 inserted successfully.';
GO
