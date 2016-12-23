DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  author INTEGER NOT NULL,

  FOREIGN KEY (author) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,


  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY(user_id) REFERENCES user(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Kobe', 'Bryant'),
  ('Chef', 'Curry');

INSERT INTO
  questions (title, body, author)
VALUES
  ('Why haven''t you got out of the first round without a all-star big?', 'Put me in the eastern conference', (SELECT id FROM users where fname = 'Kobe')),
  ('Why did you choke a 3-1 lead?', 'Hamstring issues', (SELECT id FROM users WHERE fname = 'Chef'));


INSERT INTO
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions LIMIT 1 ), (SELECT id FROM users LIMIT 1)),
  ((SELECT id FROM questions LIMIT 1 OFFSET 1), (SELECT id FROM users LIMIT 1 OFFSET 1));

INSERT INTO
  replies (question_id, parent_reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions LIMIT 1), NULL, (SELECT id FROM users LIMIT 1), "bodied"),
  ((SELECT id FROM questions LIMIT 1 OFFSET 1), NULL, (SELECT id FROM users LIMIT 1 OFFSET 1), "bodyer");

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  ((SELECT id FROM questions LIMIT 1), (SELECT id FROM users LIMIT 1)),
  ((SELECT id FROM questions LIMIT 1 OFFSET 1), (SELECT id FROM users LIMIT 1 OFFSET 1));

    --
    -- question_id INTEGER NOT NULL,
    -- parent_reply_id INTEGER,
    -- user_id INTEGER NOT NULL,
    -- body TEXT NOT NULL,    --
