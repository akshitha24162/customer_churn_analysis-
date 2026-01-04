--Q1.How many customers are leaving the company?
SELECT
  churn,
  COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer) AS churn_percentage
FROM customer
GROUP BY churn;

---Q2.Is the international plan a churn risk?
SELECT
  international_plan,
  churn,
  COUNT(*) AS total_customers
FROM customer
GROUP BY international_plan, churn
ORDER BY international_plan;

---Q3.Are customers contacting support more before leaving?
SELECT
  churn,
  AVG(customer_service_calls) AS avg_service_calls
FROM customer
GROUP BY churn;

---Q4.Are valuable customers leaving?
SELECT 
    AVG("Total eve minutes") AS avg_evening_minutes
FROM customer;


---Q5.Where should retention teams focus?
SELECT
  "State",
  COUNT(*) AS churned_customers
FROM customer
WHERE churn = true
GROUP BY "State"
ORDER BY churned_customers DESC
LIMIT 5;

--Q6.Do value-added services help retain customers?
SELECT
  voice_mail_plan,
  churn,
  COUNT(*) AS customers
FROM customer
GROUP BY voice_mail_plan, churn;

---Q7.Do new customers churn more?
SELECT
  CASE
    WHEN account_length <= 100 THEN '0–100'
    WHEN account_length <= 200 THEN '101–200'
    WHEN account_length <= 300 THEN '201–300'
    ELSE '300+'
  END AS tenure_group,
  churn,
  COUNT(*) AS customers
FROM customer
GROUP BY tenure_group, churn
ORDER BY tenure_group;

---Q8.Does billing amount affect churn?
SELECT 
    AVG("Total day charge" + "Total eve charge" + "Total night charge") AS avg_total_charge
FROM customer;

---Q9.Used for proactive retention campaigns
SELECT *
FROM customer
WHERE customer_service_calls > 3
  AND international_plan = 'Yes'
  AND total_day_minutes > 200;

---Q10.Reusable object for dashboards
CREATE VIEW churn_summary AS
SELECT
  churn,
  COUNT(*) AS total_customers,
  AVG(total_day_minutes) AS avg_day_minutes,
  AVG(customer_service_calls) AS avg_service_calls
FROM customer
GROUP BY churn;



