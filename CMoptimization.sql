#Finding queries with high cost

#db with performance information
use performance_schema;
#tables within the performance_schema
show tables;

#Shows table of queries ran with their wait times and other info
select * from events_statements_summary_by_digest;

#Top 10 most expensive queries with wait time in classicmodels
select * from events_statements_summary_by_digest
where SCHEMA_NAME = "classicmodels"
order by SUM_TIMER_WAIT desc
limit 10;

#Analzing and Optimizing Queries
Explain Select * From customers where state = "CA";
Explain format=json Select * From customers where state = "CA";
Explain format=tree Select * From customers where state = "CA";
Explain analyze Select * From customers where state = "CA";

#adding an index
CREATE INDEX state_index
ON customers (state);

ALTER TABLE customers
DROP INDEX state_index;

Explain analyze Select customerName,city From customers where state = "CA";

#covering index
ALTER TABLE customers
ADD INDEX state_city_name (state,city,customerName);

ALTER TABLE customers
DROP INDEX state_city_name;

Explain delete from customers where state = "CA";

Explain Select customerNumber ,sum(amount) as "Total Payment Amount" from payments 
group by customerNumber 
order by sum(amount) desc
LIMIT 10;

Explain format=json Select customerNumber ,sum(amount) as "Total Payment Amount" from payments 
group by customerNumber 
order by sum(amount) desc
LIMIT 10;

Explain format=tree Select customerNumber ,sum(amount) as "Total Payment Amount" from payments 
group by customerNumber 
order by sum(amount) desc
LIMIT 10;

Explain Analyze Select customerNumber ,sum(amount) as "Total Payment Amount" from payments 
group by customerNumber 
order by sum(amount) desc
LIMIT 10;

USE sys;
SELECT * FROM SCHEMA_TABLES_WITH_FULL_TABLE_SCANS;
SELECT * FROM STATEMENTS_WITH_FULL_TABLE_SCANS;

# Find unused indexes
USE sys;
SELECT * FROM SCHEMA_INDEX_STATISTICS;
SELECT * FROM SCHEMA_UNUSED_INDEXES;
SELECT * FROM SCHEMA_REDUNDANT_INDEXES;

#composite indexes
Explain analyze Select * From customers where state = "CA" and creditLimit>60000;

CREATE INDEX state_creditLimit_index
ON customers (state,creditLimit);

ALTER TABLE customers
DROP INDEX state_creditLimit_index;

Explain analyze Select * From customers where state = "CA" and city="San Francisco";

CREATE INDEX city_state_index
ON customers (city,state);

ALTER TABLE customers
DROP INDEX city_state_index;