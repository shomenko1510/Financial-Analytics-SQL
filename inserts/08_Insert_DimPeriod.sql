/*
=================================================================================
Project    : Financial Analytics SQL
Script     : 08_InsertDimPeriod
Purpose    : Populate the DimPeriod table
Author     : Sergii Khomenko
=================================================================================
*/
USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimPeriod
(
    [Year],
    [Quarter],
    QuarterNumber,
    PeriodName,
    PeriodSortOrder 
)
VALUES 
    (2022, 'Q1', 1, 'Q1 2022', 20221),
    (2022, 'Q2', 2, 'Q2 2022', 20222),
    (2022, 'Q3', 3, 'Q3 2022', 20223),
    (2022, 'Q4', 4, 'Q4 2022', 20224),

    (2023, 'Q1', 1, 'Q1 2023', 20231),
    (2023, 'Q2', 2, 'Q2 2023', 20232),
    (2023, 'Q3', 3, 'Q3 2023', 20233),
    (2023, 'Q4', 4, 'Q4 2023', 20234),

    (2024, 'Q1', 1, 'Q1 2024', 20241),
    (2024, 'Q2', 2, 'Q2 2024', 20242),
    (2024, 'Q3', 3, 'Q3 2024', 20243),
    (2024, 'Q4', 4, 'Q4 2024', 20244),

    (2025, 'Q1', 1, 'Q1 2025', 20251),
    (2025, 'Q2', 2, 'Q2 2025', 20252),
    (2025, 'Q3', 3, 'Q3 2025', 20253),
    (2025, 'Q4', 4, 'Q4 2025', 20254),

    (2026, 'Q1', 1, 'Q1 2026', 20261),
    (2026, 'Q2', 2, 'Q2 2026', 20262),
    (2026, 'Q3', 3, 'Q3 2026', 20263),
    (2026, 'Q4', 4, 'Q4 2026', 20264);
GO

SELECT 
    PeriodId,
    [Year],
    [Quarter],
    QuarterNumber,
    PeriodName,
    PeriodSortOrder
FROM dbo.DimPeriod
ORDER BY PeriodSortOrder;
GO


