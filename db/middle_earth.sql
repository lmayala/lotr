PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS char_user;
CREATE TABLE char_user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  char_id INTEGER,
  user_id INTEGER,
  assigned_port INTEGER NOT NULL
);

DROP TABLE IF EXISTS characters;
CREATE TABLE characters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  charname TEXT
);

INSERT INTO characters (id, charname) VALUES
  (1, 'Sam'),
  (2, 'Pippin'),
  (3, 'Frodo'),
  (4, 'Merry');

DROP TABLE IF EXISTS stages;
CREATE TABLE stages (
  user_id INTEGER NOT NULL,
  stage_completed INTEGER
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  user_id INTEGER PRIMARY KEY
);

