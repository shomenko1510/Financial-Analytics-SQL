USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.StgWorkingCapital

(
    CompanyName NVARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] NVARCHAR(10) NOT NULL,
    ScenarioName NVARCHAR(50) NOT NULL,
    WorkingCapitalCategory NVARCHAR(100) NOT NULL,
    WorkingCapitalItem NVARCHAR(100) NOT NULL,
    WorkingCapitalAmount DECIMAL(18,4) NOT NULL 
);
GO


