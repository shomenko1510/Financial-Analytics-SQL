USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.StgFinancialData
(
    CompanyName NVARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] NVARCHAR(10) NOT NULL,
    ScenarioName NVARCHAR(60) NOT NULL,
    IndicatorName NVARCHAR(150) NOT NULL,
    Amount DECIMAL(18,4) NOT NULL
);
GO
