-- 1. Revenue by genre using bridge weights
SELECT dg.genre_name, ROUND(SUM(fs.net_revenue * b.weight),2) AS allocated_revenue FROM steam_dwh.fact_sales fs JOIN steam_dwh.bridge_game_genre b ON b.game_key=fs.game_key JOIN steam_dwh.dim_genre dg ON dg.genre_key=b.genre_key GROUP BY dg.genre_name ORDER BY allocated_revenue DESC;
-- 2. Monthly revenue from DWH
SELECT dd.year, dd.month, ROUND(SUM(fs.net_revenue),2) AS revenue, SUM(fs.units_sold) AS units FROM steam_dwh.fact_sales fs JOIN steam_dwh.dim_date dd ON dd.date_key=fs.date_key GROUP BY dd.year, dd.month ORDER BY dd.year, dd.month;
-- 3. Current price and sales performance by game
SELECT g.title, gp.price AS current_price, SUM(fs.units_sold) AS units_sold, ROUND(SUM(fs.net_revenue),2) AS revenue FROM steam_dwh.fact_sales fs JOIN steam_dwh.dim_game g ON g.game_key=fs.game_key LEFT JOIN steam_dwh.dim_game_price_scd gp ON gp.game_key=g.game_key AND gp.is_current=true GROUP BY g.title, gp.price ORDER BY revenue DESC;
