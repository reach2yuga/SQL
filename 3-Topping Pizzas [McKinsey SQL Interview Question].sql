/*3-Topping Pizzas [McKinsey SQL Interview Question]
You’re a consultant for a major pizza chain that will be running a promotion where all 
3-topping pizzas will be sold for a fixed price, and are trying to understand the costs involved.

Given a list of pizza toppings, consider all the possible 3-topping pizzas, 
and print out the total cost of those 3 toppings. Sort the results with the highest 
total cost on the top followed by pizza toppings in ascending order.

Break ties by listing the ingredients in alphabetical order, 
starting from the first ingredient, followed by the second and third.*/

CREATE TABLE pizza_toppings (
    topping_name VARCHAR(255) PRIMARY KEY,
    ingredient_cost DECIMAL(10,2) NOT NULL
);

INSERT INTO pizza_toppings (topping_name, ingredient_cost) VALUES
('Pepperoni', 0.50),
('Sausage', 0.70),
('Chicken', 0.55),
('Extra Cheese', 0.40);

SELECT * FROM pizza_toppings;


SELECT 
    CONCAT(t1.topping_name, ',', t2.topping_name, ',', t3.topping_name) AS pizza,
    (t1.ingredient_cost + t2.ingredient_cost + t3.ingredient_cost) AS total_cost
FROM pizza_toppings t1
JOIN pizza_toppings t2 ON t1.topping_name < t2.topping_name
JOIN pizza_toppings t3 ON t2.topping_name < t3.topping_name
ORDER BY 
    total_cost DESC,  -- Highest total cost first
    pizza ASC;        -- Alphabetical order for tiebreaks


