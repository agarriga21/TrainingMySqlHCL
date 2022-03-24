#Function Examples using classicmodels

#Built in functions

#String Functions 
Select firstName, Length(firstName) from employees;
Select firstName, UCASE(firstName) from employees;
Select firstName, LCASE(firstName) from employees;
Select firstName, LOCATE("an",firstName) from employees; 

#Numeric Functions
Select MSRP, CEILING(MSRP) from products;
Select MSRP, FLOOR(MSRP) from products;
Select SUM(MSRP), SQRT(SUM(MSRP)) as "Square Root of the MSRP Sum" from products;
Select MSRP, RAND() as "Random Decimal" from products; 
Select MSRP, CEILING(RAND()*(300-30)+30)+.99 as "Random .99 Price between 30 and 300" from products; 

#Date Functions
Select DatePurchased, DAYNAME(DatePurchased) from usa_company_cars;
Select DatePurchased, YEAR(DatePurchased) from usa_company_cars;
Select DatePurchased, DATE_FORMAT(DatePurchased, "%M %d %Y") from usa_company_cars;
Select CURRENT_TIMESTAMP();
Select DatePurchased,CURRENT_DATE(),TIMESTAMPDIFF(YEAR, DatePurchased, CURDATE()) AS "Years Owned" from usa_company_cars;

#Advanced Functions
SELECT customerName, creditLimit, IF(creditLimit<=0, "No", "Yes") as "Credit Available" from customers;
SELECT customerName, creditLimit,
CASE
    WHEN creditLimit >= 100000 THEN "They have a high credit limit"
    WHEN creditLimit < 100000 AND creditLimit >0 THEN "They have a medium credit limit"
    ELSE "No credit available"
END
 as "Credit Description"
FROM customers;

#Custom Function using Classicmodels

DELIMITER $$

CREATE FUNCTION CustomerLevel(
	credit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
        ELSE
        SET customerLevel = 'BRONZE';
    END IF;
	-- return the customer level
	RETURN (customerLevel);
END$$
DELIMITER ;

#see if function is in db
SHOW FUNCTION STATUS 
WHERE db = 'classicmodels';

#Testing new function
SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;