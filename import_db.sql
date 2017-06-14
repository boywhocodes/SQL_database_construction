
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  user_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id)
);
DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER,
  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES users(id)
  --join on users & questions
);
DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  reply TEXT NULL,
  parent_id INTEGER NOT NULL, --parent_id
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,


  FOREIGN KEY (parent_id) REFERENCES replies(id)
  FOREIGN KEY (question_id) REFERENCES question(id)
  FOREIGN KEY (user_id) REFERENCES users(id)

);
DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (

  user_id  INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES question(id)
  FOREIGN KEY (user_id) REFERENCES users(id)

);

INSERT INTO
  users (fname, lname)
VALUES
 ('Alex', 'Milbert'),
 ('Liseth', 'Cardozo');

 INSERT INTO
   questions (title, body, user_id)
 VALUES
    ('a/A Survival', 'How in the world do I survive this place?', 1),
    ('Survival Tips', 'How do I get out alive (and in one piece) from a/A?', 2);

 INSERT INTO
  question_follows (question_id, user_id)
  VALUES
    (1, 1);

  INSERT INTO
    replies (reply, parent_id, user_id, body, question_id)
  VALUES
      ('Lots and lots of steroids', 1, 1, 'Heavy mind, heavy lifting, heavy coffee', 1);

  INSERT INTO
    question_likes (user_id, question_id)
  VALUES
    (1,1);
