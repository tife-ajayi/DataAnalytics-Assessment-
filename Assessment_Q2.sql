
-- Q2: Transaction Frequency Analysis
-- This query categorizes customers based on their average number of transactions per month.

WITH SavingsCustomers AS (
    SELECT 
        u.id AS customer_id,
        COUNT(s.id) AS total_transactions,
        ROUND(DATEDIFF(MAX(s.created_at), MIN(s.created_at)) / 30) + 1 AS tenure_months
    FROM users_customuser u
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    JOIN plans_plan p ON s.plan_id = p.id
    WHERE p.is_regular_savings = 1
    GROUP BY u.id
),
TransactionFrequency AS (
    SELECT 
        customer_id,
        total_transactions / GREATEST(tenure_months, 1) AS avg_transactions_per_month
    FROM SavingsCustomers
),
FrequencyCategories AS (
    SELECT 
        customer_id,
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_transactions_per_month
    FROM TransactionFrequency
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM FrequencyCategories
GROUP BY frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
