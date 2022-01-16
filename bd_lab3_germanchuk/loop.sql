-- insert test values (use negative values to indicate test values)
DO $$
	BEGIN
		INSERT INTO developers (dev_id, title) VALUES (-1, 'Test Developer');
		INSERT INTO publishers (publisher_id, title) VALUES (-1, 'Test Publisher');
		INSERT INTO genres (genre_id, title) VALUES (-1, 'Test game genre');
		FOR i IN 1..10
			LOOP
				INSERT INTO games
					(game_id, dev_id, publisher_id, title, release_date)
					VALUES (-i, -1, -1, 'Test Game ' || i, NOW()::date);
				INSERT INTO GameGenre (game_id, genre_id)
					VALUES (-i, -1);
				INSERT INTO SaleInfo (game_id, sales)
					VALUES (-i, ROUND((RANDOM()*10)::numeric, 1));
			END LOOP;
	END;
$$ LANGUAGE 'plpgsql';



-- select all values ordering by sales
SELECT * FROM all_values ORDER BY sales DESC;


-- delete test values
DELETE FROM GameGenre WHERE game_id < 0;
DELETE FROM Genres WHERE genre_id < 0;
DELETE FROM Games WHERE game_id < 0;
DELETE FROM Developers WHERE dev_id < 0;
DELETE FROM Publishers WHERE publisher_id < 0;
DELETE FROM SaleInfo WHERE game_id < 0;