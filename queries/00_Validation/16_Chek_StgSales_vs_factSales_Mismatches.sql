USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    SS.[Year],
    SS.[Quarter],
    SS.ScenarioName,
    COUNT(*) AS MismatchCount
FROM dbo.StgSales AS SS

INNER JOIN dbo.DimCompany AS C
    ON SS.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SS.[Year] = P.[Year]

INNER JOIN dbo.DimScenario AS S
    ON SS.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDirection AS D
    ON SS.DirectionName = D.DirectionName

LEFT JOIN dbo.FactSales AS FS
    ON FS.CompanyId = C.CompanyId
    AND FS.PeriodId = P.PeriodId
    AND FS.ScenarioId = S.ScenarioId
    AND FS.DirectionId = D.DirectionId

WHERE
        FS.SalesId IS NULL  

GROUP BY
    SS.[Year],
    SS.[Quarter],
    SS.ScenarioName

ORDER BY
    SS.[Year],
    SS.[Quarter],
    SS.ScenarioName;
GO

SELECT
    SS.[Year],
    SS.[Quarter],
    SS.ScenarioName,

    COUNT(SS.DirectionName) AS StgCountRows,
    COUNT(FS.SalesId) AS FactCountRows,

    SUM(SS.RevenueAmount) AS StgRevenueAmount,
    SUM(FS.RevenueAmount) AS factRevenueAmount,

    SUM(SS.RevenueAmount) - SUM(FS.RevenueAmount) AS RevenueDifference

FROM dbo.StgSales As SS

INNER JOIN dbo.DimCompany AS C
    ON SS.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SS.[Year] = P.[Year]

INNER JOIN dbo.DimScenario AS S
    ON SS.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDirection AS D
    ON SS.DirectionName = D.DirectionName

LEFT JOIN dbo.factSales AS FS
    ON FS.CompanyId = C.CompanyId
    AND FS.PeriodId = P.PeriodId
    AND FS.ScenarioId = S.ScenarioId
    AND FS.DirectionId = D.DirectionId

GROUP BY
    SS.[Year],
    SS.[Quarter],
    SS.ScenarioName

ORDER BY
    SS.[Year],
    SS.[Quarter],
    SS.ScenarioName;



17_Check_StgSales_vs_FactSales_Mismatches.