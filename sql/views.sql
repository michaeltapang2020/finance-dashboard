-- =============================================================================
-- Analytical Views (MySQL Version)
-- =============================================================================

-- vw_finance_monthly: Combined actuals vs budget with variance
CREATE OR REPLACE VIEW vw_finance_monthly AS
SELECT 
    a.DateKey,
    d.Year,
    d.Quarter,
    d.Month,
    d.MonthName,
    d.YearMonth,
    a.ProductID,
    p.ProductName,
    p.Category,
    a.RegionID,
    r.RegionName,
    r.SalesManager,
    a.Units,
    a.Revenue AS ActualRevenue,
    a.COGS AS ActualCOGS,
    a.Opex AS ActualOpex,
    (a.Revenue - a.COGS) AS ActualGrossProfit,
    ROUND((a.Revenue - a.COGS) / NULLIF(a.Revenue, 0) * 100, 2) AS ActualGrossMarginPct,
    (a.Revenue - a.COGS - a.Opex) AS ActualOperatingIncome,
    b.BudgetRevenue,
    b.BudgetCOGS,
    b.BudgetOpex,
    (b.BudgetRevenue - b.BudgetCOGS) AS BudgetGrossProfit,
    (a.Revenue - b.BudgetRevenue) AS RevenueVariance,
    ROUND((a.Revenue - b.BudgetRevenue) / NULLIF(b.BudgetRevenue, 0) * 100, 2) AS RevenueVariancePct
FROM Fact_Actuals a
JOIN Fact_Budget b ON a.DateKey = b.DateKey 
    AND a.ProductID = b.ProductID 
    AND a.RegionID = b.RegionID
JOIN Dim_Date d ON a.DateKey = d.DateKey
JOIN Dim_Product p ON a.ProductID = p.ProductID
JOIN Dim_Region r ON a.RegionID = r.RegionID;

-- vw_summary_by_year: Annual summary
CREATE OR REPLACE VIEW vw_summary_by_year AS
SELECT 
    Year,
    SUM(ActualRevenue) AS TotalRevenue,
    SUM(ActualCOGS) AS TotalCOGS,
    SUM(ActualGrossProfit) AS TotalGrossProfit,
    ROUND(SUM(ActualGrossProfit) / NULLIF(SUM(ActualRevenue), 0) * 100, 2) AS GrossMarginPct,
    SUM(ActualOperatingIncome) AS TotalOperatingIncome,
    SUM(BudgetRevenue) AS TotalBudgetRevenue,
    SUM(ActualRevenue) - SUM(BudgetRevenue) AS TotalRevenueVariance,
    ROUND((SUM(ActualRevenue) - SUM(BudgetRevenue)) / NULLIF(SUM(BudgetRevenue), 0) * 100, 2) AS RevenueVariancePct
FROM vw_finance_monthly
GROUP BY Year;

-- vw_summary_by_region: Regional performance
CREATE OR REPLACE VIEW vw_summary_by_region AS
SELECT 
    RegionID,
    RegionName,
    SalesManager,
    SUM(ActualRevenue) AS TotalRevenue,
    SUM(ActualGrossProfit) AS TotalGrossProfit,
    ROUND(SUM(ActualGrossProfit) / NULLIF(SUM(ActualRevenue), 0) * 100, 2) AS GrossMarginPct,
    SUM(BudgetRevenue) AS TotalBudgetRevenue,
    SUM(ActualRevenue) - SUM(BudgetRevenue) AS RevenueVariance,
    ROUND((SUM(ActualRevenue) - SUM(BudgetRevenue)) / NULLIF(SUM(BudgetRevenue), 0) * 100, 2) AS RevenueVariancePct
FROM vw_finance_monthly
GROUP BY RegionID, RegionName, SalesManager;

-- vw_summary_by_product: Product performance
CREATE OR REPLACE VIEW vw_summary_by_product AS
SELECT 
    ProductID,
    ProductName,
    Category,
    SUM(Units) AS TotalUnits,
    SUM(ActualRevenue) AS TotalRevenue,
    SUM(ActualGrossProfit) AS TotalGrossProfit,
    ROUND(SUM(ActualGrossProfit) / NULLIF(SUM(ActualRevenue), 0) * 100, 2) AS GrossMarginPct,
    SUM(BudgetRevenue) AS TotalBudgetRevenue,
    SUM(ActualRevenue) - SUM(BudgetRevenue) AS RevenueVariance,
    ROUND((SUM(ActualRevenue) - SUM(BudgetRevenue)) / NULLIF(SUM(BudgetRevenue), 0) * 100, 2) AS RevenueVariancePct
FROM vw_finance_monthly
GROUP BY ProductID, ProductName, Category;