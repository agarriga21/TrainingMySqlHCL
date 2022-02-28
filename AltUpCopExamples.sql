#Alter, Update, Copy Examples

ALTER TABLE People
ADD Country CHAR(2);
Select * From People;

ALTER TABLE People
MODIFY COLUMN Country varchar(255) NOT NULL;
Select * From People;

ALTER TABLE People
DROP COLUMN Country;
Select * From People;

Select * FROM Employee;
UPDATE Employee SET ManagerID = 1 WHERE ManagerID IS NULL;

CREATE TABLE copy_emp LIKE Employee;
Select * FROM copy_emp;

CREATE TABLE copy_emp2 AS SELECT * FROM Employee;
Select * FROM copy_emp2;

DROP TABLE copy_emp,copy_emp2;

SHOW CREATE TABLE Employee;