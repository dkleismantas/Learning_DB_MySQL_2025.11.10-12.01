USE sakila;

-- Task 1: List all film titles from the film table.

select * from film;

-- Task 2: Count the total number of films available in the database.

select count(*) from film;

-- Task 3: Retrieve a distinct list of languages used in films by joining the film and language tables.

select distinct name from language join film using (language_id);

-- Task 4: Select films with a rental rate greater than 4.0.

select * from film where rental_rate > 4;

-- Task 5: Display film titles along with their replacement cost and sort the results by replacement cost in descending order.

select title, replacement_cost from film order by replacement_cost desc;

-- Task 6: List all active customers from the customer table (active = 1).

select * from customer where active = 1;

-- Task 7: Show staff names along with their store addresses by joining the staff and address tables.

select first_name, address from staff join store s using (store_id) join address a on a.address_id = s.address_id;

-- Task 8: Retrieve films released between the years 2005 and 2008.

select * from film where release_year between 2005 and 2008;

-- Task 9: Calculate the average rental duration for all films.

select avg(rental_duration) as 'Average rental duration' from film;

-- Task 10: Find the minimum and maximum rental rates among all films.

select min(rental_rate) from film;
select max(rental_rate) from film;

-- Task 11: Count the number of films per rating. Group results by the film rating.

select rating, count(*) from film group by rating;

-- Task 12: For each film category, list the category name and the total number of films assigned to that category.

select name, count(film_id) from category join film_category using (category_id) group by name;

-- Task 13: Display the total film length (SUM of length) for each film category.

select name, sum(length) from category join film_category using (category_id) join film using (film_id) group by name;

-- Task 14: List the titles of films that belong to the 'Action' category.

select title from film join film_category using (film_id) join category using (category_id) where name = 'Action';

-- Task 15: Show film titles along with the average payment amount for rentals of that film.

select title, avg(amount) as 'Average rental payment per film' from film join inventory using(film_id) join rental using(inventory_id) join payment using(rental_id) group by title;

-- Task 16: List the top 5 most rented films, ordering results by the number of rentals.

select title from film join inventory using(film_id) join rental using(inventory_id) group by title order by count(rental_id) desc limit 5;

-- Task 17: Retrieve all customers whose email addresses do not contain '@sakilacustomer.org'.

select * from customer where email not like '%@sakilacustomer.org%';

-- Task 18: Identify rental transactions that have not been returned yet (e.g., where return_date IS NULL).

select * from rental where rental_date is null;

-- Task 19: List staff members who have processed more than 50 rentals. 

select s.* from staff s join rental r using(staff_id) group by r.staff_id having count(rental_id) > 50;

-- Task 20: Calculate the average total payment for each customer by joining the payment and customer tables.

select concat(first_name, ' ', last_name) as Customer, avg(amount) as 'Average payments amount' from customer join payment using(customer_id) group by customer_id;

-- Task 21: Find customers whose total payment amounts fall between 100 and 500.

select concat(first_name, ' ', last_name) as Customer from customer join payment using(customer_id) group by customer_id having sum(amount) between 100 and 500;

-- Task 22: List film titles that have never been rented. Use a subquery to check films not present in the rental table.

select title from film left join inventory using(film_id) left join rental using(inventory_id) where rental_id is null;

-- Task 23: Select the film titles of the top 10 cheapest films based on replacement cost.

select title from film order by replacement_cost limit 10;

-- Task 24: List film titles with a length longer than the overall average film length (use a subquery to compute the average).

select title from film where length > (select avg(length) from film);

-- Task 25: Count the number of rentals for each film, grouping the results by film ID.

select title as Film, count(rental_id) as 'Times rented' from film join inventory using(film_id) join rental using(inventory_id) group by film_id;

-- Task 26: Display each customer along with the total number of films they have rented, sorted by the rental count in descending order.

select concat(first_name, ' ', last_name) as Customer, count(rental_id) as 'Total films rented' from customer left join rental using(customer_id) group by customer_id order by count(rental_id) desc;

-- Task 27: Identify the customer who has made the highest total payment.

select concat(first_name, ' ', last_name) as Customer from customer join payment using(customer_id) group by customer_id order by sum(amount) desc limit 1;

select concat(first_name, ' ', last_name) as Customer from customer join payment using(customer_id) group by customer_id having sum(amount) = (select max(am) from (select sum(amount) as am from payment group by customer_id) as sub);

-- Task 28: Create a union query that selects active customers in one query and inactive customers in another; include a label for status.

select concat(first_name, ' ', last_name) as Customer, 'Active' as Status from customer where active = 1
union
select concat(first_name, ' ', last_name) as Customer, 'Inactive' from customer where active = 0;

-- Task 29: Insert a new customer record into the customer table with realistic dummy data.

insert into customer (store_id, first_name, last_name, email, address_id, active, create_date) values (1, 'Dai', 'Kle', 'netavo@reikalas.com', 8, 1, '2025-11-30');

-- Task 30: Delete a customer record based on a given customer_id if that customer is inactive.

delete from customer where customer_id = 602 and active = 0;

-- Task 31: List films with an inventory count less than 5, by joining the film and inventory tables.

select title from film f join inventory using(film_id) group by film_id having count(inventory_id) < 5;

-- Task 32: Identify the store that currently has the highest number of films available by analyzing the inventory.

select s.* from store s join inventory using(store_id) group by store_id having count(inventory_id) = (select max(ii) from (select count(inventory_id) as ii from inventory group by store_id) as sub);

-- Task 33: Calculate the average film length for each language. Group by the language name.

select name, avg(length) from language join film using(language_id) group by name;

-- Task 34: Count the number of films for each film rating (such as 'G', 'PG', etc.) and use the HAVING clause to filter ratings with at least 10 films.

select rating, count(*) from film group by rating having count(*) >= 10;

-- Task 35: For each country, count the number of customers by joining customer, address, city, and country tables.

select country, count(customer_id) from country left join city using(country_id) left join address using(city_id) left join customer using (address_id) group by country;

-- Task 36: Find the names of actors who have starred in more than 10 films.

select concat(first_name, ' ',last_name) as Actor from actor join film_actor using(actor_id) group by actor_id having count(film_id) > 10;

-- Task 37: Display the top 3 customers by total payment amount, including their full name and total paid.

select concat(first_name, ' ', last_name) as Customer, sum(amount) as 'Total payed' from customer join payment using(customer_id) group by customer_id order by sum(amount) desc limit 3;

-- Task 38: Find any duplicate film titles (if they exist) by grouping by title and having a count greater than 1.

select title from film group by title having count(film_id) > 1;

-- Task 39: Select film titles where the replacement cost is higher than the average replacement cost for all films (using a subquery).

select title from film where replacement_cost > (select avg(replacement_cost) from film);

-- Task 40: Insert a new film record into the film table with example values for title, description, and rental_rate.

insert into film (title, language_id, rental_duration, rental_rate, replacement_cost) values ('None of your business', 5, 8, 3, 18.88);

-- Task 41: Find the full name of the actor who has acted in the maximum number of movies. 

select concat(first_name, ' ',last_name) as Actor, count(film_id) from actor join film_actor using(actor_id) group by actor_id
having count(film_id) = (select max(fi) from (select count(film_id) as fi from film_actor group by actor_id) as sub);

select concat(first_name, ' ',last_name) as Actor, count(film_id) from actor join film_actor using(actor_id) group by actor_id order by count(film_id) desc limit 1;

-- Task 42: Find out how many times a particular movie category is rented. Arrange these categories in the decreasing order of the number of times they are rented

select name as Category, count(rental_id) as 'Rents per category' from category join film_category using(category_id) join film using(film_id) join inventory using(film_id) join rental using(inventory_id) group by name order by count(rental_id) desc;

-- Task 43: Write a query to find the full names of those customers who have rented at least 25 movies and belong to the city London.

select concat(first_name, ' ', last_name) as Customer from customer join rental using(customer_id) join address using(address_id) join city using(city_id) where city = 'London' group by customer_id having count(rental_id) >= 25;