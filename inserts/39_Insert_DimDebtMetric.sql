USE FinanceAnalyticsPortfolioDB;
GO

INSERT INTO dbo.DimDebtMetric
(
    DebtMetricName
)
VALUES
    ('Opening Loan Balance'),
    ('Loan Drawdown'),
    ('Loan Repayment'),
    ('Closing Loan Balance'),
    ('Interest Rate'),
    ('Interest Expense');
GO
