
-- Q3: Account Inactivity Alert
-- This query finds active accounts (savings or investments) with no deposit in over 365 days.

WITH LastActivity AS (
    SELECT 
        s.plan_id,
        s.owner_id,
        MAX(s.created_at) AS last_transaction_date,
        MAX(p.is_regular_savings) AS is_regular_savings,
        MAX(p.is_a_fund) AS is_a_fund
    FROM savings_savingsaccount s
    JOIN plans_plan p ON s.plan_id = p.id
    WHERE s.confirmed_amount > 0
    GROUP BY s.plan_id, s.owner_id
)
SELECT 
    la.plan_id,
    la.owner_id,
    CASE 
        WHEN la.is_regular_savings = 1 THEN 'Savings'
        WHEN la.is_a_fund = 1 THEN 'Investments'
        ELSE 'Other'
    END AS type,
    la.last_transaction_date,
    DATEDIFF(CURDATE(), la.last_transaction_date) AS inactivity_days
FROM LastActivity la
WHERE DATEDIFF(CURDATE(), la.last_transaction_date) > 365;
