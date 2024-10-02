# Given the following schema, please write an SQL query that determines what percentage of items
# that have never been sold for all items in the items table having over 600 calories?
 
 
# items
# -----
# id (PK)
# menu_id
# category
# name
# is_spicy_flg
# is_vegetarian_flg
# is_vegan_flg
# calories
# servings
# price
 
# order_items
# -----------
# id (PK)
# order_id
# item_id (FK -> items.id)
# quantity
# notes


drop table items

CREATE TABLE items (
    id INT PRIMARY KEY,
    menu_id INT,
    category VARCHAR(100),
    name VARCHAR(100),
    is_spicy_flg BIT,
    is_vegetarian_flg BIT,
    is_vegan_flg BIT,
    calories INT,
    servings INT,
    price DECIMAL(10, 2)
);


CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    notes VARCHAR(255),
    FOREIGN KEY (item_id) REFERENCES items(id)
);

INSERT INTO items (id, menu_id, category, name, is_spicy_flg, is_vegetarian_flg, is_vegan_flg, calories, servings, price) VALUES
(1, 3, 'Snack', 'Sandwich 1', 1, 0, 1, 439, 1, 2.83),
(2, 8, 'Snack', 'Juice 2', 1, 1, 1, 728, 1, 2.92),
(3, 10, 'Dessert', 'Coke 3', 1, 1, 0, 429, 3, 2.27),
(4, 9, 'Snack', 'Soup 4', 0, 1, 1, 846, 4, 14.71),
(5, 6, 'Snack', 'Pizza 5', 0, 1, 0, 747, 3, 12.32);


INSERT INTO order_items (id, order_id, item_id, quantity, notes) VALUES
(1, 1080, 5, 4, 'No onions'),  -- item_id 5 must exist in items table
(2, 1043, 3, 4, 'No onions'),  -- item_id 3 must exist in items table
(3, 1059, 4, 3, ''),           -- item_id 4 must exist in items table
(4, 1034, 2, 2, ''),           -- item_id 2 must exist in items table
(5, 1046, 1, 3, '');           -- item_id 1 must exist in items table




SELECT 
    i.id AS item_id,
    i.menu_id,
    i.category,
    i.name,
    i.is_spicy_flg,
    i.is_vegetarian_flg,
    i.is_vegan_flg,
    i.calories,
    i.servings,
    i.price,
    oi.id AS order_item_id,
    oi.order_id,
    oi.quantity,
    oi.notes
FROM 
    items i
INNER JOIN 
    order_items oi
ON 
    i.id = oi.item_id;




	WITH high_cal_items AS (
    -- Step 1: Get all items with over 600 calories
    SELECT id
    FROM items
    WHERE calories > 600
),
sold_items AS (
    -- Step 2: Get all items that have been sold (items present in the order_items table)
    SELECT DISTINCT item_id
    FROM order_items
),
unsold_items AS (
    -- Step 3: Get all items with over 600 calories that have never been sold
    SELECT hci.id
    FROM high_cal_items hci
    LEFT JOIN sold_items si ON hci.id = si.item_id
    WHERE si.item_id IS NULL
)
-- Step 4: Calculate the percentage of unsold items
SELECT 
    (COUNT(ui.id) * 100.0) / COUNT(hci.id) AS unsold_percentage
FROM high_cal_items hci
LEFT JOIN unsold_items ui ON hci.id = ui.id;
