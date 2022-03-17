#Alter, Update, Copy Examples using database_sample

#Alter add
ALTER TABLE People
ADD Country CHAR(2);

Select * From People;

#Alter modify
ALTER TABLE People
MODIFY COLUMN Country varchar(255);


Select * From People;

#Alter drop
ALTER TABLE People
DROP COLUMN Country;

Select * From People;

#Update
Select * FROM Employee;
UPDATE Employee SET ManagerID = 1 WHERE ManagerID IS NULL;

#Update 2 with altered column
Select * FROM People;
UPDATE People SET Country = "USA" WHERE State IS NOT NULL;
UPDATE People SET Country = "Other" WHERE State IS NULL;

#Copy with like
CREATE TABLE copy_emp LIKE Employee;
Select * FROM copy_emp;

#Copy with a query (shallow copy)
CREATE TABLE copy_emp2 AS SELECT * FROM Employee;
Select * FROM copy_emp2;

DROP TABLE copy_emp,copy_emp2;

#Show all queries to copy
SHOW CREATE TABLE Employee;