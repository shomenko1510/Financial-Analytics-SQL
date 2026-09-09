USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.StgDebtSchedule
(
        CompanyNmae NVARCHAR(100) NOT NULL,
        [Year] INT NOT NULL,
        [Quarter] NVARCHAR(10) NOT NULL,
        ScenarioName NVARCHAR(50) NOT NULL,
        DebtMetricName NVARCHAR(100) NOT NULL,
        DebtMatricValue DECIMAL(18,4) NOT NULL
           
);
GO

