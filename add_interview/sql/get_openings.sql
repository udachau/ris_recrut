SELECT DISTINCT o.opening_id, p.job_name 
FROM openings o
JOIN positions p ON o.position_id = p.position_id
WHERE o.close_date IS NULL;
