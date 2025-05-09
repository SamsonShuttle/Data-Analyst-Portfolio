/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying data analyst roles that are availble remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for data analysts, offering insights into finding what employers are looking for.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

/*
Analysis Summary:
1.Skills by Job Title:
- Skills are well-clustered for each job title, with senior roles (e.g., "Associate Director- Data Insights") demanding more diversified skills like SQL, Python, R, Azure, Databricks, AWS, and Pandas.
- Junior or niche roles (e.g., "Data Analyst, Marketing") tend to have more specialized stacks.

2.Top Paying Job Titles:
- Associate Director- Data Insights: $255,829.5 average salary
- Data Analyst, Marketing: $232,423.0 average salary
- Data Analyst (Hybrid/Remote): $217,000.0 average salary
- Principal Data Analyst (Remote): $205,000.0 average salary

3.Top Skills and Their Impact on Salary:
- AWS and Azure are highly paid skills ($222,569.25 on average), reflecting the demand for cloud expertise.
- Skills like Atlassian and Bitbucket appear frequently, but are tied to slightly lower-paying roles.
*/