SELECT `group_login`, `group_pass`, `idcheck_users`
FROM rec.check_users
WHERE user_login='{user_login}' AND user_pass='{user_pass}';
