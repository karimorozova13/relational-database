CREATE TABLE Customers (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255));

CREATE TABLE ORDERS (
id INT AUTO_INCREMENT PRIMARY KEY,
order_date DATE,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(id));

CREATE TABLE employees (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255));

ALTER TABLE employees
ADD COLUMN salary DECIMAL(8,2);

DROP TABLE employees;

TRUNCATE TABLE employees;

INSERT INTO employees (id, name, salary)
VALUES (2, 'Lewa', 7500.13);

SELECT * FROM employees;

UPDATE employees
SET name = 'Platon'
WHERE id = 1;

INSERT INTO employees (name, salary)
VALUES ('Kari', 4500.13);

DELETE FROM employees
WHERE id=2;

INSERT INTO customers (id, name)
VALUES (1, 'Lewa');

SELECT * FROM customers;

INSERT INTO customers (id, name)
VALUES (3, 'Kari');

SELECT id, name FROM managers
UNION 
SELECT id, name FROM customers;

CREATE TABLE managers (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255));

INSERT INTO managers (id, name)
VALUES (2, 'Iana');

SELECT * FROM managers;

SELECT id, name FROM managers 
INTERSECT
SELECT id, name FROM customers;

SELECT id, name FROM managers 
EXCEPT
SELECT id, name FROM customers;

ALTER TABLE managers 
ADD COLUMN employee_id INT;

UPDATE managers
SET employee_id = 4
WHERE id = 3;

SELECT managers.id, managers.name, managers.employee_id, 
employees.name as employee_name
FROM employees
INNER JOIN managers ON employees.id = managers.employee_id;

CREATE TABLE names (id int auto_increment primary key, name varchar(255));
insert into names (id, name) values (4, 'Klim');

CREATE TABLE ages (id int primary key, age int);
insert into ages (id, age) values (4, 0);

SELECT * from ages
RIGHT JOIN names ON names.id = ages.id;

SELECT * FROM names
CROSS JOIN ages;
