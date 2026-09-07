USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.FactDebtSchedule
(
    DebtFactId INT IDENTITY(1,1) NOT NULL,
    CompanyId INT NOT NULL,
    PeriodId INT NOT NULL,
    ScenarioId INT NOT NULL,
    DebtMetricId INT NOT NULL,
    DebtMetricValue DECIMAL(18,4) NOT NULL,

    CONSTRAINT PK_FactDebtSchedule
        PRIMARY KEY (DebtFactId)
);
GO
