SELECT * FROM mydb.products;
SELECT name, phone FROM mydb.shippers;

SELECT MIN(price) FROM mydb.products;
SELECT MAX(price) FROM mydb.products;
SELECT AVG(price) FROM mydb.products;
SELECT MIN(price) as min_price, MAX(price) as max_price, AVG(price) as avg_price FROM mydb.products;

SELECT DISTINCT category_id, price FROM mydb.products ORDER BY price DESC LIMIT 10;

SELECT COUNT(*) as price_in_range FROM mydb.products WHERE price > 20 AND price < 100;

SELECT supplier_id, COUNT(*) as total_products, AVG(price) as avg_price FROM mydb.products GROUP BY supplier_id;




