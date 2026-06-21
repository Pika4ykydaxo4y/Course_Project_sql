-- 1. Top games by revenue in OLTP
SELECT g.title, COUNT(*) AS purchases, SUM(p.paid_amount) AS revenue FROM steam_oltp.purchases p JOIN steam_oltp.games g ON g.game_id=p.game_id GROUP BY g.title ORDER BY revenue DESC;
-- 2. Average review rating per game
SELECT g.title, ROUND(AVG(r.rating),2) AS avg_rating, COUNT(r.review_id) AS review_count FROM steam_oltp.games g LEFT JOIN steam_oltp.reviews r ON r.game_id=g.game_id GROUP BY g.title ORDER BY avg_rating DESC NULLS LAST;
-- 3. Purchases by country and month
SELECT c.country_name, DATE_TRUNC('month', p.purchase_date)::date AS month, COUNT(*) AS purchases, SUM(p.paid_amount) AS revenue FROM steam_oltp.purchases p JOIN steam_oltp.users u ON u.user_id=p.user_id JOIN steam_oltp.countries c ON c.country_id=u.country_id GROUP BY c.country_name, month ORDER BY month, revenue DESC;
