-- Display the first and last names of all actors from the table actor. 

SELECT first_name, last_name FROM actor;

-- Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.

SELECT title, description, rating, length FROM film
WHERE length > 180;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
-- What is one query would you use to obtain this information?
 
SELECT actor_id, first_name,last_name FROM actor
WHERE first_name = 'Joe';
 
-- Find all actors whose last name contain the letters GEN:
 
SELECT actor_id, first_name,last_name FROM actor
WHERE last_name LIKE '%GEN%';
 
-- Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
 
SELECT * FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;
 
-- Select all columns from the customer table for rows that have a last name beginning with "S" and a first name ending with "N".
 
SELECT * FROM customer
WHERE last_name LIKE 'S%' AND first_name LIKE '%N';
 
-- Select all columns minus the password column from the staff table for rows that contain a password.
 
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
FROM staff
WHERE password IS NOT NULL;
 
-- Select all columns minus the password column from the staff table for rows that do not contain a password.
 
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
FROM staff
WHERE password IS NULL;
 
-- Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
 
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
 
-- Select all columns from the film table for films rated G, PG-13 or NC-17.

SELECT * FROM film
WHERE rating IN ('G', 'PG-13', 'NC-17');

-- Select the payment id, amount, and payment date columns from the payment table
-- for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function,)

SELECT payment_id, amount, DATE(payment_date) FROM payment
WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

-- Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005. (Use BETWEEN operator)

SELECT * FROM payment
WHERE payment_date between '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';

-- Select all distinct ratings from the film table ordered by rating in descending order.

SELECT distinct rating FROM film
order by rating desc;

-- List the last names of actors, as well as how many actors have that last name.

select last_name, count(*) from actor
group by last_name;

-- How many distinct actors last names are there?

SELECT count(distinct last_name) from actor;

-- Which actors last names are not repeated?

SELECT last_name from actor
group by last_name
having count(last_name) = 1;

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, count(*) from actor
group by last_name
having count(last_name) >=2;

-- What is that average length of all the films in the sakila DB?

SELECT avg(length) from film;

-- The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.

UPDATE actor
SET first_name = 'HARPO', last_name = 'WILLIAMS'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity.
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT title from film
where (title LIKE 'k%' or title like 'q%') and language_id IN (SELECT language_id FROM language WHERE name = 'English');

-- Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name from actor
WHERE actor_id IN (SELECT actor_id from film_actor
WHERE film_id in (select film_id from film where title = 'Alone Trip'));
