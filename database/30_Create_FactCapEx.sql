USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.FactCapEx
(
    CapExFactId INT IDENTITY(1,1) NOT NULL,
    CompanyId INT NOT NULL,
    PeriodId INT NOT NULL,
    ScenarioId INT NOT NULL,
    CapExId INT NOT NULL,
    CapAmount DECIMAL(18,4) NOT NULL,

    CONSTRAINT PK_FactCapEx
        PRIMARY KEY (CapExFactId)  
);
GO
