select
    company_dim.name as company_name,
    job_title,
    job_schedule_type,
    job_work_from_home,
    job_location,
    salary_year_avg as yearly_salary,
    job_posted_date::date as date_posted
from
    job_postings_fact
LEFT JOIN
    company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short in ('Data Scientist','Data Analyst') and
    (job_location like '%VA%' or
        job_location like '%DC%' or
        job_location like '%MD%' or
        job_location like '%Anywhere%') and
    salary_year_avg is not null AND
    job_location is not null
order BY
    job_work_from_home
limit 1000;
