use mydb;

SELECT
    o.id AS order_id,
    o.date,
    od.quantity,
    p.name AS product_name,
    p.unit,
    p.price,
    (SELECT AVG(price) FROM products WHERE id = od.product_id GROUP BY id) AS average_product_price
FROM
    orders o
JOIN
    order_details od ON o.id = od.order_id
JOIN
    products p ON od.product_id = p.id;

SELECT 
   o.id AS order_id, 
   COUNT(od.id) AS total_products, 
   SUM(p.price * od.quantity) AS total_order_cost 
FROM 
   orders o 
JOIN 
   order_details od ON o.id = od.order_id 
JOIN 
   products p ON od.product_id = p.id 
WHERE 
   od.quantity = (SELECT MAX(quantity) FROM order_details) 
GROUP BY 
   o.id;
   
SELECT order_id, quantity, product_id
FROM order_details
WHERE (quantity, product_id) IN (SELECT quantity, product_id FROM order_details WHERE quantity > 5);

SELECT
    category_id,
    AVG(price) AS avg_price
FROM
    (SELECT * FROM products WHERE category_id IN (2,3)) AS temp_table
GROUP BY
    category_id;
    
WITH OrderDetailsWithProductInfo AS (
    SELECT
        o.id AS order_id,
        o.customer_id,
        o.date,
        od.product_id,
        p.name AS product_name,
        p.price,
        od.quantity,
        (p.price * od.quantity) AS total_cost
    FROM
        orders o
    JOIN
        order_details od ON o.id = od.order_id
    JOIN
        products p ON od.product_id = p.id
)
SELECT
    order_id,
    customer_id,
    date,
    product_id,
    product_name,
    quantity,
    price,
    total_cost
FROM
    OrderDetailsWithProductInfo
WHERE
    customer_id > 50;
    
INSERT INTO orders (id, customer_id, employee_id, date, shipper_id)
SELECT id,
		34 as customer_id,  
		4 as employee_id,
		NOW() as date, 
		1 as shipper_id
	FROM customers WHERE name LIKE 'Bo%'
    LIMIT 2;
SELECT * from orders order by date desc LIMIT 2; 

DELIMITER //
CREATE FUNCTION CalculateSquare (num INT)
RETURNS INT
DETERMINISTIC 
NO SQL
BEGIN
DECLARE result int;
SET result = num * num;
RETURN result;
END //

DELIMITER ;

SELECT CalculateSquare(3);

DROP FUNCTION IF EXISTS CalculateSquare;

DELIMITER //
CREATE PROCEDURE GetEmployeeDetails(id INT)
BEGIN
SELECT * FROM employees WHERE employee_id = id;
END //
DELIMITER ;

CALL GetEmployeeDetails(3);

DROP PROCEDURE IF EXISTS GetOrderDetails;

DELIMITER //

CREATE PROCEDURE GetOrderDetails(IN order_id_param INT)
READS SQL DATA
BEGIN
    DECLARE product_name VARCHAR(255) DEFAULT 'Not found!';
    DECLARE order_quantity INT DEFAULT 0;

    SELECT p.name, od.quantity INTO product_name, order_quantity
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    WHERE od.order_id = order_id_param
    LIMIT 1;

    -- Вивести результат
    SELECT 'Product Name:', product_name, 'Order Quantity:', order_quantity;
END //

DELIMITER ;

CALL GetOrderDetails(10249);

CALL GetOrderDetails(1);

DELIMITER //
CREATE PROCEDURE example_while()
DETERMINISTIC
NO SQL
BEGIN
	DECLARE counter INT DEFAULT 0;
	WHILE counter < 10 DO
		SELECT counter;
		SET counter = counter + 1;
	END WHILE;
END //
DELIMITER ;

call example_while();

DELIMITER //
CREATE PROCEDURE example_repeat()
DETERMINISTIC
BEGIN
  DECLARE counter INT DEFAULT 0;
	REPEAT
		SELECT counter;
		SET counter = counter + 1;
	UNTIL counter > 10
	END REPEAT;
END //
DELIMITER ;

call example_repeat();

DELIMITER //
CREATE PROCEDURE example_loop()
DETERMINISTIC
BEGIN
    DECLARE counter INT DEFAULT 0;
    simple_loop: LOOP
        SELECT counter;
        SET counter = counter + 1;
        IF counter >= 5 THEN
            LEAVE simple_loop;
        END IF;
    END LOOP simple_loop;
END //

DELIMITER ;

CALL example_loop();








