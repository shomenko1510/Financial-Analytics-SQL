USE FinanceAnalyticsPortfolioDB;
GO

;WITH StdData AS
(
    SELECT
        CompanyName,
        [Year],
        [Quarter],
        ScenarioName,
        COUNT(*) AS StgCountRows,
        SUM(COGSAmount) AS StgCOGSAmount
    FROM dbo.StgCOGS
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
        SUM(FC.COGSAmount) AS FactCOGSAmount
FROM dbo.FactCOGS AS FC

INNER JOIN dbo.DimCompany AS C
    ON FC.CompanyId = C.CompanyId

INNER JOIN dbo.DimPeriod AS P
    ON FC.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FC.ScenarioId = S. ScenarioId

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
/*
ST.StgCountRows,
    ISNULL(FD.FactCOUNTROWS, 0) AS FactCountRows,
    ST.StgCountRows - ISNULL(FD.FactCountRows, 0) AS CountDifference,

    ST.StgRevenueAmount,
    ISNULL (FD.factRevenueAmount, 0) AS FactRevenueAmount,
    ST.StgRevenueAmount - ISNULL(FD.factRevenueAmount,0) AS RevenueDifference
 */   


    ST.StgCountRows,
    ISNULL(FD.FactCOUNTROWS, 0) AS FactCountRows,
    ST.StgCountRows - ISNULL(FD.FactCountRows, 0) AS CountDifference,

    ST.StgCOGSAmount,
    ISNULL (FD.FactCOGSAmount, 0) AS FactCOGSAmount,
    ST.StgCOGSAmount - ISNULL(FD.FactCOGSAmount,0) AS COGSDifference

FROM StdData AS ST

LEFT JOIN FactData AS FD
    ON ST.CompanyName = FD.CompanyName
    AND ST.[Year] = FD.[Year]
    AND ST.[Quarter] = FD.[Quarter]
    AND ST.ScenarioName = FD.ScenarioName

ORDER BY
    ST.[Year],
    ST.[Quarter],
    ST.ScenarioName;

GO        

