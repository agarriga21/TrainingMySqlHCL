#complex queries with classicmodels

#Employee Evaluation

#Viewing tables in the db
select * from employees;
select * from offices;
select * from customers;
select * from orders;
select * from orderdetails;
select * from payments;
select * from productlines;
select * from products;

#some test data if not already added
#Remote Office
INSERT INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (0,"N/A","N/A","N/A","N/A","N/A","N/A", "Remote" ,"USA");
#St. Paul Office
INSERT INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (9,"435-647-7654","1435 Bart ST","Office 36","MN","94324","USA", "St. Paul" ,"USA");
#Remote workers
INSERT INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (7567,"Worker", "Remote" ,"x3643", "remotework@gmail.com",0,1143,"Sales Rep"),
(7568,"Jenkins", "Ralph" ,"x3633", "Theralphster@gmail.com",0,1143,"Sales Rep");

#Select the newly added St. Paul office with officecode, phone number, and city
Select officeCode, phone, city from offices where officeCode = 9;

#Select the newly added remote workers and display these employees id, last name, email, and job. 
#Also include a join to display these employees office code, city, and country
Select employeeNumber, lastName, email, jobTitle, officeCode, city, country
from employees
inner join offices using (officeCode)
where officeCode = 0;

#Write a query to display the amount of employees per country with columns country and number of employees.
#Order by number of employees with the highest values first (use group by and aggregate functions and a join)
Select country, count(employeeNumber) from offices
inner join employees using (officeCode)
group by country
order by count(employeeNumber) desc;

#Top 3 office locations (by city) with most employees. Include columns city and count of employees.
Select city, count(*) as '# of employees' from employees employees
inner join offices using (officeCode)
group by city,officeCode
order by count(*) desc
limit 3;

#Find the top 3 Sales reps by revenue (total payments from customers). Have columns full employee name, total revenue (sum of amount in $) with dollar format.
#Hint: Find a way to connect employees to payments table to calculate sum of payment amount per employee.
Select concat(e.firstName , ' ' , e.lastName) as 'Name of Employee' ,
concat('$',format(sum(amount),2)) as 'Total Sales' from employees e
Inner Join customers c on e.employeeNumber = c.salesRepEmployeeNumber
Inner Join payments using (customerNumber)
group by e.employeeNumber
order by sum(amount)
desc limit 3;

#Find the top 10 products ordered and the revenue they have generated. Include columns product name, product code, total quantity ordered, and total revenue from orders.
#Hint: The revenue per order can be found by multiplying quatnity ordered by the price each. Use a groupby to get specific info on each product.
Select productName, products.productCode, sum(orderdetails.quantityOrdered) as "Total Ordered", concat('$',format(sum(orderdetails.quantityOrdered*priceEach),2)) as "Total Revenue" from products
inner join orderdetails on (products.productCode = orderdetails.productCode)
group by productName
order by sum(orderdetails.quantityOrdered) desc
limit 10;

#Find the top 5 employees by total quantity of products sold. Include columns employees full name and totl products sold.
#Hint: Order details will have quantity ordered for products. Use this with multiple joins and a group by to find total products sold by specific employees.
Select concat(employees.firstName, ' ',employees.lastName) as 'Full Name',
sum(orderdetails.quantityOrdered)
as "Total Products Sold" from employees
inner join customers on (employeeNumber = salesRepEmployeeNumber)
inner join orders on (orders.customerNumber = customers.customerNumber)
inner join orderdetails on (orders.orderNumber = orderdetails.orderNumber)
group by employeeNumber
order by sum(orderdetails.quantityOrdered) desc
limit 5;



#Employees with remote office and offices with no employees
Select concat(firstName, ' ', lastName) as 'Employee', city,officeCode from employees
Left Join offices using (officeCode)
group by officeCode, employeeNumber having officeCode =0
union
Select concat(firstName, ' ', lastName) as 'Employee', city,officeCode from employees
Right Join offices using (officeCode)
group by officeCode, employeeNumber having count(employeeNumber) = 0;

#Top 3 product lines
Select productline, concat('$', format(sum(quantityOrdered*priceEach),2)) as "Sum"
from products
inner join orderdetails using (productCode)
group by productLine
order by sum(quantityOrdered*priceEach) desc
limit 3;

#Top 3 customers by purchase amount
Select customers.customerNumber, concat(contactFirstName, ' ',contactLastName) as 'Customer Name',
concat("$", format(sum(amount), 2)) as "Total Spent" from customers
inner join payments
on customers.customerNumber = payments.customerNumber
group by customerNumber order by sum(amount) desc limit 3;

#Customers with no purchases in our DB by location
Select concat(country, ", ", city) as "Location",
concat(contactFirstName, ' ',contactLastName) as 'Customer',
count(checkNumber) as '# of payments' from customers
left join payments using (customerNumber)
group by country, customerNumber having count(checkNumber) = 0
order by country, city asc;

#Number of product orders and their status
Select productName as "Product",
sum(quantityOrdered) as "Total",
status as "Status" from products
inner join orderDetails using (productCode)
inner join orders using (orderNumber)
where orderDetails.productCode = products.productCode
group by orderDetails.productCode, status
order by productName asc, status desc;

