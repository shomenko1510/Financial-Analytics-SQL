/*
======================================================================================================================
Project   : Financial Analytics SQL
Script    : 16_Load_StgCOGS_Actual_2025_Q1_Q4.sql
Purpose   : Load Actual FactCOGS data for Q1, Q2, Q3, Q4 2025 into StgCOGS table 
Author    : Sergii Khomenko
======================================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS
(
    SELECT 1
    FROM dbo.StgCOGS
    WHERE CompanyName = 'Company A'
    AND [Year] = 2025
    AND [Quarter] IN ('Q1', 'Q2', 'Q3', 'Q4')
    AND ScenarioName = 'Actual'  
)
BEGIN
    RAISERROR
    (
        'StgCOGS Actual data for Company A, Q1 2023 already exists',
        16,
        1
    )
    RETURN;
END;    

INSERT INTO dbo.StgCOGS
(
    CompanyName,
    [Year],
    [Quarter],
    ScenarioName,
    DirectionName,
    COGSAmount
)
VALUES
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line A',   39142.5900),
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line B',   32406.4600),
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line C',   93400.2000),
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line D',    6907.3000),
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line E',    7999.6000),
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line F',    5206.2400),
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line G',    7527.4000),
    ('Company A', 2025, 'Q1', 'Actual', 'Business Line H',    9713.9000),
    ('Company A', 2025, 'Q1', 'Actual', 'Other',              3536.2000),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line A',   53014.9000),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line B',   37319.4500),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line C',  151831.4000),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line D',    5245.9000),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line E',    7235.2000),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line F',    1922.7200),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line G',    9131.1000),
    ('Company A', 2025, 'Q2', 'Actual', 'Business Line H',   19580.7000),
    ('Company A', 2025, 'Q2', 'Actual', 'Other',              4428.7000),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line A',   38955.8500),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line B',   19809.6600),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line C',  104469.2000),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line D',    1448.5000),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line E',    3345.7000),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line F',    3772.9600),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line G',    9301.9000),
    ('Company A', 2025, 'Q3', 'Actual', 'Business Line H',    5046.6000),
    ('Company A', 2025, 'Q3', 'Actual', 'Other',              2509.9000),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line A',   36167.1400),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line B',   20032.0000),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line C',   77970.6000),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line D',    1417.3000),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line E',    3021.9000),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line F',    3987.3700),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line G',    9223.2000),
    ('Company A', 2025, 'Q4', 'Actual', 'Business Line H',    5510.3000),
    ('Company A', 2025, 'Q4', 'Actual', 'Other',              2146.3000);
GO

SELECT 
    COUNT(*) AS CountRows,
    SUM(COGSAmount)
FROM StgCOGS
WHERE [Year] = 2025;

