/*
============================================================================================================
Project : Financial Analytics SQL
Script  : 03_Insert_DimDirection.sql
Purpose : Populate the DimDirection table
Author  : Sergii Khomenko
============================================================================================================
*/

USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimDirection
(
    DirectionName,
    DirectionSortOrder
)
VALUES
    ('Business Line A', 1),
    ('Business Line B', 2),
    ('Business Line C', 3),
    ('Business Line D', 4),
    ('Business Line E', 5),
    ('Business Line F', 6),
    ('Business Line G', 7),
    ('Business Line H', 8),
    ('Other', 9);
GO    

SELECT
    DirectionId,
    DirectionName,
    DirectionSortOrder
FROM dbo.DimDirection
ORDER BY DirectionSortOrder;
GO    