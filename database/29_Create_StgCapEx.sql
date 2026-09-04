USE FinanceAnalyticsPortfolioDB;
GO

CREATE TABLE dbo.StgCapEx
(
    CompanyName NVARCHAR(100) NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] NVARCHAR(10),
    ScenarioName NVARCHAR(50) NOT NULL,
    CapExCategory NVARCHAR(100) NOT NULL,
    CapExItem NVARCHAR(100) NOT NULL,
    CapExAmount DECIMAL(18,4) NOT NULL
);
GO