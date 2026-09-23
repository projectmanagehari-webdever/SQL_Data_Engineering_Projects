SELECT 
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
From job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;


SELECT
    *
FROM 
    skills_job_dim
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;


SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON sjd.job_id = jpf.job_id
LEFT JOIN skills_dim AS sd
     ON sd.skill_id = sjd.skill_id;

-- 1.12 Order of execution

/*
    Find companies with more than 3000 job postings.
    Only in US location
*/

SELECT
    cd.name as company_name,
    COUNT(jpf.job_id) as posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON cd.company_id = jpf.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC;


