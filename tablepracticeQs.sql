select * from employees;
#Table Creation practice
#Create a table named employeedetails
#This table will have a foriegn key to employee table, yearly salary, type of employment (full-time, part-time), and gender
#Use contraints for salary and employment type
#Make sure employeeID is unique
Drop table employeedetails;
CREATE TABLE employeedetails (
    empID int unique,
    salary Decimal(65,2) Not Null,
    employmentType varchar(255) NOT NULL,
    gender varchar(10),
    CHECK(salary>=0),
    CHECK(employmentType IN("full-time","part-time","contract")),
	FOREIGN KEY (empID) REFERENCES employees(employeenumber)
);

#Insert 5 rows into the employeedetails table previously created
#Remember that they must reference employees from the employee table

Insert into employeedetails(empID,salary,employmentType,gender)
Values
(1056,150000.00,"Full-time","female"),
(1088,128000.00,"full-time","male"),
(1165,80000,"full-time","female"),
(1166,45000,"part-time","female"),
(1611,100000,"contract","male");

select*from employeedetails;

#Part 2

#Using update commands, give the full-time employees a raise of 5% and part time a raise of 3%
#Hint, you can use math and parenthesis in the SET command

#full-time
UPDATE employeedetails SET salary = (salary+salary*.05) WHERE employmentType ="full-time";
#part-time
UPDATE employeedetails SET salary = (salary+salary*.03) WHERE employmentType ="part-time";

#Using alter commands, change the datatype of salary to Decimal(8,2) and employmentType to Varchar(14)
#make sure to include contraints other than check contraints here

Alter Table employeedetails
Modify Column salary Decimal(8,2) NOT NULL;

Alter Table employeedetails
Modify Column employmentType Varchar(14) NOT NULL;

#Using alter command, add a column weeklyhours with datatype int. Update all full-time employees to 40 hours

Alter table employeedetails
Add weeklyHours int;

UPDATE employeedetails SET weeklyHours = 40 WHERE employmentType ="full-time";

#Using Alter, delete the gender column from the table
Alter table employeedetails
Drop gender;

#Delete a row (1 employee) from the table
delete from employeedetails where empID=1621;