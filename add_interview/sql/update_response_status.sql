UPDATE response 
SET status = 'собеседование назначено' 
WHERE opening_id = %s AND user_login = (SELECT user_login FROM candidates WHERE candidate_id = %s);
