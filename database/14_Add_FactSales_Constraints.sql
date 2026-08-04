USE FinanceAnalyticsPortfolioDB;
GO

ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimCompany
FOREIGN KEY (CompanyId)
REFERENCES dbo.DimCompany (CompanyId);

GO

ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimPeriod
FOREIGN KEY (PeriodId)
REFERENCES dbo.DimPeriod (PeriodId);

GO

ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimScenario
FOREIGN KEY (ScenarioId)
REFERENCES dbo.DimScenario(ScenarioId)

GO

ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimDirection
FOREIGN KEY (DirectionId)
REFERENCES dbo.DimDirection(DirectionId)

GO

ALTER TABLE dbo.FactSales
ADD CONSTRAINT UQ_FactSales
UNIQUE
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId
);

GO

