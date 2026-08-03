/*
==========================================================================================================
Project    : Financial Analitics SQL
Script     : 16_Add_FactCOGS_Constraints.sql
Purpose    : Add constraint to the FactCOGS table
Author     : Sergii Khomenko
==========================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

ALTER TABLE dbo.FactCOGS
ADD CONSTRAINT FK_FactCOGS_DimCompany
FOREIGN KEY (CompanyId)
REFERENCES dbo.DimCompany(CompanyId);
GO

ALTER TABLE dbo.FactCOGS
ADD CONSTRAINT FK_FactCOGS_DimPeriod
FOREIGN KEY (PeriodId)
REFERENCES dbo.DimPeriod(PeriodId);
GO

ALTER TABLE dbo.FactCOGS
ADD CONSTRAINT FK_FactCOGS_DimScenario
FOREIGN KEY (ScenarioId)
REFERENCES dbo.DimScenario(ScenarioId);
GO

ALTER TABLE dbo.FactCOGS
ADD CONSTRAINT FK_FactCOGS_DimDirection
FOREIGN KEY (DirectionId)
REFERENCES dbo.DimDirection(DirectionId);
GO

ALTER TABLE dbo.FactCOGS
ADD CONSTRAINT UQ_FactCOGS
UNIQUE
(
    CompanyId,
    PeriodId,
    ScenarioId,
    DirectionId
);
GO
