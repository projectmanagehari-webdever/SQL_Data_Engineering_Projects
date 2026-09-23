/*
    Question: What are the most optimal skills for data engineers--balacing both demand and salary?
    --  Create a ranking column that combines demand count and median salary to identify the most valuable skills.
    --  Focus only on remote Data Engineer positions with specidied annual salaries.

    Why?
    --  This approach highlights skills that balance market and financial reward. It weights core skills appropriately, rather tan letting rare, outlier skills distort the results.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    -- COUNT(jpf.*) AS demand_job,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_job,
    ROUND(((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000), 2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON sjd.job_id = jpf.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) > 100 
ORDER BY 
    optimal_score DESC
LIMIT 25;


/*
Here is the breakdown of the most optimal skills for Data Engineer, Based on both high demand and high salaries:

Here is a clean, professional, and copy-paste-ready breakdown of your analysis that you can drop straight into your GitHub repository's `README.md` file.


🚀 Most Optimal Skills for Remote Data Engineers (Demand vs. Salary)

To identify the most valuable skills, this analysis balances **market demand** against **financial reward (median salary) for remote Data Engineer roles.

To prevent high-volume foundational skills or rare outlier skills from skewing the results, an **optimal score** was calculated using a natural log transformation of job counts:





📊 Top Findings & Insights

    -- 🏆 Terraform Takes the #1 Spot:** Despite having a lower raw job count than languages like Python or SQL, Terraform commands the **highest median salary ($184,000)** by a wide margin, pushing its optimal score to the top ($0.97$). This highlights how crucial Infrastructure-as-Code (IaC) has become for modern data engineering.
    -- 🐍 The Undisputed Pillars (Python, SQL, AWS):** Python ($135k) and SQL ($130k) dominate market demand with the highest volume ($\ln \approx 7.0$), paired with strong compensation. AWS closely follows as the leading cloud platform ($137.3k).
    -- ⚡ High-Value Processing & Orchestration:** Tools like **Apache Airflow ($150,000)**, **Apache Kafka ($145,000)**, and **Apache Spark ($140,000)** command some of the highest salaries on the market, proving that data pipeline architecture and real-time streaming are high-leverage skills.
    -- 🐳 DevOps & Containerization Pay Off:** Specialized infrastructure skills like **Kubernetes ($150,500)** and **Docker ($135,000)** break into the top tier, showing that data engineers who understand containerized deployments are heavily rewarded.



┌────────────┬───────────────┬───────────────┬───────────────┐
│   skills   │ median_salary │ ln_demand_job │ optimal_score │
│  varchar   │    double     │    double     │    double     │
├────────────┼───────────────┼───────────────┼───────────────┤
│ terraform  │      184000.0 │           5.3 │          0.97 │
│ python     │      135000.0 │           7.0 │          0.95 │
│ aws        │      137320.0 │           6.7 │          0.91 │
│ sql        │      130000.0 │           7.0 │          0.91 │
│ airflow    │      150000.0 │           6.0 │          0.89 │
│ spark      │      140000.0 │           6.2 │          0.87 │
│ kafka      │      145000.0 │           5.7 │          0.82 │
│ snowflake  │      135500.0 │           6.1 │          0.82 │
│ azure      │      128000.0 │           6.2 │          0.79 │
│ java       │      135000.0 │           5.7 │          0.77 │
│ scala      │      137290.0 │           5.5 │          0.76 │
│ git        │      140000.0 │           5.3 │          0.75 │
│ kubernetes │      150500.0 │           5.0 │          0.75 │
│ databricks │      132750.0 │           5.6 │          0.74 │
│ redshift   │      130000.0 │           5.6 │          0.73 │
│ gcp        │      136000.0 │           5.3 │          0.72 │
│ nosql      │      134415.0 │           5.3 │          0.71 │
│ hadoop     │      135000.0 │           5.3 │          0.71 │
│ pyspark    │      140000.0 │           5.0 │           0.7 │
│ docker     │      135000.0 │           5.0 │          0.67 │
│ mongodb    │      135750.0 │           4.9 │          0.67 │
│ go         │      140000.0 │           4.7 │          0.66 │
│ r          │      134775.0 │           4.9 │          0.66 │
│ github     │      135000.0 │           4.8 │          0.65 │
│ bigquery   │      135000.0 │           4.8 │          0.65 │
└────────────┴───────────────┴───────────────┴───────────────┘
  25 rows                                          4 columns

    Key Takeaway for Job Seekers
If you are looking to maximize your ROI on upskilling, mastering Python and SQL gets your foot in the door with massive market volume, while layering on Terraform, Airflow, and Cloud (AWS/Snowflake) pushes you into the highest salary brackets.

*/