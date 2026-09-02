USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    [Year],
    [Quarter],
    ScenarioName,
    COUNT(*) AS CountRows,
    SUM(OPEXAmount) AS TotalOPEXAmount
FROM dbo.StgOPEX

GROUP BY
    [Year],
    [Quarter],
    ScenarioName

ORDER BY
    [Year],
    [Quarter],
    ScenarioName;    



SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    O.OPEXId,
    SO.CompanyName,
    SO.[Year],
    SO.[Quarter],
    SO.ScenarioName,
    SO.OPEXCategoryName,
    SO.OPEXSubcategoryName,
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
    AND SO.[Year] BETWEEN 2023 AND 2025

ORDER BY
    SO.ScenarioName,
    SO.[Year],
    SO.[Quarter],
    SO.OPEXCategoryName,
    SO.OPEXSubcategoryName;                  