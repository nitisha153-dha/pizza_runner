use pizza_runner;
DROP TABLE IF EXISTS runners;

CREATE TABLE runners (
    runner_id INT,
    registration_date DATE
);
INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');
DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);
INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);
INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);
INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
  
select pizza_id,count(pizza_id) as count from customer_orders group by pizza_id; 
select* from customer_orders;
SELECT *,
COUNT(*)
FROM customer_orders
GROUP BY
order_id,
customer_id,
pizza_id,
exclusions,
extras,
order_time
HAVING COUNT(*) > 1;
CREATE TABLE customer_orders_clean AS
SELECT DISTINCT *
FROM customer_orders;
select* from customer_orders_clean; 
SET SQL_SAFE_UPDATES = 0;


UPDATE customer_orders_clean
SET exclusions = NULL
WHERE TRIM(exclusions) IN ('null', '', 'NaN')
   OR exclusions IS NULL;
UPDATE customer_orders_clean
SET extras = NULL
WHERE TRIM(extras) IN ('null', '', 'NaN')
   OR extras IS NULL;

CREATE TABLE runner_orders_clean AS
SELECT *
FROM runner_orders;
UPDATE runner_orders_clean
SET pickup_time = NULL
WHERE pickup_time = 'null';
UPDATE runner_orders_clean
SET distance = REPLACE(distance, 'km', '');
UPDATE runner_orders_clean
SET distance = NULL
WHERE distance = 'null' OR distance = '';
UPDATE runner_orders_clean
SET duration = REGEXP_REPLACE(duration, '[^0-9]', '');
UPDATE runner_orders_clean
SET duration = NULL
WHERE duration = 'null' OR duration = '';
UPDATE runner_orders_clean
SET duration = TRIM(duration);
UPDATE runner_orders_clean
SET cancellation = NULL
WHERE cancellation = 'null' OR cancellation = '';
SELECT * FROM runner_orders_clean;
ALTER TABLE runner_orders_clean
MODIFY distance DECIMAL(5,2),
MODIFY duration INT,
MODIFY pickup_time DATETIME;

SELECT duration
FROM runner_orders_clean
WHERE duration IS NULL
   OR duration = ''
   OR duration = 'null';
ALTER TABLE runner_orders_clean
MODIFY distance DECIMAL(5,2);
ALTER TABLE runner_orders_clean
MODIFY duration INT;
SELECT 
    CAST(REPLACE(distance,'km','') AS DECIMAL(5,2)) AS distance
FROM runner_orders_clean;
# it is used to check the error in duration 
SELECT *
FROM runner_orders_clean
WHERE duration IS NOT NULL
  AND duration NOT REGEXP '^[0-9]+$';
ALTER TABLE runner_orders_clean
MODIFY pickup_time DATETIME;

# How many pizzas were ordered?  
SELECT COUNT(*) AS total_pizzas_ordered
FROM customer_orders;
# How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS unique_customer_orders
FROM customer_orders;


# How many successful orders were delivered by each runner?
SELECT 
    runner_id,
    COUNT(order_id) AS successful_deliveries
FROM runner_orders_clean
WHERE cancellation IS NULL
GROUP BY runner_id;
  
#4 How many of each type of pizza was delivered?
SELECT 
    pn.pizza_name,
    COUNT(*) AS total_delivered
FROM customer_orders_clean co
JOIN runner_orders_clean ro 
    ON co.order_id = ro.order_id
JOIN pizza_names pn 
    ON co.pizza_id = pn.pizza_id
WHERE ro.cancellation IS NULL
GROUP BY pn.pizza_name;
#How many Vegetarian and Meatlovers were ordered by each customer?
SELECT 
    co.customer_id,
    pn.pizza_name,
    COUNT(*) AS total_orders
FROM customer_orders_clean co
JOIN pizza_names pn
    ON co.pizza_id = pn.pizza_id
GROUP BY 
    co.customer_id,
    pn.pizza_name
ORDER BY 
    co.customer_id,
    pn.pizza_name;
# For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT
    co.customer_id,
    SUM(
        CASE
            WHEN co.exclusions IS NOT NULL
              OR co.extras IS NOT NULL
            THEN 1
            ELSE 0
        END
    ) AS at_least_1_change,

    SUM(
        CASE
            WHEN co.exclusions IS NULL
             AND co.extras IS NULL
            THEN 1
            ELSE 0
        END
    ) AS no_change
FROM customer_orders_clean co
JOIN runner_orders_clean ro
    ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL
GROUP BY co.customer_id
ORDER BY co.customer_id;
# How many pizzas were delivered that had both exclusions and extras?
SELECT
    COUNT(*) AS pizzas_with_exclusions_and_extras
FROM customer_orders_clean co
JOIN runner_orders_clean ro
    ON co.order_id = ro.order_id
WHERE ro.cancellation IS NULL
  AND co.exclusions IS NOT NULL
  AND co.extras IS NOT NULL;
# What was the total volume of pizzas ordered for each hour of the day?
SELECT
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_pizzas
FROM customer_orders_clean
GROUP BY HOUR(order_time)
ORDER BY order_hour;

# What was the total volume of pizzas ordered for each day of the week?
select DAYNAME(order_time) as days_of_week,
	   COUNT(*) AS TOTAL_PIZZAS 
FROM customer_orders_clean 
group by 
dayofweek(order_time),
dayname(order_time)
order by dayofweek(order_time) ;
#How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
select 
     week(registration_date) as reg_week,
     count(runner_id) as total_runners
from runners
group by week(registration_date)
order by reg_week;
# What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
select ro.runner_id,
      round(avg(timestampdiff(minute,
      co.order_time,ro.pickup_time)),2)
      as avg_pickup_time
from customer_orders_clean co 
join runner_orders_clean ro 
       on co.order_id=ro.order_id
where ro.cancellation is null
group by ro.runner_id
order by ro.runner_id;
#Is there any relationship between the number of pizzas and how long the order takes to prepare?
SELECT
    co.order_id,
    COUNT(ro.pizza_id) AS total_pizzas,
    TIMESTAMPDIFF(
        MINUTE,
        MIN(ro.order_time),
        MIN(co.pickup_time)
    ) AS preparation_time
FROM customer_orders ro
JOIN runner_orders co
    ON ro.order_id = co.order_id
WHERE co.pickup_time IS NOT NULL
GROUP BY co.order_id
ORDER BY co.order_id;
#What was the average distance travelled for each customer?
SELECT
    c.customer_id,
    ROUND(
        AVG(
            CAST(REPLACE(r.distance, 'km', '') AS DECIMAL(5,2))
        ),
        2
    ) AS avg_distance_km
FROM customer_orders c
JOIN runner_orders r
    ON c.order_id = r.order_id
WHERE r.distance IS NOT NULL
GROUP BY c.customer_id
ORDER BY c.customer_id;
#Is there any difference between the longest and shortest delivery times for all orders?
SELECT
    MIN(CAST(REGEXP_SUBSTR(duration, '[0-9]+') AS UNSIGNED)) AS shortest_delivery,
    MAX(CAST(REGEXP_SUBSTR(duration, '[0-9]+') AS UNSIGNED)) AS longest_delivery,
    MAX(CAST(REGEXP_SUBSTR(duration, '[0-9]+') AS UNSIGNED))
    - MIN(CAST(REGEXP_SUBSTR(duration, '[0-9]+') AS UNSIGNED)) AS difference
FROM runner_orders
WHERE duration IS NOT NULL;
#What was the average speed for each runner for each delivery, and do you notice any trend for these values?
SELECT
    runner_id,
    order_id,
    CAST(REPLACE(distance, 'km', '') AS DECIMAL(5,2)) AS distance_km,
    CAST(REGEXP_SUBSTR(duration, '[0-9]+') AS UNSIGNED) AS duration_min,
    ROUND(
        (
            CAST(REPLACE(distance, 'km', '') AS DECIMAL(5,2))
            /
            CAST(REGEXP_SUBSTR(duration, '[0-9]+') AS UNSIGNED)
        ) * 60,
        2
    ) AS avg_speed_kmh
FROM runner_orders
WHERE distance IS NOT NULL
ORDER BY runner_id, order_id;
#Calculate the percentage of orders successfully delivered by each runner.
SELECT
    runner_id,
    COUNT(*) AS total_orders,
    SUM(CASE
            WHEN cancellation IS NULL THEN 1
            ELSE 0
        END) AS successful_orders,
    ROUND(
        SUM(CASE
                WHEN cancellation IS NULL THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS success_percentage
FROM runner_orders
GROUP BY runner_id;
#What are the standard ingredients for each pizza?
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT
    pn.pizza_name,
    pt.topping_name
FROM pizza_recipes pr
JOIN pizza_names pn
    ON pr.pizza_id = pn.pizza_id
JOIN numbers
    ON numbers.n <= 1 + LENGTH(pr.toppings)
                     - LENGTH(REPLACE(pr.toppings, ',', ''))
JOIN pizza_toppings pt
    ON pt.topping_id =
       CAST(
           SUBSTRING_INDEX(
               SUBSTRING_INDEX(pr.toppings, ',', numbers.n),
               ',',
               -1
           ) AS UNSIGNED
       )
ORDER BY pn.pizza_name, pt.topping_name;
#If a Meat Lovers pizza costs $12 and Vegetarian costs $10, how much money has Pizza Runner earned from successful deliveries?

SELECT
SUM(
    CASE
        WHEN pn.pizza_name = 'Meatlovers' THEN 12
        WHEN pn.pizza_name = 'Vegetarian' THEN 10
    END
) AS total_revenue
FROM customer_orders_clean co
JOIN pizza_names pn
    ON co.pizza_id = pn.pizza_id;
# What if there was an additional $1 charge for any pizza extras? and Add cheese is $1 extra    
SELECT
    SUM(
        CASE
            WHEN pn.pizza_name = 'Meatlovers' THEN 12
            WHEN pn.pizza_name = 'Vegetarian' THEN 10
            ELSE 0
        END
    ) +
    SUM(
        CASE
            WHEN co.extras IS NULL
                 OR co.extras = ''
                 OR co.extras = 'null'
            THEN 0
            ELSE LENGTH(co.extras)
                 - LENGTH(REPLACE(co.extras, ',', ''))
                 + 1
        END
    ) AS total_revenue
FROM customer_orders_clean co
JOIN runner_orders_clean ro
    ON co.order_id = ro.order_id
JOIN pizza_names pn
    ON co.pizza_id = pn.pizza_id
WHERE ro.cancellation IS NULL;

#The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner,how would you design an additional table for this new dataset - 
# generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
CREATE TABLE runner_ratings (
    order_id INT PRIMARY KEY,
    customer_id INT,
    runner_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5)
);
select* from runner_ratings;
