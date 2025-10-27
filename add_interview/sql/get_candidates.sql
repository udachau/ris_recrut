SELECT DISTINCT c.candidate_id, c.name, c.age, c.sex, c.address
FROM candidates c
JOIN response r ON c.user_login = r.user_login
WHERE r.status = 'откликнулся'
AND r.opening_id = %s;
