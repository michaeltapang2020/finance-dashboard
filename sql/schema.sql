-- =============================================================================
   -- NovaTech Solutions Finance Database Schema (MySQL Version)
   -- =============================================================================

   DROP DATABASE IF EXISTS novatech_finance;
   CREATE DATABASE novatech_finance;
   USE novatech_finance;

   -- Dim_Date
   CREATE TABLE Dim_Date (
       DateKey INT PRIMARY KEY,
       Date DATE NOT NULL,
       Year INT NOT NULL,
       Quarter VARCHAR(10) NOT NULL,
       Month INT NOT NULL,
       MonthName VARCHAR(20) NOT NULL,
       YearMonth VARCHAR(10) NOT NULL
   );

   -- Dim_Product
   CREATE TABLE Dim_Product (
       ProductID VARCHAR(10) PRIMARY KEY,
       ProductName VARCHAR(100) NOT NULL,
       Category VARCHAR(50) NOT NULL,
       UnitCost DECIMAL(10,2) NOT NULL,
       LaunchYear INT NOT NULL
   );

   -- Dim_Region
   CREATE TABLE Dim_Region (
       RegionID VARCHAR(10) PRIMARY KEY,
       RegionName VARCHAR(50) NOT NULL,
       SalesManager VARCHAR(100) NOT NULL,
       TargetGrowth DECIMAL(5,4) NOT NULL
   );

   -- Dim_Customer
   CREATE TABLE Dim_Customer (
       CustomerID VARCHAR(10) PRIMARY KEY,
       CustomerName VARCHAR(100) NOT NULL,
       Segment VARCHAR(50) NOT NULL,
       AccountTier VARCHAR(20) NOT NULL
   );

   -- Fact_Actuals
   CREATE TABLE Fact_Actuals (
       DateKey INT NOT NULL,
       ProductID VARCHAR(10) NOT NULL,
       RegionID VARCHAR(10) NOT NULL,
       Units INT NOT NULL,
       UnitPrice DECIMAL(10,2) NOT NULL,
       Revenue DECIMAL(15,2) NOT NULL,
       COGS DECIMAL(15,2) NOT NULL,
       Opex DECIMAL(15,2) NOT NULL,
       PRIMARY KEY (DateKey, ProductID, RegionID),
       FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey),
       FOREIGN KEY (ProductID) REFERENCES Dim_Product(ProductID),
       FOREIGN KEY (RegionID) REFERENCES Dim_Region(RegionID)
   );

   -- Fact_Budget
   CREATE TABLE Fact_Budget (
       DateKey INT NOT NULL,
       ProductID VARCHAR(10) NOT NULL,
       RegionID VARCHAR(10) NOT NULL,
       BudgetRevenue DECIMAL(15,2) NOT NULL,
       BudgetCOGS DECIMAL(15,2) NOT NULL,
       BudgetOpex DECIMAL(15,2) NOT NULL,
       PRIMARY KEY (DateKey, ProductID, RegionID),
       FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey),
       FOREIGN KEY (ProductID) REFERENCES Dim_Product(ProductID),
       FOREIGN KEY (RegionID) REFERENCES Dim_Region(RegionID)
   );

   -- Indexes
   CREATE INDEX idx_actuals_date ON Fact_Actuals(DateKey);
   CREATE INDEX idx_actuals_product ON Fact_Actuals(ProductID);
   CREATE INDEX idx_actuals_region ON Fact_Actuals(RegionID);
   CREATE INDEX idx_budget_date ON Fact_Budget(DateKey);