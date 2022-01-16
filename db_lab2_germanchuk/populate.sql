-- At first define Genres, Developers and Publishers

INSERT INTO Developers
    (dev_id, title)
    VALUES
    (000, 'Nintendo'),
    (001, 'Rockstar Games'),
    (002, 'Electronic Arts'),
    (003, 'BioWare'),
    (004, 'Ubisoft');

INSERT INTO Publishers
    (publisher_id, title)
    VALUES
    (000, 'Ubisoft'),
    (001, 'Gameloft'),
    (002, 'Wargaming'),
    (003, 'Rockstar Games'),
    (004, 'Nintendo');

INSERT INTO Genres
    (genre_id, title)
    VALUES
    (000, 'RPG'),
    (001, 'Survival'),
    (002, 'First-person shooter'),
    (003, 'Life Simulator'),
    (004, 'Platformer'),
    (005, 'Third-person shooter'),
    (006, 'Action-adventure');

-- Now we can add some games

INSERT INTO Games
    (game_id, dev_id, publisher_id, title, release_date)
    VALUES
    (000, 0, 4, 'Super Mario Bros.', '1985-09-13'),
    (001, 0, 4, 'The Legend of Zelda', '1986-02-21'),
    (002, 1, 3, 'Grand Theft Auto', '1998-02-28'),
    (003, 1, 3, 'Grand Theft Auto: Vice City', '2002-05-21'),
    (004, 1, 3, 'Max Payne', '2001-07-23'),
    (005, 2, NULL, 'Battlefield 1942', '2002-09-10'),
    (006, 4, NULL, 'Mass Effect', '2007-11-20');

-- And their genres

INSERT INTO GameGenre
    (game_id, genre_id)
    VALUES
    (0, 4), -- Platformer
    (1, 6), -- Action adventure
    (2, 6), -- Action adventure
    (3, 5), -- TPS
    (3, 6), -- Action adventure
    (4, 5), -- TPS
    (5, 2), -- FPS
    (6, 5), -- TPS
    (6, 0); -- RPG

-- Also add information about sales

INSERT INTO SaleInfo
    (game_id, sales)
    VALUES  -- Fake values
    (0, 12.2),
    (1, 5.8),
    (2, 3.7),
    (3, 4.5),
    (4, 7.1),
    (5, 5.4),
    (6, 9.2);
