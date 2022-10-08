-- Lab | Making predictions with logistic regression

use sakila;

-- In order to optimize our inventory, we would like to know which films will be rented next month and we are asked to create a model to predict it.

SELECT 
    *
FROM
    rental
ORDER BY last_update;


SELECT 
    f.film_id,
    f.title,
    f.release_year,
    f.language_id,
    f.rental_rate,
    f.length,
    f.rating,
    f.special_features,
    DATE_FORMAT(MAX(r.rental_date), '%y') AS last_rental_year,
    DATE_FORMAT(MAX(r.rental_date), '%m') AS last_rental_month,
    COUNT(r.rental_id) AS rentals,
    CASE
        WHEN COUNT(r.rental_id) > 0 THEN 1
        ELSE 0
    END AS rented_ever,
    CASE
        WHEN
            DATE_FORMAT(MAX(r.rental_date), '%m') = 02
                AND DATE_FORMAT(MAX(r.rental_date), '%y') = 06
        THEN
            1
        ELSE 0
    END AS rented_last_month
FROM
    film f
        LEFT JOIN
    inventory i ON f.film_id = i.film_id
        LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id;

-- 2. Read the data into a Pandas dataframe.