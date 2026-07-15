/*
==============================================================================
Project    : Financial Analitics SQL
Script     : 10_Insert_DimFinancialIndicator.sql
Purpose    : Populate the DimFinancialIndicator table
Author     : Sergii Khomenko
==============================================================================
*/

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
    ('REV',        'Revenue',               'Income Statment',   'ths. UAN',   1),
    ('COGS',       'Cost of Goods Sold',    'Income Statment',   'ths. UAN',   2),
    ('GP',         'Gross Profit',          'Income Statment',   'ths. UAN',   3),
    ('OPEX',       'Operating Expenses',    'Income Statment',   'ths. UAN',   4),
    ('EBITDA',     'EBITDA',                'Income Statment',   'ths. UAN',   5),
    ('NP',         'Net Profit',            'Income Statment',   'ths. UAN',   6),

    ('AR',         'Accounts Receivable',   'Working Capital',   'ths. UAN',   7),
    ('INV',        'Inventory',             'Working Capital',   'ths. UAN',   8),
    ('AP',         'Accounts Payable',      'Working Capital',   'ths. UAN',   9),

    ('OCF',        'Operating cash Flow',   'Cash Flow',         'ths. UAN',  10),
    ('CAPEX',      'Capital Expenditures',  'Cash Flow',         'ths. UAN',  11),
    ('CASH_OPEN',  'Opening Cash Balance',  'Cash Flow',         'ths. UAN',  12),
    ('CASH_CLOSE', 'Closing Cash Balance',  'Cash Flow',         'ths. UAN',  13);
GO

SELECT
    IndicatorId,
    IndicatorCode,
    IndicatorName,
    IndicatorCategory,
    UnitOfMeasure,
    IndicatorSortOrder
FROM dbo.DimFinancialIndicator
ORDER BY IndicatorSortOrder
GO     