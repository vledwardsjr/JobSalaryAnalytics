with remote_roles as (
    SELECT
        job_id,
        job_work_from_home,
        job_title_short
    FROM
        job_postings_fact
    WHERE
        job_work_from_home = TRUE AND
        job_title_short in ('Data Scientist','Data Analyst')
    order BY
        job_title_short
)
SELECT
    skills_dim.skills as skills,
    count(skills_job_dim.skill_id) as skill_count
from
    remote_roles
left JOIN
    skills_job_dim on remote_roles.job_id = skills_job_dim.job_id
left JOIN
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    skills is not null
group BY
    skills_dim.skill_id
order BY
    skill_count desc
limit 10;
