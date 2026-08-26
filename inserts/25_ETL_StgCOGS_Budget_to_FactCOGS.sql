/*
=======================================================================================================================
Progect     : Financial Analitics SQL
Script      : 25_ETL_StgCOGS_Budget_to_FactCOGS.sql
Purpose     : Load Budget StgCOGS data into FactCOGS
Author      : Sergii Khomenko
=======================================================================================================================
*/

SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    D.DirectionId,
    SC.COGSAmount
FROM dbo.StgCOGS AS SC

INNER JOIN dbo.DimCompany AS C
    ON SC.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SC.[Year] = P.[Year]
    AND SC.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S     
    ON SC.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDirection AS D
    ON SC.DirectionName = D.DirectionName

WHERE SC.CompanyName = 'Company A'
    AND SC.ScenarioName = 'Budget'
    AND SC.[Year] BETWEEN 2023 AND 2025;    

IF EXISTS
(
    SELECT 1
    FROM dbo.FactCOGS AS FC
    INNER JOIN dbo.DimScenario AS S
        ON FC.ScenarioId = S.ScenarioId

    INNER JOIN dbo.DimPeriod AS P
        ON FC.PeriodId = P.PeriodId

    WHERE S.ScenarioName = 'Budget'
        AND P.[Year] BETWEEN 2023 AND 2025          
)
BEGIN
    RAISERROR
    (
        'FactCOGS Budget data for 2023-2025 already exists.',
        16,
        1
    );
    RETURN;
END
GO

INSERT INTO dbo.FactCOGS
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId,
    COGSAmount
)
SELECT
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    D.DirectionId,
    SC.COGSAmount
FROM dbo.StgCOGS AS SC

INNER JOIN dbo.DimCompany AS C
    ON SC.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SC.[Year] = P.[Year]
    AND SC.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SC.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimDirection AS D
    ON SC.DirectionName = D.DirectionName

WHERE SC.CompanyName = 'Company A'
    AND SC.ScenarioName = 'Budget'
    AND SC.[Year] BETWEEN 2023 AND 2025;
GO                        

SELECT
    P.[Year],
    P.[Quarter],
    S.ScenarioName,
    COUNT(*) AS CountRows,
    SUM(FC.COGSAmount) AS TotalCOGSAmount

FROM dbo.FactCOGS AS FC

INNER JOIN dbo.DimPeriod AS P
    ON FC.PeriodId = P.PeriodId

INNER JOIN dbo.DimScenario AS S
    ON FC.ScenarioId = S.ScenarioId

WHERE S.ScenarioName = 'Budget'
    AND P.[Year] BETWEEN 2023 AND 2025

GROUP BY
    P.[Year],
    P.[Quarter],
    S.ScenarioName
ORDER BY
    P.[Year],
    P.[Quarter];



