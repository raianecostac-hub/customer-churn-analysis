-- ============================================
-- CUSTOMER CHURN ANALYSIS
-- Author: Raiane Camara
-- Tools: SQLite / DBeaver
-- ============================================


-- ============================================
-- 1. OVERALL CHURN RATE
-- ============================================
SELECT
    Churn,
    COUNT(*) AS Total_Customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM customer_churn
GROUP BY Churn;


-- ============================================
-- 2. CHURN RATE BY CONTRACT TYPE
-- ============================================
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Binary) AS Churned,
    ROUND(SUM(Churn_Binary) * 100.0 / COUNT(*), 2) AS Churn_Rate_Pct
FROM customer_churn
GROUP BY Contract
ORDER BY Churn_Rate_Pct DESC;


-- ============================================
-- 3. CHURN RATE BY INTERNET SERVICE
-- ============================================
SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Binary) AS Churned,
    ROUND(SUM(Churn_Binary) * 100.0 / COUNT(*), 2) AS Churn_Rate_Pct,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charge
FROM customer_churn
GROUP BY InternetService
ORDER BY Churn_Rate_Pct DESC;


-- ============================================
-- 4. FINANCIAL IMPACT OF CHURN
-- ============================================
SELECT
    Churn,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Revenue,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charge,
    ROUND(SUM(MonthlyCharges) * 12, 2) AS Projected_Annual_Revenue,
    ROUND(AVG(tenure), 1) AS Avg_Tenure_Months
FROM customer_churn
GROUP BY Churn;


-- ============================================
-- 5. CHURN RATE BY KEY SERVICES
-- ============================================
SELECT
    OnlineSecurity,
    TechSupport,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Binary) AS Churned,
    ROUND(SUM(Churn_Binary) * 100.0 / COUNT(*), 2) AS Churn_Rate_Pct
FROM customer_churn
WHERE OnlineSecurity != 'No internet service'
GROUP BY OnlineSecurity, TechSupport
ORDER BY Churn_Rate_Pct DESC;


-- ============================================
-- 6. HIGH RISK CUSTOMER PROFILE
-- ============================================
SELECT
    Contract,
    InternetService,
    OnlineSecurity,
    TechSupport,
    COUNT(*) AS Total_Customers,
    SUM(Churn_Binary) AS Churned,
    ROUND(SUM(Churn_Binary) * 100.0 / COUNT(*), 2) AS Churn_Rate_Pct,
    ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charge
FROM customer_churn
WHERE Contract = 'Month-to-month'
    AND InternetService = 'Fiber optic'
    AND OnlineSecurity = 'No'
    AND TechSupport = 'No'
GROUP BY Contract, InternetService, OnlineSecurity, TechSupport;
