USE credit_risk_analytics;
SHOW TABLES;

SELECT * FROM credit_card_default LIMIT 10; -- to check data is imported correctly or not
SELECT COUNT(*) FROM credit_card_default; -- check all rows are present or not

-- overall KPI calculations
SELECT
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    COUNT(*) - SUM(`default payment next month`) AS Non_Defaults,
    ROUND(
        SUM(`default payment next month`) * 100.0 / COUNT(*), 2
    ) AS Default_Rate_Percentage,
    ROUND(AVG(LIMIT_BAL), 2) AS Average_Credit_Limit,
    SUM(LIMIT_BAL) AS Total_Credit_Limit,
    SUM(CASE
        WHEN `default payment next month` = 1
        THEN LIMIT_BAL ELSE 0
    END) AS Credit_Limit_Of_Defaulted_Customers,
    ROUND(AVG(CASE
        WHEN `default payment next month` = 1
        THEN LIMIT_BAL
    END), 2) AS Average_Credit_Limit_Of_Defaulted_Customers
FROM credit_card_default
WHERE ID <> 'ID';

-- Customer segments
SELECT
    EDUCATION,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default
WHERE ID <> 'ID'
GROUP BY EDUCATION
ORDER BY Default_Rate_Percentage DESC;

-- Default rate by gender
SELECT
    SEX,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default
WHERE ID <> 'ID'
GROUP BY SEX
ORDER BY Default_Rate_Percentage DESC;

-- Default rate by marital status
SELECT
    MARRIAGE,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default
WHERE ID <> 'ID'
GROUP BY MARRIAGE
ORDER BY Default_Rate_Percentage DESC;

-- Age-wise default rate
SELECT
    CASE
        WHEN AGE < 30 THEN 'Young'
        WHEN AGE < 40 THEN 'Adult'
        WHEN AGE < 50 THEN 'Middle-Aged'
        ELSE 'Senior'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default
WHERE ID <> 'ID'
GROUP BY Age_Group
ORDER BY Default_Rate_Percentage DESC;

-- Default rate by credit-limit category
SELECT
    CASE
        WHEN LIMIT_BAL <= 50000 THEN 'Low'
        WHEN LIMIT_BAL <= 150000 THEN 'Medium'
        ELSE 'High'
    END AS Credit_Limit_Category,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default
WHERE ID <> 'ID'
GROUP BY Credit_Limit_Category
ORDER BY Default_Rate_Percentage DESC;

-- Average credit limit by default status
SELECT
    `default payment next month` AS Default_Status,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(LIMIT_BAL), 2) AS Average_Credit_Limit
FROM credit_card_default
WHERE ID <> 'ID'
GROUP BY `default payment next month`;

-- PAY_0
SELECT
    PAY_0 AS Repayment_Status,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default
WHERE ID <> 'ID'
GROUP BY PAY_0
ORDER BY PAY_0;

-- Compare all repayment periods
SELECT
    'PAY_0' AS Repayment_Period,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN PAY_0 > 0 THEN 1 ELSE 0 END) AS Delayed_Customers,
    ROUND(
        SUM(CASE WHEN PAY_0 > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS Delay_Percentage
FROM credit_card_default WHERE ID <> 'ID'
UNION ALL
SELECT
    'PAY_2',
    COUNT(*),
    SUM(CASE WHEN PAY_2 > 0 THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN PAY_2 > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM credit_card_default WHERE ID <> 'ID'
UNION ALL
SELECT
    'PAY_3',
    COUNT(*),
    SUM(CASE WHEN PAY_3 > 0 THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN PAY_3 > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM credit_card_default WHERE ID <> 'ID'
UNION ALL
SELECT
    'PAY_4',
    COUNT(*),
    SUM(CASE WHEN PAY_4 > 0 THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN PAY_4 > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM credit_card_default WHERE ID <> 'ID'
UNION ALL
SELECT
    'PAY_5',
    COUNT(*),
    SUM(CASE WHEN PAY_5 > 0 THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN PAY_5 > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM credit_card_default WHERE ID <> 'ID'
UNION ALL
SELECT
    'PAY_6',
    COUNT(*),
    SUM(CASE WHEN PAY_6 > 0 THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN PAY_6 > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM credit_card_default WHERE ID <> 'ID';

-- age groups show higher risk
SELECT
    CASE
        WHEN AGE < 30 THEN 'Young'
        WHEN AGE < 40 THEN 'Adult'
        WHEN AGE < 50 THEN 'Middle-Aged'
        ELSE 'Senior'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(AVG(LIMIT_BAL), 2) AS Average_Credit_Limit,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default WHERE ID <> 'ID'
GROUP BY Age_Group ORDER BY Default_Rate_Percentage DESC;

-- demographic segments differ in observed default rates
DROP TABLE if exists gender_lookup;
CREATE TABLE gender_lookup (
    SEX INT PRIMARY KEY,
    Gender_Category VARCHAR(20)
);
SHOW TABLES;

INSERT INTO gender_lookup VALUES
(1, 'Male'),
(2, 'Female');
SELECT * FROM gender_lookup;

-- Gender-wise default analysis using JOIN
SELECT
    g.Gender_Category,
    COUNT(c.ID) AS Total_Customers,
    SUM(c.`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(c.`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default c
JOIN gender_lookup g ON c.SEX = g.SEX WHERE c.ID <> 'ID'
GROUP BY g.Gender_Category ORDER BY Default_Rate_Percentage DESC;

-- Default rate by education and gender
SELECT
    c.EDUCATION,
    g.Gender_Category,
    COUNT(c.ID) AS Total_Customers,
    SUM(c.`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(c.`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default c
JOIN gender_lookup g
    ON c.SEX = g.SEX
WHERE c.ID <> 'ID'
GROUP BY c.EDUCATION, g.Gender_Category
ORDER BY Default_Rate_Percentage DESC;

-- Marital status and gender
SELECT
    c.MARRIAGE,
    g.Gender_Category,
    COUNT(c.ID) AS Total_Customers,
    SUM(c.`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(c.`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage
FROM credit_card_default c
JOIN gender_lookup g ON c.SEX = g.SEX WHERE c.ID <> 'ID'
GROUP BY c.MARRIAGE, g.Gender_Category ORDER BY Default_Rate_Percentage DESC;

-- Identify high-risk customer groups
WITH Customer_Risk AS (
    SELECT
        CASE
            WHEN AGE < 30 THEN 'Young'
            WHEN AGE < 40 THEN 'Adult'
            WHEN AGE < 50 THEN 'Middle-Aged'
            ELSE 'Senior'
        END AS Age_Group,

        CASE
            WHEN LIMIT_BAL <= 50000 THEN 'Low'
            WHEN LIMIT_BAL <= 150000 THEN 'Medium'
            ELSE 'High'
        END AS Credit_Limit_Category,

        COUNT(*) AS Total_Customers,

        SUM(`default payment next month`) AS Total_Defaults,

        ROUND(
            AVG(`default payment next month`) * 100, 2
        ) AS Default_Rate_Percentage

    FROM credit_card_default
    WHERE ID <> 'ID'
    GROUP BY Age_Group, Credit_Limit_Category
)
SELECT * FROM Customer_Risk ORDER BY Default_Rate_Percentage DESC;

-- Rank the highest-risk customer groups
WITH Group_Risk AS (
    SELECT
        CASE
            WHEN AGE < 30 THEN 'Young'
            WHEN AGE < 40 THEN 'Adult'
            WHEN AGE < 50 THEN 'Middle-Aged'
            ELSE 'Senior'
        END AS Age_Group,

        CASE
            WHEN LIMIT_BAL <= 50000 THEN 'Low'
            WHEN LIMIT_BAL <= 150000 THEN 'Medium'
            ELSE 'High'
        END AS Credit_Limit_Category,

        COUNT(*) AS Total_Customers,
        SUM(`default payment next month`) AS Total_Defaults,
        ROUND(AVG(`default payment next month`) * 100, 2)
            AS Default_Rate_Percentage

    FROM credit_card_default
    WHERE ID <> 'ID'
    GROUP BY Age_Group, Credit_Limit_Category
)
SELECT
    Age_Group,
    Credit_Limit_Category,
    Total_Customers,
    Total_Defaults,
    Default_Rate_Percentage,
    RANK() OVER (
        ORDER BY Default_Rate_Percentage DESC
    ) AS Risk_Rank FROM Group_Risk ORDER BY Risk_Rank;
    
-- Identify high-default customer segments
SELECT
    CASE
        WHEN AGE < 30 THEN 'Young'
        WHEN AGE < 40 THEN 'Adult'
        WHEN AGE < 50 THEN 'Middle-Aged'
        ELSE 'Senior'
    END AS Age_Group,
    CASE
        WHEN LIMIT_BAL <= 50000 THEN 'Low'
        WHEN LIMIT_BAL <= 150000 THEN 'Medium'
        ELSE 'High'
    END AS Credit_Limit_Category,
    COUNT(*) AS Total_Customers,
    SUM(`default payment next month`) AS Total_Defaults,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS Default_Rate_Percentage

FROM credit_card_default WHERE ID <> 'ID' 
GROUP BY Age_Group, Credit_Limit_Category
HAVING COUNT(*) >= 1000
   AND AVG(`default payment next month`) > 0.25
ORDER BY Default_Rate_Percentage DESC;

-- Find customers whose credit limit is below the overall average
SELECT
    COUNT(*) AS Total_Defaulted_Customers_Below_Average,
    ROUND(AVG(LIMIT_BAL), 2) AS Average_Credit_Limit,
    MIN(LIMIT_BAL) AS Minimum_Credit_Limit,
    MAX(LIMIT_BAL) AS Maximum_Credit_Limit
FROM credit_card_default
WHERE ID <> 'ID'
  AND `default payment next month` = 1
  AND LIMIT_BAL < (
      SELECT AVG(LIMIT_BAL)
      FROM credit_card_default
      WHERE ID <> 'ID'
  );
  
  -- Compare default rates against the overall portfolio rate
  SELECT
    Age_Group,
    Credit_Limit_Category,
    Total_Customers,
    Total_Defaults,
    Default_Rate_Percentage
FROM (
    SELECT
        CASE
            WHEN AGE < 30 THEN 'Young'
            WHEN AGE < 40 THEN 'Adult'
            WHEN AGE < 50 THEN 'Middle-Aged'
            ELSE 'Senior'
        END AS Age_Group,

        CASE
            WHEN LIMIT_BAL <= 50000 THEN 'Low'
            WHEN LIMIT_BAL <= 150000 THEN 'Medium'
            ELSE 'High'
        END AS Credit_Limit_Category,

        COUNT(*) AS Total_Customers,
        SUM(`default payment next month`) AS Total_Defaults,

        ROUND(
            AVG(`default payment next month`) * 100, 2
        ) AS Default_Rate_Percentage
    FROM credit_card_default WHERE ID <> 'ID'
    GROUP BY Age_Group, Credit_Limit_Category
) AS Segment_Risk
WHERE Default_Rate_Percentage > (
    SELECT AVG(`default payment next month`) * 100
    FROM credit_card_default
    WHERE ID <> 'ID'
)ORDER BY Default_Rate_Percentage DESC;