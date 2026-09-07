USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimDebtMetric
(
    DebtMetricName
)
VALUES
    ('Opening Loan Balance'),
    ('Loan Drawndown'),
    ('Loan Repayment'),
    ('Closing Loan Balanse'),
    ('Interest Rate'),
    ('Interest Expense');
GO
