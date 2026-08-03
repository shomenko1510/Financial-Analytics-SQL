/*
================================================================================================
Project   : Financial Analytics SQL
Script    : Check_FactOPEX_Actual_2023_Q1.sql
Purpose   : Check data from the FactOPEX tables
Author    : Sergii Khomenko

================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO 

SELECT
    FO.OPEXFactId,
    C.CompanyNAme,
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    O.OPEXCategoryName,
    O.OPEXSubCategoryName,
    FO.OPEXAmount
FROM dbo.FactOPEX AS FO
INNER JOIN dbo.DimCompany AS C    
    ON FO.CompanyId = C. CompanyId
INNER JOIN dbo.DimPeriod AS P    
    ON FO.PeriodId = P.PeriodId
INNER JOIN dbo.DimScenario AS S    
    ON FO.ScenarioId = S.ScenarioId 
INNER JOIN dbo.DimOPEX AS O
    ON FO.OPEXId = O.OPEXId
WHERE C.CompanyName = 'Company A'
    AND P.[Year] = 2023
    AND P.[Quarter] = 'Q1' 
    AND S.ScenarioName = 'Actual'
ORDER BY
    O.OPEXCategoryName,
    O.OPEXSubCategoryName;

SELECT 
    COUNT(*) AS TotalRows,
    SUM(OPEXAmount) AS TotalOPEX
FROM dbo.FactOPEX;                   