USE FinanceAnalyticsPortfolioDB;
GO

IF EXISTS 
(
    SELECT 1
    FROM dbo.StgWorkingCapital AS SWC

    INNER JOIN dbo.DimCompany AS C
        ON SWC.CompanyName = C.CompanyName

    INNER JOIN dbo.DimPeriod AS P
        ON SWC.[Year] = P.[Year]
        AND SWC.[Quarter] = P.[Quarter]

    INNER JOIN dbo.DimScenario AS S
        ON SWC.ScenarioName = S.ScenarioName

    INNER JOIN dbo.DimWorkingCapital AS WC
        ON SWC.WorkingCapitalCategory = WC.WorkingCapitalCategory
        AND SWC.WorkingCapitalItem = WC.WorkingCapitalItem

    INNER JOIN dbo.factWorkingCapital AS FWC    
        ON FWC.CompanyId = C.CompanyId
        AND FWC.PeriodId = P.PeriodId
        AND FWC.ScenarioId = S.ScenarioId
        AND FWC.WorkingCapitalId = WC.WorkingCapitalId

WHERE SWC.CompanyName = 'Company A'
    AND SWC.[Year] BETWEEN 2023 AND 2025
)
BEGIN
    RAISERROR
    (
        'FactWorkingCapital already contains matching data for 2023 - 2025.',
        16,
        1
    );
    RETURN;
END;
GO

INSERT INTO dbo.FactWorkingCapital
(
    CompanyId,
    PeriodId,
    ScenarioId,
    WorkingCapitalId,
    WorkingCapitalAmount
) 
SELECT 
    C.CompanyId,
    P.PeriodId,
    S.ScenarioId,
    WC.WorkingCapitalId,
    SWC.WorkingCapitalAmount

FROM dbo.StgWorkingCapital AS SWC

INNER JOIN dbo.DimCompany AS C
    ON SWC.CompanyName = C.CompanyName

INNER JOIN dbo.DimPeriod AS P
    ON SWC.[Year] = P.[Year]
    AND SWC.[Quarter] = P.[Quarter]

INNER JOIN dbo.DimScenario AS S
    ON SWC.ScenarioName = S.ScenarioName

INNER JOIN dbo.DimWorkingCapital AS WC
    ON SWC.WorkingCapitalCategory = WC.WorkingCapitalCategory
    AND SWC.WorkingCapitalItem = WC.WorkingCapitalItem

WHERE SWC.CompanyName = 'Company A'
    AND SWC.[Year] BETWEEN 2023 AND 2025;            
GO
