-- p1 
SELECT 
	order_id, 
	product_id, 
	quantity, 
(SELECT customer_id FROM orders WHERE id = od.order_id) AS customer_id
FROM 
    order_details od;
    
-- p2
SELECT 
	order_id, 
	product_id, 
	quantity
FROM 
    order_details od
WHERE 
    od.order_id IN (
        SELECT id 
        FROM orders 
        WHERE shipper_id = 3
    );
    
-- p3
SELECT order_id, AVG(quantity) AS avg_quantity
FROM (SELECT * FROM order_details WHERE quantity > 10) AS temp_table
GROUP BY order_id;

 -- p4
 WITH TemporalTable AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM TemporalTable
GROUP BY order_id;

-- p5
DROP FUNCTION IF EXISTS divide_fn;

DELIMITER // 
CREATE FUNCTION divide_fn(quantity FLOAT, num FLOAT)
RETURNS FLOAT
DETERMINISTIC 
BEGIN
	DECLARE result INT;
    IF num = 0 THEN
		RETURN NULL;
    END IF;
	SET result = quantity / num;
	RETURN result;
END //

DELIMITER ;
DROP PROCEDURE IF EXISTS for_all_orders;

DELIMITER //

CREATE PROCEDURE for_all_orders()
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE count INT DEFAULT 0;
    DECLARE order_quantity FLOAT;
    DECLARE total INT;

    SET total = (SELECT COUNT(*) FROM order_details);

    WHILE count < total DO
        SELECT quantity INTO order_quantity
        FROM order_details
        LIMIT 1 OFFSET count;

        SELECT divide_fn(order_quantity, count + 1) AS result;

        SET count = count + 1;
    END WHILE;
END //

DELIMITER ;

call for_all_orders();







