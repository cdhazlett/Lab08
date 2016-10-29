--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
-- Lab08, CS262
--
-- @author kvlinden
-- @author cdh24
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY,
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID),
	playerID integer REFERENCES Player(ID),
	score integer
	);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);



-- EXERCISE 8.1
-- -- a
-- Select * From Game Order By time Desc
-- -- b
-- Select * From Game Where time > current_date-(INTERVAL '7 days') Order By time Desc
-- -- c
-- Select * From Player Where name Not Like ''
-- -- d
-- Select Player.ID, Player.emailAddress, player.name, PlayerGame.score From Player, PlayerGame Where Player.ID = PlayerGame.playerID AND PlayerGame.score > 2000
-- --e
-- Select * From Player Where emailAddress Like '%gmail%'


-- -- EXERCISE 8.2
-- -- 1
-- Select score From PlayerGame, Player Where Player.ID = PlayerGame.playerID AND Player.name = 'The King' Order By score Desc
-- -- 2
-- Select Player.name, score from Player, PlayerGame, Game Where Player.ID = PlayerGame.playerID AND PlayerGame.gameID = Game.ID AND Game.time = '2006-06-28 13:20:00' Order By score Desc Limit 1
-- -- 3
-- -- It keeps the duplicates from being returned.  Otherwise any match would be returned twice, once with the P1 and P2 IDs in the correct order, and once reversed.  The ID > ID clause keeps the second case from happening, thus preventing duplicates.
-- -- 4
-- -- Sure, you may want to match multiple ID numbers for various things stored in the same row with other ID numbers stored in that row.  It would be a weird design, but I can see somebody doing it, for example if there were two ID systems to have to support.
