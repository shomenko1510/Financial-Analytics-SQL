USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.FactOPEX
(
    CompanyId,
    PeriodId,
    ScenarioId,
    OPEXId,
    OPEXAmount
)
SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    O.OPEXId,
    SO.OPEXAmount
FROM dbo.StgOPEX AS SO

INNER JOIN dbo.DimCompany AS C
    ON SO.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SO.[Year] = P.[Year]
    AND SO.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SO.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimOPEX AS O
    ON SO.OPEXCategoryName = O.OPEXCategoryName
    AND SO.OPEXSubcategoryName = O.OPEXSubcategoryName

WHERE SO.CompanyName = 'Company A'
    AND SO.[Year] BETWEEN 2023 AND 2025;
 
SELECT 
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(*) AS CountRows
FROM dbo.FactOPEX AS FO

INNER JOIN dbo.DimPeriod AS P
    ON FO.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FO.ScenarioId = S.ScenarioId

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY 
    P.[Year],
    P.[Quarter],
    S.ScenarioName;        