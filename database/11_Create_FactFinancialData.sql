/*
==================================================================================
Project   : Financial Analytics SQL
Script    : 11_Create_FactFinancialData.sql
Purpose   : Create the FactFinancialData table
Author    : Sergii Khomenko
==================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO 

CREATE TABLE dbo.FactFinancialData
(
    FinancialDataId BIGINT IDENTITY(1,1) NOT NULL,
    CompanyId INT NOT NULL,
    PeriodId INT NOT NULL,
    ScenarioId INT NOT NULL,
    DirectionId INT NOT NULL,
    IndicatorId INT NOT NULL,
    Amount DECIMAL(19,4) NOT NULL,

    CONSTRAINT PK_FactFinancialData
        PRIMARY KEY (FinancialDataId),

    CONSTRAINT FK_FactFinancialData_DimCompany
        FOREIGN KEY (CompanyId)
        REFERENCES dbo.DimCompany (CompanyId),

    CONSTRAINT FK_FactFinancialData_DimPeriod
        FOREIGN KEY(PeriodId)
        REFERENCES dbo.DimPeriod(PeriodId),

    CONSTRAINT FK_FactFinancialData_DimScenario
        FOREIGN KEY(ScenarioId)
        REFERENCES dbo.DimScenario(ScenarioId),

    CONSTRAINT FK_FactFinancialData_DimDirection
        FOREIGN KEY(DirectionId)
        REFERENCES dbo.DimDirection(DirectionId),     

    CONSTRAINT FK_FactFinancialData_DimFinancialIndicator
        FOREIGN KEY(IndicatorId)
        REFERENCES dbo.DimFinancialIndicator(IndicatorId),
    
    CONSTRAINT UQ_FinancialData_BusinessKey
        UNIQUE
        (
            CompanyId,
            PeriodId,
            ScenarioId,
            DirectionId,
            IndicatorId
        )                    
);
GO
