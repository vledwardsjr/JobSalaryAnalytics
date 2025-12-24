with top_paying_jobs as(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        job_location,
        job_work_from_home
    FROM
        job_postings_fact
    WHERE
        salary_year_avg is not null and
        job_title_short in ('Data Analyst','Data Scientist') and
        job_work_from_home = TRUE AND
        job_location like '%Anywhere%'
    order by
        salary_year_avg desc
    limit 10
)
SELECT
    top_paying_jobs.job_id,
    job_title,
    salary_year_avg,
    job_location,
    job_work_from_home,
    skills_dim.skills
FROM
    top_paying_jobs
LEFT JOIN
    skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
left JOIN
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    skills_dim.skills is not null
order BY
    salary_year_avg desc;
