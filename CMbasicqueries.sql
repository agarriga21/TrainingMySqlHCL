#basic queries using classic models

#Select Examples
Select * from customers;
Select contactFirstName from customers;
Select contactFirstName, contactLastName from customers;
Select concat(contactFirstName," ", contactLastName) from customers;
Select concat(contactFirstName," ", contactLastName) as "Full Name" from customers;
Select concat(contactFirstName," ", contactLastName) as "Full Name", creditLimit from customers where creditLimit > 100000;
Select CONCAT_WS(" ",ModelYear,Make,Model) as "Vehicle", Cost from usa_company_cars where Cost > 20000;

#Conditions Examples
Select * from employees;
Select * from employees where officeCode=1 or officeCode=4;
Select * from employees where officeCode=1 and jobTitle = "Sales Rep";
Select * from employees where NOT jobTitle = "Sales Rep";
Select * from employees where officeCode between 2 and 5;
Select * from employees where firstName between "a" and "d";
Select * from employees where reportsTo IN (1002,1056,1102);
Select firstName from employees WHERE firstName LIKE 'P%';
Select firstName from employees WHERE firstName LIKE '%e';
Select firstName from employees WHERE firstName LIKE '____y';
Select firstName from employees WHERE firstName LIKE '%e_e%';
Select * from employees where reportsTo IS NULL;
Select * from employees where employeeNumber IN (Select salesRepEmployeeNumber From customers);

Select CONCAT_WS(" ",ModelYear,Make,Model) as "Vehicle",PrimaryDriverID,FuelType, Cost 
from usa_company_cars 
where PrimaryDriverID IN (Select employeeNumber From employees) 
AND (FuelType IN ("Diesel","Hybrid","Electric") OR Cost<21000);

#Sorting Examples
Select * from payments order by amount;
Select * from payments order by amount desc;
Select * from employees order by lastName limit 5;
Select * from employees order by lastName desc limit 5;

Select CONCAT_WS(" ",ModelYear,Make,Model) as "Vehicle",PrimaryDriverID,FuelType, Cost 
from usa_company_cars 
order by Make,
FuelType desc,
Cost desc
limit 10;

#Aggregate Functions
Select sum(amount) from payments;
Select count(employeeNumber) from employees where officeCode = 1;
Select STD(creditLimit) as "Standard Deviation", Variance(creditLimit) as "Variance" from customers;
Select concat('$',format(avg(amount),2)) as "Payment Average", concat('$',max(amount)) as "Highest Payment", concat('$',min(amount)) as "Lowest Payment" from payments;



#Group By Examples
Select officeCode,count(employeeNumber) from employees group by officeCode;

Select country,count(customerNumber) as "Customer Amount" from customers group by country;

Select customerNumber ,sum(amount) as "Total Payment Amount" from payments 
group by customerNumber 
order by sum(amount) desc
LIMIT 10;

#Double group by
Select country, state, count(customerNumber) as "Number of Customers" from customers 
group by country,state 
order by country,count(customerNumber) 
desc;

#same as previous with added having and no limit
Select customerNumber ,sum(amount) as "Total Payment Amount" from payments 
group by customerNumber 
Having sum(amount)> 150000
order by sum(amount) desc;

Select * from products;
SELECT productLine, count(productCode) as "Amount of Products",
concat('$',Sum(quantityInStock*buyPrice)) as "Total Buy Price",
concat('$',Sum(quantityInStock*MSRP)) as "Total Sale Price" FROM products 
GROUP BY productLine 
ORDER BY Sum(quantityInStock*buyPrice) DESC;

#same as previous with added having
SELECT productLine, count(productCode) as "Amount of Products",
concat('$',Sum(quantityInStock*buyPrice)) as "Total Buy Price",
concat('$',Sum(quantityInStock*MSRP)) as "Total Sale Price" FROM products 
GROUP BY productLine 
Having count(productCode) < 20
ORDER BY Sum(quantityInStock*buyPrice) DESC;
