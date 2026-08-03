/*
==========================================================================================================
Project    : Financial Analitics SQL
Script     : 22_Add_FactWorkingCapital_Constraints.sql
Purpose    : Add constraints to the FactWorkingCapital table
Author     : Sergii Khomenko
==========================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO 

ALTER TABLE dbo.FactWorkingCapital
ADD CONSTRAINT FK_FactWorkingCapital_DimCompany
FOREIGN KEY (CompanyId)
REFERENCES dbo.DimCompany(CompanyId);
GO

ALTER TABLE dbo.FactWorkingCapital
ADD CONSTRAINT FK_FactWorkingCapital_DimPeriod
FOREIGN KEY (PeriodId)
REFERENCES dbo.DimPeriod(PeriodId);
GO

ALTER TABLE dbo.FactWorkingCapital
ADD CONSTRAINT FK_FactWorkingCapital_DimScenario
FOREIGN KEY (ScenarioId)
REFERENCES dbo.DimScenario(ScenarioId);
GO

ALTER TABLE dbo.FactWorkingCapital
ADD CONSTRAINT FK_FactWorkingCapital_DimWorkingCapital
FOREIGN KEY (WorkingCapitalId)
REFERENCES dbo.DimWorkingCapital(WorkingCapitalId);
GO
