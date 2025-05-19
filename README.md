
# Data Analytics SQL Assessment

This repository contains solutions to a SQL proficiency assessment designed to evaluate the ability to work with relational databases using SQL. The solutions below are optimized for **MySQL** and are based on the schema provided through four tables:

- `users_customuser`: customer demographic and profile data
- `plans_plan`: records of plans, flags for savings or investments
- `savings_savingsaccount`: deposit transaction records
- `withdrawals_withdrawal`: withdrawal history (not used directly)

---

## ✅ Question Breakdown & Approach

### **Assessment_Q1.sql – High-Value Customers with Multiple Products**

**Scenario**: Identify customers with both a funded savings plan and a funded investment plan.  
**Approach**:
- Join `users_customuser`, `savings_savingsaccount`, and `plans_plan`
- Filter for records where `confirmed_amount > 0`
- Ensure one `is_regular_savings = 1` and one `is_a_fund = 1` per customer
- Aggregate and sort by total deposits

---

### **Assessment_Q2.sql – Transaction Frequency Analysis**

**Scenario**: Segment customers by average number of transactions per month.  
**Approach**:
- Aggregate transaction count and compute tenure in months (approximate via days / 30)
- Calculate `avg_transactions_per_month`
- Use `CASE` to assign frequency category:
  - High: ≥10
  - Medium: 3–9
  - Low: ≤2

---

### **Assessment_Q3.sql – Account Inactivity Alert**

**Scenario**: Flag accounts with no deposit activity in over a year.  
**Approach**:
- Use `MAX(created_at)` from `savings_savingsaccount` grouped by `plan_id` and `owner_id`
- Filter for `confirmed_amount > 0`
- Use `DATEDIFF(CURDATE(), last_transaction_date) > 365` to find inactive accounts
- Categorize type as "Savings" or "Investments" from plan flags

---

### **Assessment_Q4.sql – Customer Lifetime Value (CLV) Estimation**

**Scenario**: Estimate customer lifetime value using simplified formula.  
**Approach**:
- Compute tenure in months from earliest to latest deposit
- Aggregate transaction count and average value
- Use CLV formula:  
  `(total_transactions / tenure) * 12 * (avg_txn_value * 0.001) / 100`

---

## 📌 Assumptions

- Amount fields are stored in **kobo**, so final values are adjusted by `/100`
- `created_at` in `savings_savingsaccount` is used as transaction timestamp
- `transactions` table is not provided, so deposits are inferred from `savings_savingsaccount`
- `withdrawals_withdrawal` is not directly used in any of the core questions

---

## ⚙️ Execution Environment

- SQL Flavor: **MySQL 8+**
- Ensure `.csv` datasets are loaded into respective tables prior to query execution

---

## 🚧 Challenges

- Some date functions (e.g., `DATEDIFF(MONTH, ...)`) are not supported in MySQL; used `DATEDIFF / 30` workaround
- Schema understanding required restructuring provided solutions to match actual data

---

## 📁 Repository Structure

```
DataAnalytics-Assessment/
│
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
├── README.md
```

---

Prepared and optimized for SQL-based data analysis evaluation.
