---------------------------
-- Delete last tables if exists
---------------------------

DROP TABLE IF EXISTS Games Cascade;
DROP TABLE IF EXISTS Developers Cascade;
DROP TABLE IF EXISTS Publishers Cascade;
DROP TABLE IF EXISTS Genres Cascade;
DROP TABLE IF EXISTS GameGenre Cascade;
DROP TABLE IF EXISTS SaleInfo Cascade;

---------------------------
-- Create main tables (PK, FK)
---------------------------

CREATE TABLE Games
(
    game_id             int         NOT NULL UNIQUE ,
    dev_id              int         NOT NULL ,
    publisher_id        int         NULL ,  -- can be without publisher
    title               text        NOT NULL ,
    release_date        date        NULL    -- undefined coz game may be in development
);

CREATE TABLE Developers
(
    dev_id  int         NOT NULL UNIQUE ,
    title   text        NOT NULL
);

CREATE TABLE Publishers
(
    publisher_id  int         NOT NULL UNIQUE ,
    title         text        NOT NULL
);

---------------------------
-- Another tables (for JOIN)
---------------------------

CREATE TABLE SaleInfo
(
    game_id    int         NOT NULL UNIQUE ,
    sales      float       NULL
);

CREATE TABLE Genres
(
    genre_id   int         NOT NULL UNIQUE ,
    title      text        NOT NULL
);

CREATE TABLE GameGenre
(
    game_id     int         NOT NULL ,
    genre_id    int         NOT NULL
);

---------------------------
-- Define primary keys
---------------------------

ALTER TABLE Games ADD CONSTRAINT PK_Games
    PRIMARY KEY (game_id);
ALTER TABLE Developers ADD CONSTRAINT PK_Developers
    PRIMARY KEY (dev_id);
ALTER TABLE Publishers ADD CONSTRAINT PK_Publishers
    PRIMARY KEY (publisher_id);
ALTER TABLE Genres ADD CONSTRAINT PK_Genres
    PRIMARY KEY (genre_id);
ALTER TABLE SaleInfo ADD CONSTRAINT PK_SaleInfo
    PRIMARY KEY (game_id);
ALTER TABLE GameGenre ADD CONSTRAINT PK_GameGenre
    PRIMARY KEY (game_id, genre_id);

---------------------------
-- Define foreign keys
---------------------------

ALTER TABLE Games ADD CONSTRAINT FK_Game_Developer
    FOREIGN KEY (dev_id) REFERENCES Developers (dev_id);
ALTER TABLE Games ADD CONSTRAINT FK_Game_Publisher
    FOREIGN KEY (publisher_id) REFERENCES Publishers (publisher_id);
ALTER TABLE GameGenre ADD CONSTRAINT FK_GameGenre_Game
    FOREIGN KEY (game_id) REFERENCES Games (game_id);
ALTER TABLE GameGenre ADD CONSTRAINT FK_GameGenre_Genres
    FOREIGN KEY (genre_id) REFERENCES Genres (genre_id);
