#function questions

#Use in built MySql functions to display how many years ago a classicmodels order was shipped (shipped date) as "Years Ago". 
#Only count orders that are "shipped" status and order by Years Ago oldest to newest. 
#Inlcude order number and customer number. Hint: look at Age example

select orderNumber, customerNumber,TIMESTAMPDIFF(YEAR,shippedDate , CURDATE()) AS "Years Ago" 
from orders where status="Shipped" Order By TIMESTAMPDIFF(YEAR,shippedDate , CURDATE()) desc;

#Use in built MySql functions to query from the classicmodels payments table with four columns.
# One being unchanged amount column, amount rounded up, amount rounded down, and amount in pesos. 
#Use 1 dollar = 20.63 pesos, make sure this is formatted to two decimals. Inlcude aliases

Select amount as "Amount in $",CEILING(amount) as "Amount Rounded Up",Floor(amount) as "Amount Rounded Down", format((amount*20.63),2) as "Amount in Pesos" from payments; 

#Create a custom function to display profit return ratings (returnRating(MSRP,buyPrice)) for classic models products using MSRP minus buyPrice for profit margin. 
#Use this function to display this profit margin price amount, product name, and output rating from the function on the same table.
# 0 to 25 as Very Low Return
# 25+ to 50 as Low Return
# 50+ to 75 as Medium Return
# 75+ to 100 as High Return
# 100+ as Very High Return

Select max(buyPrice),min(buyPrice),max(MSRP),min(MSRP),max(MSRP-buyPrice),min(MSRP-buyPrice) from products;

DELIMITER $$

CREATE FUNCTION returnRating(
	msrp DECIMAL(10,2),
    buyprice DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE returnRating VARCHAR(20);
	DECLARE margin DECIMAL(10,2);
   SET margin = msrp - buyprice;
    IF margin > 100 THEN
		SET returnRating = 'Very High Return';
    ELSEIF (margin > 75 AND 
			margin <= 100) THEN
        SET returnRating = 'High Return';
         ELSEIF (margin > 50 AND 
			margin <= 75) THEN
        SET returnRating = 'Medium Return';
         ELSEIF (margin > 25 AND 
			margin <= 50) THEN
        SET returnRating = 'Low Return';
    ELSEIF margin <= 25 THEN
        SET returnRating = 'Very Low Return';
    END IF;

	RETURN (returnRating);
END$$
DELIMITER ;

Select productName,(MSRP-buyPrice),returnRating(MSRP,buyPrice) from products;

#Create two views, one as ratings_view and the other as productline_view
#ratings_view should have three columns, 
#the return rating from the function created previously, number of products (count), and average profit margin(avg of msrp-buyprice) with corresponding aliases
#this should be grouped by the return rating function and ordered by the average profit margin in descending order.
#productline_view should be similar to ratings view, except you will replace the return rating column with productline abd group by productline.

CREATE VIEW ratings_view AS
Select returnRating(MSRP,buyPrice) as "Return Rating", 
count(productName) as "Number of Products",
avg(MSRP-buyPrice) as "Average Profit Margin" 
from products 
group by returnRating(MSRP,buyPrice) 
order by avg(MSRP-buyPrice) desc;

Select * From ratings_view;

CREATE VIEW productline_view AS
Select productLine as "Product Line", 
count(productName) as "Number of Products",
avg(MSRP-buyPrice) as "Average Profit Margin" 
from products 
group by productLine
order by avg(MSRP-buyPrice) desc;

Select * From productline_view;

#Create a simple procedure that will return a table that returns a left join of employees and offices.
#This table should only have employees whose job title is sales rep and be ordered by officecode
#the procedure can be called GetEmpOfficeRep()

DELIMITER $$

CREATE PROCEDURE GetEmpOfficeRep()
BEGIN

	SELECT * FROM employees e
LEFT JOIN offices using (officeCode) 
where jobTitle = "Sales Rep" 
Order by officeCode;    

END$$

DELIMITER ;

CALL GetEmpOfficeRep();

#Create a procedure with cursor to create a list of the different office cities in offices table with commas between.
#Exclude the remote office with city as remote.
#The out put should look like this: St. Paul, London, Sydney, Tokyo, Paris, NYC, Boston, San Francisco,
#This output will come when something like these queries are run:
# SET @cityList = ""; 
# CALL createOfficeCityList(@cityList); 
# SELECT @cityList;


DELIMITER $$
CREATE PROCEDURE createOfficeCityList (
	INOUT cityList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE cities varchar(100) DEFAULT "";

	-- declare cursor
	DECLARE curCity 
		CURSOR FOR 
			SELECT city FROM offices where not city="Remote";

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curCity;

	getCity: LOOP
		FETCH curCity INTO cities;
		IF finished = 1 THEN 
			LEAVE getCity;
		END IF;
		-- build city list
		SET cityList = CONCAT(cities,", ",cityList);
	END LOOP getCity;
	CLOSE curCity;

END$$
DELIMITER ;

SET @cityList = ""; 
CALL createOfficeCityList(@cityList); 
SELECT @cityList;