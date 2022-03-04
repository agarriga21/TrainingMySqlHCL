#Built in Function Examples using database_sample db

#String Functions 
Select FirstName, Length(FirstName) from people;
Select FirstName, UCASE(FirstName) from people;
Select FirstName, LCASE(FirstName) from people;
Select FirstName, LOCATE("an",FirstName) from people; 

#Numeric Functions
Select balance, CEILING(balance) from people;
Select balance, FLOOR(balance) from people;
Select SUM(balance), SQRT(SUM(balance)) as "Square Root of the Balance Sum" from people;
Select balance, RAND() as "Random Decimal" from people; 
Select balance, Ceiling(RAND()*100) as "Random INT" from people; 

#Date Functions
Select DOB, DAYNAME(DOB) from people;
Select DOB, YEAR(DOB) from people;
Select DOB, DATE_FORMAT(DOB, "%M %d %Y") from people;
Select CURRENT_TIMESTAMP();
Select DOB,CURRENT_DATE(),TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age from people;

#Advanced Functions
SELECT FirstName, Balance, IF(balance<1000, "Low", "High") as "Balance Rating" from people;
SELECT FirstName, Balance,
CASE
    WHEN Balance >= 20000 THEN "They have a high savings"
    WHEN Balance < 20000 AND Balance >=1000 THEN "They have a medium savings"
    ELSE "Low savings"
END
 as "Balance Description"
FROM People;

#Custom Function database_sample
Drop Function EmployeeLevel;

DELIMITER $$

CREATE FUNCTION EmployeeLevel(
	Salary DECIMAL(65, 2)
) 
RETURNS VARCHAR(25)
DETERMINISTIC
BEGIN
    DECLARE employeeLevel VARCHAR(20);

    IF Salary > 100000 THEN
		SET employeeLevel = 'Level 4';
    ELSEIF (Salary <= 100000 AND 
			Salary >= 50000) THEN
        SET employeeLevel = 'Level 3';
        ELSEIF (Salary < 50000 AND 
			Salary >= 30000) THEN
        SET employeeLevel = 'Level 2';
    ELSEIF Salary < 30000 THEN
        SET employeeLevel = 'Level 1';
    END IF;
	-- return the employee level
	RETURN (employeeLevel);
END$$
DELIMITER ;

SHOW FUNCTION STATUS 
WHERE db = 'database_sample';

SELECT 
	EMPID,
    Job, 
    EmployeeLevel(Salary)
FROM
    employee;
    

