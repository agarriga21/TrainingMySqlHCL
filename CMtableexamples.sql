#table examples classicmodels
#look up composite key
#Viewing tables in the db to show what this db is
select * from employees;
select * from offices;
select * from customers;
select * from orders;
select * from orderdetails;
select * from payments;
select * from productlines;
select * from products;

#Data needed in classicmodels for later examples
INSERT INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (0,"N/A","N/A","N/A","N/A","N/A","N/A", "Remote" ,"USA");

INSERT INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (9,"435-647-7654","1435 Bart ST","Office 36","MN","94324","USA", "St. Paul" ,"USA");

INSERT INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (7567,"Worker", "Remote" ,"x3643", "remotework@gmail.com",0,1143,"Sales Rep");

#Table Creating examples

drop table usa_company_cars;
CREATE TABLE usa_company_cars (
    CarID int AUTO_INCREMENT,
    AssignedOfficeID int DEFAULT 0,
    PrimaryDriverID int DEFAULT 0,
    ModelYear int NOT NULL,
    Make varchar(255) NOT NULL,
    Model varchar(255) NOT NULL,
    LicensePlate varchar(15) UNIQUE,
    FuelType varchar(25),
    DatePurchased DATE,
    StateRegistered CHAR(2),
    Cost DECIMAL(65, 2),
    CHECK (Cost>=0),
    CHECK (ModelYear>=1900 AND ModelYear<=2100 ),
    Primary Key (CarID) #you can put multiple values into primary key to make a composite key, a key with multiple columns if one doesnt have uniqueness
);
Select * From usa_company_cars;



#Insert usa_company_cars all columns Data - rerun after drop or delete
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES 
(1, 1076, 2008, "Ford","F250","RTW-8888","Diesel", "2012-05-11","CA",40992.88),
(1, 1056, 2015, "Tesla","Model S","GGF-1193","Electric", "2016-02-08","CA",80052.31),
(1, 1166, 2007, "Honda","Civic","YHT-6402","Gas", "2008-11-11","CA",20000.99),
(2, 1216, 2010, "Ford","F150","VBN-5544","Gas", "2016-07-07","MA",10112.50),
(2, 1188, 2011, "Dodge","Caravan","JJK-7764","Gas", "2011-08-22","MA",21800.99),
(3, 1323, 2012, "Honda","Civic","GQD-0043","Hybrid", "2010-06-13","NJ",20200.70),
(3, 1286, 2008, "Toyota","Prius","VDH-4446","Hybrid", "2010-07-01","NY",25212.34),
(0, 7567, 2020, "Chevrolet","Spark","EEF-9067","Gas", "2021-09-20","TX",16244.94);

#Display Primary Driver Default value example - rerun after drop or delete
INSERT INTO usa_company_cars (AssignedOfficeID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (9, 2000, "Ford","F250","HGV-5324","Diesel", "2004-12-14","MN",25212.34),
(3, 2002, "Ford","Crown Victoria","HYB-5112","Gas", "2003-04-19","NY",15993.67),
(9, 2004, "GMC","Sierra","FDL-5333","Gas", "2006-11-29","MN",28050.01);

#Display Assigned Office Default value example - rerun after drop or delete
INSERT INTO usa_company_cars (PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES 
(1002, 2020, "Ford","Raptor","TGV-6327","Gas", "2020-02-20","CA",75065.10);

#Data type violation examples

#State over limit of 2 characters
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, 2000, "Make","Model","XXX-0000","Gas", "2000-01-01","TXX",10000.00);

#String in integar
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, "two thousand", "Make","Model","XXX-0000","Gas", "2000-01-01","TXX",10000.00);

#Testing constraints examples

#Not Null Examples

#Model Year
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, null, "Make","Model","XXX-0000","Gas", "2000-01-01","TX",10000.00);
#Assigned Office
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, 2000, null,"Model","XXX-0000","Gas", "2000-01-01","TX",10000.00);
#Primary Driver
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, 2000, "Make",null,"XXX-0000","Gas", "2000-01-01","TX",10000.00);

#Unique constraint example

#Same license plate as Toyota Prius in existing table
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, 2000, "Make","Model","VDH-4446","Gas", "2000-01-01","TX",10000.00);

#Check Constraint examples

#negative Cost
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, 2000, "Make","Model","XXX-0000","Gas", "2000-01-01","TX",-10000.00);

#Year under 1900
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, 1776, "Make","Model","XXX-0000","Gas", "2000-01-01","TX",10000.00);

#Year Over 2100
INSERT INTO usa_company_cars (AssignedOfficeID, PrimaryDriverID, ModelYear, Make, Model, LicensePlate, FuelType, DatePurchased, StateRegistered, Cost)
VALUES (0, 0, 5000, "Make","Model","XXX-0000","Gas", "2000-01-01","TX",10000.00);


#Creating another table office_type with foreign key
CREATE TABLE office_type (
    OfficeID varchar(10) unique, #cannot be int since the key it is referring to is varchar(10)
    BuildingSize varchar(255),
    BuildingType varchar(255),
    PrimaryLanguage varchar(255),
	FOREIGN KEY (OfficeID) REFERENCES offices(officeCode)
);


#Insert Office type Data
INSERT INTO office_type (OfficeID,BuildingSize,BuildingType,PrimaryLanguage)
Values(1,"Large","Skyscraper","English"),
(2,"Medium","One story building","English"),
(3,"Small","Shared space skyscraper","English"),
(5,"Large","Skyscraper","Japanese"),
(7,"Medium","Skyscraper one floor","English"),
(9,"Small","Small bulding with yard","English");

Select * From office_type;

#Foreign key constraint test
INSERT INTO office_type (OfficeID,BuildingSize,BuildingType,PrimaryLanguage)
Values(10,"Large","Skyscraper","English");

#Deleting
Select * from usa_company_cars;

DELETE FROM usa_company_cars WHERE FuelType = 'Gas';
Select * from usa_company_cars;


TRUNCATE TABLE usa_company_cars;
Select * from usa_company_cars;

DROP TABLE usa_company_cars;
Select * from usa_company_cars;
#re-run create table and inserts for further examples 

#To show changes and verify tables are correct for next section
SELECT * FROM usa_company_cars;
SELECT * FROM office_type;