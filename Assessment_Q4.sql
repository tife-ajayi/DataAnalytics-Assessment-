
-- Q4: Customer Lifetime Value (CLV) Estimation
-- This query estimates the customer lifetime value based on tenure and total deposit value.

WITH CustomerMetrics AS (
    SELECT 
        u.id AS customer_id,
        u.name,
        COUNT(s.id) AS total_transactions,
        SUM(s.confirmed_amount) AS total_transaction_value,
        ROUND(DATEDIFF(MAX(s.transaction_date), MIN(s.transaction_date)) / 30) + 1 AS tenure_months
    FROM users_customuser u
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    WHERE s.confirmed_amount > 0
    GROUP BY u.id, u.name
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND((total_transactions / GREATEST(tenure_months, 1)) * 12 * (total_transaction_value / total_transactions * 0.001) / 100, 2) AS estimated_clv
FROM CustomerMetrics
ORDER BY estimated_clv DESC;
