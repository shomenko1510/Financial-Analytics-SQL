USE FinanceAnalyticsPortfolioDB;
GO

ALTER TABLE dbo.FactCapEx
ADD CONSTRAINT FK_FactCapEx_DimCompany
FOREIGN KEY (CompanyId)
REFERENCES dbo.DimCompany (CompanyId);
GO

ALTER TABLE dbo.FactCapEx
ADD CONSTRAINT FK_FactCapEx_DimPeriod
FOREIGN KEY (PeriodId)
REFERENCES dbo.DimPeriod (PeriodId);
GO

ALTER TABLE dbo.FactCapEx
ADD CONSTRAINT FK_FactCapEx_DimScenario
FOREIGN KEY (ScenarioId)
REFERENCES dbo.DimScenario (ScenarioId);
GO

ALTER TABLE dbo.FactCapEx
ADD CONSTRAINT FK_FactCapEx_DimCapEx
FOREIGN KEY(CapExId)
REFERENCES dbo.DimCapEx (CapExId);
GO