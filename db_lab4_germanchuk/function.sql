-- повертає найуспішнішу гру за вказанним жанром
CREATE OR REPLACE FUNCTION get_most_selling_game_by_genre(genre_name text)
    RETURNS text AS
    $$
        DECLARE
            game text;
        BEGIN
            SELECT g.title INTO game
			FROM gamegenre AS gg
				LEFT JOIN genres AS gen ON gg.genre_id = gen.genre_id
				LEFT JOIN games AS g ON gg.game_id = g.game_id
				LEFT JOIN saleinfo AS s ON gg.game_id = s.game_id
			WHERE LOWER(gen.title) LIKE genre_name;
			RETURN game;
        END;
    $$ LANGUAGE 'plpgsql';