-- повертає інформацію про ігри розробника та його сумарний прибуток
CREATE OR REPLACE PROCEDURE dev_games_stats() AS
$$
    DECLARE
        record record;
    BEGIN
        FOR record IN
            SELECT d.title AS "dev",
				   COUNT(g.dev_id) AS "count",
				   COALESCE(ROUND(SUM(s.sales)::numeric, 1), 0) AS "total_profit"
			FROM games AS g
				RIGHT JOIN developers AS d ON g.dev_id = d.dev_id
				LEFT JOIN saleinfo AS s ON g.game_id = s.game_id
			GROUP BY d.title
        LOOP
            RAISE INFO 'Developer "%" has % games (total profit: % million dollars)',
				record.dev, record.count, record.total_profit;
        END LOOP;
    END;
$$ LANGUAGE 'plpgsql';