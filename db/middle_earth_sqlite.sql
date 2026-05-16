PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

CREATE TABLE characters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  charname VARCHAR(256)
);

INSERT INTO characters VALUES (1,'Sam');
INSERT INTO characters VALUES (2,'Pippin');
INSERT INTO characters VALUES (3,'Frodo');
INSERT INTO characters VALUES (4,'Merry');

CREATE TABLE users (
  user_id INTEGER PRIMARY KEY
);

CREATE TABLE char_user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  char_id INTEGER,
  user_id INTEGER,
  assigned_port INTEGER
);

CREATE TABLE stages (
  user_id INTEGER,
  stage_completed INTEGER
);

COMMIT;