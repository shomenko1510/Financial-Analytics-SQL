USE FinanceAnalyticsPortfolioDB;
GO 

CREATE TABLE dbo.FactSales
(
    SalesId BIGINT IDENTITY(1,1) Primary KEY,
    CompanyId INT NOT NULL,
    PeriodId INT NOT NULL,
    ScenarioId INT NOT NULL,
    DirectionId INT NOT NULL,
    Volume DECIMAL(19,4) NULL,
    Price DECIMAL(19,4) NULL,
    RevenueAmount DECIMAL(19,4) NOT NULL
);


