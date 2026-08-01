/*
================================================================================================
Project   : Financial Analitics SQL
Script    : 19_Add_FactOPEX_Constraint.sql
Purpose   : Add foreign key constraints to the factOPEX table
Author    : Sergii Khomenko
================================================================================================
*/

ALTER TABLE dbo.FactOPEX
ADD CONSTRAINT FK_FactOPEX_DimCompany
FOREIGN KEY (CompanyId)
REFERENCES dbo.DimCompany(CompanyId);
GO

ALTER TABLE dbo.FactOPEX
ADD CONSTRAINT FK_FactOPEX_DimPeriod
FOREIGN KEY (PeriodId)
REFERENCES dbo.DimPeriod(PeriodId);
GO

ALTER TABLE dbo.FactOPEX
ADD CONSTRAINT FK_FactOPEX_DimScenario
FOREIGN KEY (ScenarioId)
REFERENCES dbo.DimScenario(ScenarioId);
GO

ALTER TABLE dbo.FactOPEX
ADD CONSTRAINT FK_FactOPEX_OPEXId
FOREIGN KEY (OPEXId)
REFERENCES dbo.DimOPEX(OPEXId);
GO 
