#Alter, Update, Copy Examples using classicmodels and added table
Select * From usa_company_cars;

#Alter add
ALTER TABLE usa_company_cars
ADD VehicleType CHAR(5);

Select * From usa_company_cars;

#Alter modify
ALTER TABLE usa_company_cars
MODIFY COLUMN VehicleType varchar(50);

Select * From usa_company_cars;


#Update
Select * FROM employees;

UPDATE usa_company_cars SET PrimaryDriverID = 1102 WHERE CarID =10;

#Updates for altered column
Select * FROM usa_company_cars;
UPDATE usa_company_cars SET VehicleType = "Truck" WHERE Make = "Ford" or Make ="GMC" and Model <> "Crown Victoria";
UPDATE usa_company_cars SET VehicleType = "Sedan" WHERE FuelType IN ("Hybrid","Electric") or Model IN ("Civic","Crown Victoria");
UPDATE usa_company_cars SET VehicleType = "Compact" WHERE Model ="Spark";

UPDATE usa_company_cars SET VehicleType = "Van" 
WHERE PrimaryDriverID = 
(Select employeeNumber from employees Where firstName="Julie" and lastName = "Firrelli");

#Alter drop
ALTER TABLE usa_company_cars
DROP COLUMN VehicleType;

#Copy with like for complete structure
CREATE TABLE copy_cars LIKE usa_company_cars;
Select * FROM copy_cars;

#Copy with a query (shallow copy) only basic structure and data
CREATE TABLE copy_cars2 AS SELECT * FROM usa_company_cars;
Select * FROM copy_cars2;

DROP TABLE copy_cars,copy_cars2;

#Show all queries to copy
SHOW CREATE TABLE usa_company_cars;