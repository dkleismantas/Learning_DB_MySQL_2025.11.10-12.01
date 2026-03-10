USE sakila;

-- Task 1: List all film titles from the film table.

select title from film;

-- Task 2: Count the total number of films available in the database.

select count(*) from film;

-- Task 3: Retrieve a distinct list of languages used in films by joining the film and language tables.

select distinct name from language l join film f on l.language_id = f.language_id;

-- Task 4: Select films with a rental rate greater than 4.0.

select * from film
where rental_rate > 4;

-- Task 5: Display film titles along with their replacement cost and sort the results by replacement cost in descending order.

select title, replacement_cost from film
order by replacement_cost desc;

-- Task 6: List all active customers from the customer table (active = 1).

select * from customer where active = 1;

-- Task 7: Show staff names along with their store addresses by joining the staff and address tables.

select first_name, address from staff s join address a on s.address_id = a.address_id;

-- Task 8: Retrieve films released between the years 2005 and 2008.

select * from film where release_year between 2005 and 2008;

-- Task 9: Calculate the average rental duration for all films.

select avg(rental_duration) from film;

-- Task 10: Find the minimum and maximum rental rates among all films.

select min(rental_rate) from film;
select max(rental_rate) from film;

-- Task 11: Count the number of films per rating. Group results by the film rating.

select rating, count(film_id) from film group by rating;

-- Task 12: For each film category, list the category name and the total number of films assigned to that category.

select name, count(f.film_id) from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
group by name;

-- Task 13: Display the total film length (SUM of length) for each film category.

select name, sum(length) from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
group by name;

-- Task 14: List the titles of films that belong to the 'Action' category.

select title from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
where name = 'action';

-- Task 15: Show film titles along with the average payment amount for rentals of that film.

select title, avg(amount) from film f join inventory i on f.film_id = i.film_id join rental r on i.inventory_id = r.inventory_id join payment p on r.rental_id = p.rental_id group by title;

-- Task 16: List the top 5 most rented films, ordering results by the number of rentals.

select title, count(r.inventory_id) from film f join inventory i on f.film_id = i.film_id join rental r on i.inventory_id = r.inventory_id group by title order by count(r.inventory_id) desc limit 5;

-- Task 17: Retrieve all customers whose email addresses do not contain '@sakilacustomer.org'.

select * from customer where not email like '%@sakilacustomer.org%';

-- Task 18: Identify rental transactions that have not been returned yet (e.g., where return_date IS NULL).

select * from rental where return_date is null;

-- Task 19: List staff members who have processed more than 50 rentals. 

select first_name, last_name from staff s join rental r on s.staff_id = r.staff_id group by first_name, last_name having count(rental_id) > 50;

-- Task 20: Calculate the average total payment for each customer by joining the payment and customer tables.

select first_name, last_name, avg(amount) from customer c join payment p on c.customer_id = p.customer_id group by first_name, last_name;

-- Task 21: Find customers whose total payment amounts fall between 100 and 500.

select first_name, last_name from customer c join payment p on c.customer_id = p.customer_id group by first_name, last_name having sum(amount) between 100 and 500;

-- Task 22: List film titles that have never been rented. Use a subquery to check films not present in the rental table.

select title from film f left join inventory i on f.film_id = i.film_id left join rental r on i.inventory_id = r.inventory_id where r.inventory_id is null;
select title from film where film_id in (select film_id from inventory where not inventory_id in (select inventory_id from rental));

-- Task 23: Select the film titles of the top 10 cheapest films based on replacement cost.

select title from film order by replacement_cost limit 10;

-- Task 24: List film titles with a length longer than the overall average film length (use a subquery to compute the average).

select title, length from film where length > (select avg(length) from film);

-- Task 25: Count the number of rentals for each film, grouping the results by film ID.

select title, count(rental_id) from film f join inventory i on f.film_id = i.film_id join rental r on i.inventory_id = r.inventory_id group by f.film_id;

-- Task 26: Display each customer along with the total number of films they have rented, sorted by the rental count in descending order.

select concat(first_name, ' ', last_name) as 'Customer', count(rental_id) as 'Rented films' from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id
order by count(rental_id) desc;

-- Task 27: Identify the customer who has made the highest total payment.

select concat(first_name, ' ', last_name) as 'Customer', sum(amount) from customer c join payment p on c.customer_id = p.customer_id group by c.customer_id
order by sum(amount) desc limit 1;

-- Task 28: Create a union query that selects active customers in one query and inactive customers in another; include a label for status.

select * from customer where active = 1 union select * from customer where active = 0;

-- Task 29: Insert a new customer record into the customer table with realistic dummy data.

insert into customer (store_id, first_name, last_name, email, address_id, active, create_date)
values ('2', 'Dai', 'Kle', 'dai.kle@dk.lt', '100', '1', now());

-- Task 30: Delete a customer record based on a given customer_id if that customer is inactive.

delete from customer where customer_id = 5 and active = 0;

-- Task 31: List films with an inventory count less than 5, by joining the film and inventory tables.

select title, count(inventory_id) from film f join inventory i on f.film_id = i.film_id group by f.film_id having count(inventory_id) < 5;

-- Task 32: Identify the store that currently has the highest number of films available by analyzing the inventory.

select store_id from inventory group by store_id order by count(inventory_id) desc limit 1;

-- Task 33: Calculate the average film length for each language. Group by the language name.

select name, avg(length) from language l join film f on l.language_id = f.language_id group by f.language_id;

-- Task 34: Count the number of films for each film rating (such as 'G', 'PG', etc.) and use the HAVING clause to filter ratings with at least 10 films.

select rating from film group by rating having count(film_id) > 10;

-- Task 35: For each country, count the number of customers by joining customer, address, city, and country tables.

select country, count(customer_id) as Customers from country co join city ci on co.country_id = ci.country_id
join address a on ci.city_id = a.city_id join customer cu on a.address_id = cu.address_id group by co.country_id;

-- Task 36: Find the names of actors who have starred in more than 10 films.

select first_name from actor a join film_actor fa on a.actor_id = fa.actor_id group by fa.actor_id having count(film_id) > 10;

-- Task 37: Display the top 3 customers by total payment amount, including their full name and total paid.

select concat(first_name, ' ', last_name) as Customer, sum(amount) as 'Total paid' from customer c join payment p on c.customer_id = p.customer_id
group by p.customer_id order by sum(amount) desc limit 3;

-- Task 38: Find any duplicate film titles (if they exist) by grouping by title and having a count greater than 1.

select title from film group by title having count(film_id) > 1;

-- Task 39: Select film titles where the replacement cost is higher than the average replacement cost for all films (using a subquery).

Select title from film where replacement_cost > (select avg(replacement_cost) from film);

-- Task 40: Insert a new film record into the film table with example values for title, description, and rental_rate.

insert into film (title, language_id, description, rental_duration, rental_rate, replacement_cost)
values ('H. P.', '1', 'Film about magic', '8', '4.39', '15');

-- Task 41: Find the full name of the actor who has acted in the maximum number of movies. 

select concat(first_name, ' ', last_name) as Actor from actor a join film_actor fa on a.actor_id = fa.actor_id group by fa.actor_id
order by count(fa.film_id) desc limit 1;

-- Padaryta su AI, nes neišnešė smegenys antram variantui
SELECT CONCAT(a.first_name, ' ', a.last_name) AS Actor, COUNT(fa.film_id) AS Films_played FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) = (
SELECT MAX(films_count)
FROM (SELECT COUNT(fa2.film_id) AS films_count FROM film_actor fa2 GROUP BY fa2.actor_id) AS sub);


-- Task 42: Find out how many times a particular movie category is rented. Arrange these categories in the decreasing order of the number of times they are rented

select name, count(r.rental_id) as 'Times rented'from category c join film_category fc on c.category_id = fc.category_id join film f on fc.film_id = f.film_id
join inventory i on f.film_id = i.film_id join rental r on i.inventory_id = r.inventory_id group by c.name order by count(r.rental_id) desc;

-- Task 43: Write a query to find the full names of those customers who have rented at least 25 movies and belong to the city London.

select distinct concat(first_name, ' ', last_name) as Customer from customer c
join rental r on c.customer_id = r.customer_id
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id where city = 'London' group by r.customer_id having count(rental_id) > 25;