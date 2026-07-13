/*
===================================================================================
Project    : Finance Analytics SQL
Script     : 04_Insert_DimScenario.sql
Purpose    : Populate the DimScenario table
Author     : Sergii Khomenko
===================================================================================
*/ 

USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimScenario
(    
    ScenarioName,
    ScenarioSortOrder
)    
VALUES
    ('Actual', 1),
    ('Budget', 2),
    ('Forecast', 3);
GO

SELECT 
    ScenarioId,
    ScenarioName,
    ScenarioSortOrder
FROM dbo.DimScenario
ORDER BY ScenarioSortOrder;
GO

