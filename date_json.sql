use mydb;

select id, date, YEAR(date) as year, MONTH(date) as month, DAY(date) as day from orders;

select id, date, DATE_ADD(date, INTERVAL 1 day) as modified_date from orders;

select id, date, UNIX_TIMESTAMP(date) as timestamp from orders;

select count(*) from orders where date between '1996-07-10 00:00:00' and '1996-10-08 00:00:00';

select id, date, json_object('id', id, 'date', date) from orders;




















