-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT sakila.film.title, COUNT(sakila.inventory.film_id) AS 'Number of copies' FROM sakila.film
JOIN sakila.inventory ON
sakila.film.film_id = sakila.inventory.film_id
WHERE sakila.film.title IN('Hunchback Impossible')
GROUP BY sakila.film.title;

-- 2. List all films whose length is longer than the average of all the films.
SELECT sakila.film.title, sakila.film.length FROM sakila.film
WHERE sakila.film.length > (SELECT AVG(sakila.film.length) FROM sakila.film)
ORDER BY sakila.film.length;

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT sakila.film.title, sakila.actor.first_name, sakila.actor.last_name FROM sakila.film
JOIN sakila.film_actor ON
sakila.film.film_id = sakila.film_actor.film_id
JOIN sakila.actor ON
sakila.film_actor.actor_id = sakila.actor.actor_id
WHERE sakila.film.title IN('Alone Trip')
ORDER BY sakila.film.title;

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT sakila.film.title, sakila.category.name FROM sakila.film
JOIN sakila.film_category ON
sakila.film.film_id = sakila.film_category.film_id
JOIN sakila.category ON
sakila.film_category.category_id = sakila.category.category_id
WHERE sakila.category.name IN('Family')
ORDER BY sakila.film.title;

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
SELECT sakila.customer.first_name, sakila.customer.last_name, sakila.customer.email FROM sakila.customer
JOIN sakila.address ON
sakila.customer.address_id = sakila.address.address_id
JOIN sakila.city ON
sakila.address.city_id = sakila.city.city_id
JOIN sakila.country ON
sakila.city.country_id = sakila.country.country_id
WHERE sakila.country.country = (SELECT sakila.country.country FROM sakila.country WHERE sakila.country.country IN('Canada'));

-- Joins:
SELECT sakila.customer.first_name, sakila.customer.last_name, sakila.customer.email FROM sakila.customer
JOIN sakila.address ON
sakila.customer.address_id = sakila.address.address_id
JOIN sakila.city ON
sakila.address.city_id = sakila.city.city_id
JOIN sakila.country ON
sakila.city.country_id = sakila.country.country_id
WHERE sakila.country.country IN('Canada');

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
SELECT sakila.film.title, sakila.actor.first_name, sakila.actor.last_name FROM sakila.film
JOIN sakila.film_actor ON
sakila.film.film_id = sakila.film_actor.film_id
JOIN sakila.actor ON
sakila.film_actor.actor_id = sakila.actor.actor_id
WHERE sakila.film_actor.actor_id = (SELECT sakila.film_actor.actor_id FROM sakila.film_actor 
GROUP BY sakila.film_actor.actor_id
ORDER BY COUNT(sakila.film_actor.film_id) DESC
LIMIT 1)
ORDER BY sakila.film.title;

-- 7. Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments 
SELECT sakila.customer.first_name, sakila.customer.last_name, SUM(sakila.payment.amount) AS 'Sum of payments' FROM sakila.customer
JOIN sakila.payment ON
sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY sakila.customer.first_name
ORDER BY SUM(sakila.payment.amount) DESC
LIMIT 1;

-- 8. Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
SELECT sakila.customer.customer_id, SUM(sakila.payment.amount) AS 'Total spent by customer' FROM sakila.customer
JOIN sakila.payment ON
sakila.customer.customer_id = sakila.payment.customer_id
WHERE sakila.payment.amount > (SELECT AVG(sakila.payment.amount) FROM sakila.payment)
GROUP BY sakila.customer.customer_id;
