USE FinanceAnalyticsPortfolioDB;
GO 

CREATE TABLE dbo.FactSales
(
    FactSalesId INT IDENTITY(1,1) NOT NULL,
    CompanyId INT NOT NULL,
    ScenarioId INT NOT NULL,
    PeriodId INT NOT NULL,
    DirectionId INT NOT NULL,
    Volume DECIMAL(18,4) NOT NULL,
    Price DECIMAL(18,4) NOT NULL,
    RevenueAmount DECIMAL(18,4) NOT NULL,

    CONSTRAINT PK_FactSales
    PRIMARY KEY (FactSalesId)
);


