#Creating the Database database_sample

#Drop Database database_sample;
CREATE DATABASE database_sample;

#Table Creating
CREATE TABLE People (
    PersonID int AUTO_INCREMENT,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) DEFAULT 'Get First Name',
    DOB DATE,
    State CHAR(2),
    Balance DECIMAL(65, 2),
    Primary Key (PersonID)
);
CREATE TABLE Employee (
    EMPID int,
    PersonID int UNIQUE,
    ManagerID int,
    Job varchar(255),
    Summary varchar(255),
    HireDate DATE,
    Salary DECIMAL(65, 2),
    PRIMARY KEY (EMPID),
    CHECK (Salary>=0)
    #,FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);
#Insert People Data
INSERT INTO People (FirstName,LastName,DOB,State,Balance)
VALUES ("Sam", "Rett", "1955-12-14","TX",212.34),
("Peter", "Jon", "1989-04-01","TX",12546.32),
("Dan", "Jones", "2001-09-28","WA",26.78),
("Andrew", "Shaw", "1999-05-12","CA",0.99),
("Mike", "Pope", "1946-10-10","WA",2.65),
("Braden", "Hall", "1995-12-01","TX",52196.88),
("Kelly", "Gibbs", "1980-03-09","OK",705.09),
("Stacy", "Robinson", "1967-06-19","CA",1006.16),
("Patty", "Gary", "1942-11-29","NY",175.25),
("Rish", "Kol", "1991-01-01","MN",121454.77),
("Pete", "Law", null,"NM",175.25),
("Bart", "Smith", "1922-04-21",null,null);

#Display Default and NOT NULL example
INSERT INTO People (LastName,DOB,State,Balance)
VALUES ( "Grey", "1945-02-24","WI",416.01);

INSERT INTO People (FirstName,LastName,DOB,State,Balance)
VALUES ( "test",null, "0000-00-00","XX",0);

#Insert Employee Data
INSERT INTO Employee (EMPID,PersonID,ManagerID,HireDate,Job,Summary,Salary)
VALUES (4235, 2,null, "2000-10-01","Janitor","Cleans well",30000.00),
(6685, 5,5235, "2010-05-01","Sales Rep",null,50000.00),
(8933, 10,4235, "2017-12-01","Janitor","Leaves messes",20000.00),
(7543, 1,null, "2015-11-01","Chef","Food needs work",55000.00),
(8009, 8,null, "2016-11-01","IT","Diligent",80000.00),
(9865, 9,null, "2020-01-01","Trainer","Teaches well",40000.00),
(12474, 15,7543, "2021-03-01","Chef","New",45000.00),
(13546, 16,8009, "2022-01-01","IT","New",50000.00),
(5235, 4,null, "2001-06-01","Sales Manager","Good teamwork",120000.00);

#Display Check and Unique example
INSERT INTO Employee (EMPID,PersonID,ManagerID,HireDate,Job,Summary,Salary)
VALUES (1000, 2 ,null, "2000-10-01","Janitor","Cleans well",30000.00);

INSERT INTO Employee (EMPID,PersonID,ManagerID,HireDate,Job,Summary,Salary)
VALUES (0, 0 ,null, "2000-10-01","Janitor","Cleans well",-1000);

#Deleting
DELETE FROM People WHERE State = 'TX';

TRUNCATE TABLE People;

DROP TABLE People;
#DROP TABLE Employee;

#To show Changes
SELECT * FROM People;
SELECT * FROM Employee;
