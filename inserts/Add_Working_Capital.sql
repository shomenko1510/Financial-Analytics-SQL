USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimFinancialIndicator
(
    IndicatorCode,
    IndicatorName,
    IndicatorCategory,
    UnitOfMeasure,
    IndicatorSortOrder

)
VALUES
    ('INV',              'Total Inventory',                     'Balance Sheet',        'ths. UAN',     33),
    ('AR',               'Total Trade Receivables',             'Balance Sheet',        'ths. UAN',     34),
    ('AP',               'Total Payables',                      'Balance Sheet',        'ths. UAN',     35);
GO    
    

SELECT 
    IndicatorCode,
    IndicatorName,
    IndicatorCategory
FROM dbo.DimFinancialIndicator
WHERE IndicatorCode IN('INV', 'AR', 'AP');    