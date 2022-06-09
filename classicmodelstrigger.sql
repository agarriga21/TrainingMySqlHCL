#trigger example using classicmodels

#Create testing table where trigger will add new row
CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);
Select * From employees_audit;

#Create Trigger update
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();

#Create Trigger insert
CREATE TRIGGER after_employee_insert
    AFTER INSERT ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'insert',
     employeeNumber = NEW.employeeNumber,
     lastname = NEW.lastname,
     changedat = NOW();
     
     #Create Trigger delete
CREATE TRIGGER before_employee_delete 
    BEFORE DELETE ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'delete',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();

#display trigger
SHOW TRIGGERS;

#Trigger the update trigger
UPDATE employees 
SET 
    lastName = 'Gonzales'
WHERE
    employeeNumber = 1056;
    
    #Verify update trigger worked
    SELECT * FROM employees_audit;
   Select * from employees;
   
   #Trigger the insert trigger
insert into employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) 
values
(3555, "Griffin", "Peter", "x7777", "pg@gmail.com", 1, 1002, "Janitor");

#Verify insert trigger worked
    SELECT * FROM employees_audit;
    Select * from employees;
    
    #Trigger the delete trigger
    Delete from employees where employeeNumber = 3555;

#Verify delete trigger worked
    SELECT * FROM employees_audit;
    
   Select * from employees;

    