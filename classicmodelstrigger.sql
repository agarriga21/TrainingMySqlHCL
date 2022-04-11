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

#Create Trigger
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();

#display trigger
SHOW TRIGGERS;

#Trigger the trigger
UPDATE employees 
SET 
    lastName = 'John'
WHERE
    employeeNumber = 1056;
    
    #Verify trigger worked
    SELECT * FROM employees_audit;
    
    