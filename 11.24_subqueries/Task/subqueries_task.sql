-- Task 1
-- Customers whose individual payment (row) is above the average payment amount of all payments.
-- Use a scalar subquery in WHERE.

select c.* 
from customer c 
where c.customer_id in (
select distinct p.customer_id
from payment p 
where amount > (
select avg(amount) 
from payment));

select distinct c.* 
from customer c 
join payment p 
using (customer_id) 
where amount > (
select avg(amount) 
from payment);

-- Task 2
-- Films whose length is greater than the average length of films in the same category.
-- Use a correlated subquery.

SELECT f.title
FROM film f
JOIN film_category fc USING (film_id)
WHERE f.length > (
    SELECT AVG(f2.length)
    FROM film f2
    WHERE category_id = fc.category_id
);


-- Task 3
-- Actors who appeared in at least one film that also stars 'Nick Wahlberg'.
-- Use IN with a subquery returning film_ids.

select concat(a.first_name, ' ', a.last_name) from actor a join film_actor fa using (actor_id) where film_id in 
(select film_id from film_actor join actor using (actor_id) where first_name = 'Nick' and last_name ='Wahlberg');

select concat(a.first_name, ' ', a.last_name) from actor a join film_actor fa using (actor_id) where film_id in 
(select film_id from film_actor where actor_id in (
select actor_id from actor where
first_name = 'Nick' and last_name ='Wahlberg'));

-- Task 4
-- Top 5 most rented films by rental count.
-- Use a subquery with GROUP BY + ORDER BY + LIMIT inside IN.

select title from film where film_id in (
select film_id from inventory where inventory_id in (
select inventory_id, count(*) from rental group by inventory_id order by count(*) desc limit 5));

-- Task 5
-- Display all films whose rental rate is higher than the average rental rate.
-- Use a scalar subquery.

select title from film where rental_rate > (
select avg(rental_rate) from film);

-- Task 6
-- List all customers who have rented at least one film.
-- Use a subquery with IN.

select concat(first_name, ' ', last_name) from customer where customer_id in (
select customer_id from rental group by customer_id having count(*) > 1);

-- Task 7
-- Show all films that are not rented by anyone (not found in rental table).
-- Use a subquery with NOT IN.

select title from film where film_id in (
select film_id from inventory where inventory_id not in (
select distinct inventory_id from rental));

-- Task 8
-- Find all customers whose total payment is greater than 100.
-- Use a CTE for per-customer total and filter it.

select concat(first_name, ' ', last_name) from customer where customer_id in (
with total_per_customer as (
select customer_id, sum(amount) as ca from payment group by customer_id)
select customer_id from total_per_customer where ca > 100);

-- Task 9
-- Stores whose inventory count is below the average inventory count across stores.
-- Use a CTE to compute per-store counts; compare to avg via subquery.

with store_count as (
select store_id, count(*) as c from inventory group by store_id)
select store_id from store_count where c < (select avg(c) from store_count);