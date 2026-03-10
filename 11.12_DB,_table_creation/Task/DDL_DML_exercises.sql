-- Create new database called 'blog'

CREATE DATABASE blog;

-- Switch to that database (use)

USE blog;

-- Create table users

CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  email VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert new user with values name = 'John Smith', email = 'john@example.com' 

INSERT INTO users (name, email) 
VALUES ('John Smith', 'john@example.com');

-- Add a column named age to the users table with a data type of INT

ALTER TABLE users
ADD COLUMN age INT;

-- Insert another 2 users 

INSERT INTO users (name, email) 
VALUES
('Tom Jacob', 'tom@example.com'),
('Don Simon', 'don@example.com')
;

-- Update the email of the user with the id of 1 to 'johnsmith@example.com'.

UPDATE users
SET email = 'johnsmith@example.com'
WHERE id = 1;

-- Delete the user with the id of 2.

DELETE FROM users
WHERE id = 2;

-- Change the data type of the email column in the users table from VARCHAR(50) to VARCHAR(255)

ALTER TABLE users
MODIFY COLUMN email VARCHAR(255);

-- Remove the updated_at column from the users table.

ALTER TABLE users
DROP COLUMN updated_at;

-- Create table 'posts' with columns id (int, primary key, auto increment), title (varchar(255)), body (TEXT), user_id (int, foreign key)

CREATE TABLE posts (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255),
body TEXT,
user_id INT,
CONSTRAINT fk_id FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Add a new column to the 'posts' table called created_at with the data type of TIMESTAMP and a default value of the current timestamp.

ALTER TABLE posts
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add a new post with the following values:  title = 'First Post', body = 'This is my first post', user_id = 1.

INSERT INTO posts (title, body, user_id)
VALUES ('First Post', 'This is my first post', 1);

-- Rename the body column in the posts table to content.

ALTER TABLE posts
CHANGE body content TEXT;