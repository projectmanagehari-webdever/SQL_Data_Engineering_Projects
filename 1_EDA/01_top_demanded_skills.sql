/*
Question: What are the most in-demand  skills for data engineer?
- Identify the top 10 in-demand skills for data engineer
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market providing insights into most valuable skills for data engineer looking for remote work. 
*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_job
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON sjd.job_id = jpf.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = True
GROUP BY
    sd.skills
ORDER BY demand_job DESC
LIMIT 10;

/*
┌────────────┬────────────┐
│   skills   │ demand_job │
│  varchar   │   int64    │
├────────────┼────────────┤
│ sql        │      29221 │
│ python     │      28776 │
│ aws        │      17823 │
│ azure      │      14143 │
│ spark      │      12799 │
│ airflow    │       9996 │
│ snowflake  │       8639 │
│ databricks │       8183 │
│ java       │       7267 │
│ gcp        │       6446 │
└────────────┴────────────┘
  10 rows       2 columns
*/

