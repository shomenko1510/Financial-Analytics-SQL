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
    /* Cash balances */
    ('CASH_OPEN',        'Opening Cash Balance',                'Cash Flow',            'ths. UAN',     1),
    /* Income Statement */
    ('REV_EX_VAT',       'Revenue (excl. VAT)',                 'Income Statement',     'ths. UAH',     2),
    ('COGS_EX_VAT',      'COGS (excl. VAT)',                    'Income Statement',     'ths. UAH',     3),
    ('GP',               'Gross Profit',                        'Income Statement',     'ths. UAH',     4),
    ('OTHER_OP_INC',     'Other Operating Income',              'Income Statement',     'ths. UAH',     5),
    ('ADMIN_EXP',        'Administrative Expenses',             'Income Statement',     'ths. UAH',     6),
    ('SELL_EXP',         'Selling Expenses',                    'Income Statement',     'ths. UAH',     7),
    ('OTHER_OP_EXP',     'Other Operating Expenses',            'Income Statement',     'ths. UAH',     8),
    ('DEPR',             'Depreciation',                        'Income Statement',     'ths. UAH',     9),
    ('OTHER_FIN_INC',    'Other Financial Income',              'Income Statement',     'ths. UAH',     10),
    ('FIN_EXP',          'Financial Expenses',                  'Income Statement',     'ths. UAH',     11),
    ('OTHER_EXP',        'Other Expenses',                      'Income Statement',     'ths. UAH',     12),
    ('OTHER_INC',        'Other Income',                        'Income Statement',     'ths. UAH',     13),
    ('PBT',              'Profit Before Tax',                   'Income Statement',     'ths. UAH',     14),
    ('INCOME_TAX',       'Income Tax',                          'Income Statement',     'ths. UAH',     15),
    ('NP',               'Net Profit',                          'Income Statement',     'ths. UAH',     16),
    /* Operating cash flow */
    ('CHG_INV',          'Change in Inventory',                 'Cash Flow',            'ths. UAH',     17),
    ('CHG_AR',           'Change in Trade Receivables',         'Cash Flow',            'ths. UAH',     18),
    ('CHG_AP',           'Change in Trade Payables',            'Cash Flow',            'ths. UAH',     19),
    ('OCF',              'Operating Cash Flow',                 'Cash Flow',            'ths. UAH',     20),
    /* Investing activities */
    ('CAPEX',            'Capital Expenditures',                'Cash Flow',            'ths. UAH',     21),
    ('CF_INV',           'Cash Flow from Investing Activities', 'Cash Flow',            'ths. UAH',     22),
    /* Financing activities */
    ('SHARE_CAP',        'Charge in Share Capital',             'Cash Flow',            'ths. UAH',     23),
    ('TARGET_FIN',       'Target Financing',                    'Cash Flow',            'ths. UAH',     24),
    ('SH_LOANS',         'Loans from Shareholders',             'Cash Flow',            'ths. UAH',     25),
    ('PREPAY_SH_LOANS',  'Prepayment of Shareholders Loans',    'Cash Flow',            'ths. UAH',     26),
    ('BORROWINGS_IN',    'Proceeds from Borrowings',            'Cash Flow',            'ths. UAH',     27),
    ('BORROWINGS_REPAY', 'Repayment of Borrowings',             'Cash Flow',            'ths. UAH',     28),
    ('FIN_OTHER',        'Other',                               'Cash Flow',            'ths. UAH',     29),
    ('CF_FIN',           'Cash Flow from Financing Activities', 'Cash Flow',            'ths. UAH',     30),
    /* Cash movement and closing balance */
    ('NCF',              'Net Cash Flow',                       'Cash Flow',            'ths. UAH',     31),
    ('CASH_CLOSE',       'Closing Cash Balance',                'Cash Flow',            'ths. UAH',     32);

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