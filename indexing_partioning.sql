create schema if not exists index_test_schema;

use index_test_schema;

drop table if exists b_tree_table;

create table if not exists b_tree_table(id int primary key auto_increment, random_val int);

DROP PROCEDURE IF EXISTS filling_b_tree_table;

DELIMITER //

CREATE PROCEDURE filling_b_tree_table(insert_number INTEGER)
BEGIN
  DECLARE counter INT DEFAULT 0;
	START TRANSACTION;

    WHILE counter < insert_number DO
        INSERT INTO b_tree_table (random_val) VALUES (FLOOR(RAND()*998+2));
        SET counter = counter + 1;
    END WHILE;

  COMMIT;
END //

DELIMITER ;

SELECT COUNT(*) FROM b_tree_table;

call filling_b_tree_table(100000);

SELECT COUNT(*) FROM b_tree_table;

SELECT * FROM b_tree_table LIMIT 5;

SELECT COUNT(*)
FROM b_tree_table t1
INNER JOIN b_tree_table t2 ON t1.random_val = t2.random_val
WHERE t1.random_val < 30;

SELECT COUNT(*)
FROM b_tree_table t1
INNER JOIN b_tree_table t2 ON t1.random_val = t2.random_val
WHERE t1.random_val < 30;

CREATE INDEX rvx ON b_tree_table(random_val);





















