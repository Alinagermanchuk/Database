-- з≥брати все в одну таблицю
SELECT
	g.title AS "title",
	g.release_date AS "release_date",
	d.title AS "developer",
	p.title AS "publisher",
	s.sales AS "sales",
	gg.genre AS "genre"
FROM games AS g
	LEFT JOIN developers AS d ON d.dev_id = g.dev_id
	LEFT JOIN publishers AS p ON p.publisher_id = g.publisher_id
	LEFT JOIN saleinfo AS s ON s.game_id = g.game_id
	LEFT JOIN
		(SELECT	g.game_id, STRING_AGG(gen.title::varchar, ', ') AS "genre"
			FROM GameGenre AS gg
				LEFT JOIN Games AS g ON gg.game_id = g.game_id
				LEFT JOIN Genres AS gen ON gg.genre_id = gen.genre_id
			GROUP BY g.game_id) AS gg ON g.game_id = gg.game_id;



-- гра - продаж≥
SELECT g.title AS "title", s.sales AS "sales"
	FROM games AS g
		LEFT JOIN saleinfo AS s ON s.game_id = g.game_id
	ORDER BY sales DESC;

-- найпопул€рн≥ш≥ жанри
SELECT gen.title AS "genre",
		COUNT(gg.genre_id) as "count"
	FROM Genres AS gen
		LEFT JOIN GameGenre AS gg ON gg.genre_id = gen.genre_id
	GROUP BY gen.genre_id
	ORDER BY count DESC;

-- сумарний прибуток по кожному девелоперу
SELECT d.title AS "developer",
		COALESCE(ROUND(SUM(s.sales)::numeric, 2), 0) AS "sales_sum"
	FROM Games AS g
		RIGHT JOIN developers AS d ON d.dev_id = g.dev_id
		LEFT JOIN saleinfo AS s ON s.game_id = g.game_id
	GROUP BY d.dev_id
	ORDER BY sales_sum DESC