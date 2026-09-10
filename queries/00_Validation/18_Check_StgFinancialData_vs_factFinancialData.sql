USE FinanceAnalyticsPortfolioDB;
GO

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(*) AS CountRows
FROM dbo.FactFinancialData AS FD

INNER JOIN dbo.DimPeriod AS P
    ON FD.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FD.ScenarioId = S.ScenarioId

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName

ORDER BY
    P.[Year],
    P.[Quarter];

 ;WITH
 StgData AS
 (
    SELECT
        CompanyName,
        [Year],
        [Quarter],
        ScenarioName,
        COUNT(*) AS StgCountRows,
        SUM(Amount) AS StgAmount
    FROM dbo.StgFinancialData

    GROUP BY
        CompanyName,
        [Year],
        [Quarter],
        ScenarioName        
),
FactData AS
(
    SELECT
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        S.ScenarioName,
        COUNT(*) AS FactCountRows,
        SUM(Amount) AS FactAmount
    FROM dbo.FactFinancialData AS FD

    INNER JOIN dbo.DimCompany AS C
        ON FD.CompanyId = C.CompanyId

    INNER JOIN dbo.DimPeriod AS P
        ON FD.PeriodId = P.PeriodId

    INNER JOIN dbo.DimScenario AS S
        ON FD.ScenarioId = S.ScenarioId

    GROUP BY
        C.CompanyName,
        P.[Year],
        P.[Quarter],
        S.ScenarioName         
)
SELECT
    ST.CompanyName,
    ST.[Year],
    ST.[Quarter],
    ST.ScenarioName,
    ST.StgCountRows,
    FT.FactCountRowS,
    ST.StgCountRows - ISNULL(FT.FactCountRows, 0) AS CountDifference,
    ST.StgAmount,
    FT.FactAmount,
    ST.StgAmount - ISNULL(FT.FactAmount, 0) AS AmountDifference
FROM StgData AS ST

LEFT JOIN FactData AS FT
    ON ST.CompanyName = FT.CompanyName
    AND ST.[Year] = FT.[Year]
    AND ST.[Quarter] = FT.[Quarter]
    AND ST.ScenarioName = FT.ScenarioName

ORDER BY
    ST.[Year],
    ST.[Quarter],
    ST.ScenarioName;

SELECT
    CompanyId,
    PeriodId,
    ScenarioId,
    IndicatorId,
    COUNT(*) AS DuplicateCount

FROM dbo.FactFinancialData

GROUP BY
    CompanyId,
    PeriodId,
    ScenarioId,
    IndicatorId
HAVING COUNT(*) > 1;    

