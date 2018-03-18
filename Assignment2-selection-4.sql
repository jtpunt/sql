/*******************************************
* Author: Jonathan Perry
* Date: 11/05/17
* Assignment: CS 340 - Assignment 2
*******************************************/
#1 Find all films with maximum length or minimum rental duration (compared to all other films). 
#In other words let L be the maximum film length, and let R be the minimum rental duration in the table film. You need to find all films that have length L or duration R or both length L and duration R.
#You just need to return attribute film id for this query. 
/* Min rental duration is 3, max film length is 185.
   We need to find films with a mental duration of 3,
   OR  with a maximum film length of 185 minutes. */
SELECT title, rental_duration, length
FROM film 
WHERE rental_duration = (SELECT MIN(rental_duration) FROM film)
OR length = (SELECT MAX(length) FROM film);

#2 We want to find out how many of each category of film ED CHASE has started in so return a table with category.name and the count
#of the number of films that ED was in which were in that category order by the category name ascending (Your query should return every category even if ED has been in no films in that category).
SELECT c.name AS 'Movie Categories', COUNT(a.actor_id) AS 'Total Films with Ed Chase'
FROM category AS c
LEFT JOIN film_category AS fc ON c.category_id = fc.category_id
LEFT JOIN film AS f ON fc.film_id = f.film_id
LEFT JOIN film_actor AS fa ON f.film_id = fa.film_id 
LEFT JOIN actor AS a ON fa.actor_id = a.actor_id
AND a.first_name = 'ED' AND a.last_name = 'CHASE'
GROUP BY c.category_id, c.name
ORDER BY c.name;


#3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
#That is the result should list the names of all of the actors(even if an actor has not been in any Sci-Fi films)and the total length of Sci-Fi films they have been in.
SELECT concat(a.first_name, ' ', a.last_name) AS 'Actor', table1.total AS 'Total Time in Sci-Fi Films'
FROM actor a
LEFT JOIN 
    (SELECT a.first_name, a.last_name, a.actor_id, SUM( f.length ) AS total, c.name
    FROM actor a, film_actor fa, film f, film_category fc, category c
    WHERE c.category_id = fc.category_id
    AND fc.film_id = f.film_id
    AND a.actor_id = fa.actor_id
    AND fa.film_id = f.film_id
    AND c.name =  'Sci-Fi'
    GROUP BY a.actor_id) 
    AS table1
ON a.actor_id = table1.actor_id  
ORDER BY a.first_name ASC;


#4 Find the first name and last name of all actors who have never been in a Sci-Fi film
SELECT concat(a.first_name, ' ', a.last_name) AS 'Actors Who Havent Been in a Sci-Fi Film'
FROM actor a
WHERE a.actor_id NOT
IN (
    SELECT a.actor_id
    FROM film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
    WHERE c.name = 'Sci-Fi'
) ORDER BY a.first_name  ASC


#5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies
SELECT f.title AS 'Films Featuring BOTH Kirsten Paltrow AND Warren Nolte'
FROM film f 
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
WHERE a.actor_id=(
SELECT actor_id FROM actor WHERE first_name='KIRSTEN' && last_name='PALTROW') || a.actor_id=(SELECT actor_id FROM actor WHERE first_name='WARREN' && last_name="NOLTE")
GROUP BY f.title HAVING (count(*) >= 2)
ORDER BY f.title DESC;

