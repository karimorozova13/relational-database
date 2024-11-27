create schema time_demo;
use time_demo;

CREATE TABLE datetime_type (datetime_col DATETIME, timestamp_col TIMESTAMP);

DESCRIBE datetime_type;

SELECT @@system_time_zone, @@session.time_zone, TIMEDIFF(NOW(), UTC_TIMESTAMP);

INSERT INTO datetime_type(datetime_col, timestamp_col) VALUES (NOW(), NOW());

SELECT * FROM datetime_type;

SET @@session.time_zone='+00:00';

SELECT @@system_time_zone, @@session.time_zone, TIMEDIFF(NOW(), UTC_TIMESTAMP);

SELECT * FROM datetime_type;

DROP SCHEMA time_demo;

-- Додаємо та віднімаємо 3 години до/від поточної дати та часу
SELECT NOW() AS current_datetime,
       NOW() + INTERVAL 3 HOUR AS datetime_plus,        
       NOW() - INTERVAL 3 HOUR AS datetime_minus;
       
CREATE SCHEMA j_schema;

USE j_schema;

CREATE TABLE example_table (
    id INT PRIMARY KEY AUTO_INCREMENT,
    json_data JSON
);

INSERT INTO example_table (json_data)
VALUES ('{"name": "John Doe", "age": 30, "courses": ["Math", "History"], "marks": {"Math": 3, "History":4} }');

INSERT INTO example_table (json_data)
VALUES ('{"name": "Omar Navarro", "age": 55, "courses": ["Chemistry", "German"], "marks": {"Chemistry": 5, "German":3} }');

SELECT * FROM example_table;

SELECT json_data->>'$.age' AS age FROM example_table;

SELECT json_data->>'$.courses' AS courses FROM example_table;

SELECT json_data->>'$.courses[0]' AS course_1, json_data->>'$.courses[1]' AS course_2 FROM example_table;

SELECT json_data->>'$.marks.Math' AS courses FROM example_table;

SELECT JSON_ARRAY(1, "abc", NULL, TRUE, CURTIME());

SELECT JSON_OBJECT('id', 87, 'name', 'carrot');

SELECT JSON_EXTRACT('{"name": "John", "age": 30}', '$.name') AS extracted_value;

SELECT JSON_UNQUOTE(JSON_EXTRACT('{"name": "John", "age": 30}', '$.name')) AS unquoted_value;

SELECT JSON_SEARCH('{"name": "John", "age": 30}', 'all', 'John') AS search_result;

SELECT JSON_CONTAINS('{"name": "John", "age": 30}', '"John"', '$.name' ) AS contains_result;

SELECT JSON_SET('{"name": "John", "age": 30}', '$.age', 31) AS modified_json;

SELECT JSON_INSERT('{"name": "John", "age": 30}', '$.city', 'New York') AS modified_json;

SELECT JSON_REPLACE('{"name": "John", "age": 30}', '$.age', 31) AS modified_json;

SELECT JSON_REMOVE('{"name": "John", "age": 30}', '$.age') AS modified_json;



















