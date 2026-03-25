-- Overall Success Rate
SELECT 
  COUNT(*) AS total_transactions,
  SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) AS Successful_transactions,
  ROUND(
    SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
  ) AS Success_rate_percentage
FROM transactions;

-- Success Rate by Gateway
SELECT 
  gateway,
  COUNT(*) AS total,
  SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) AS Success_count,
  ROUND(
    SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
  ) AS Success_rate
FROM transactions
GROUP BY gateway
ORDER BY Success_rate DESC;

-- Failure Breakdown
SELECT 
  failure_reason,
  COUNT(*) AS failure_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM transactions
WHERE status = 'Failed'
GROUP BY failure_reason
ORDER BY failure_count DESC;

-- Daily Trend Analysis
SELECT 
  date,
  COUNT(*) AS total_transactions,
  SUM(CASE WHEN status = 'Success' THEN 1 ELSE 0 END) AS Success_count
FROM transactions
GROUP BY date
ORDER BY date;
