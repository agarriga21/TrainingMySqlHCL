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
INSERT IGNORE INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (0,"N/A","N/A","N/A","N/A","N/A","N/A", "Remote" ,"USA");

INSERT IGNORE INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (9,"435-647-7654","1435 Bart ST","Office 36","MN","94324","USA", "St Paul" ,"USA"),
(10,"435-647-7654","1435 Test ST","Office 5","TX","75036","USA", "Frisco" ,"USA");

INSERT IGNORE INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (7567,"Worker", "Remote" ,"x3643", "remotework@gmail.com",0,1143,"Sales Rep"),
(7568,"Jenkins", "Ralph" ,"x3633", "Theralphster@gmail.com",0,1143,"Sales Rep");

#Select the newly added St. Paul office with officecode, phone number, and city
Select officeCode, phone, city from offices where officeCode = 9;

#Top 10 highest MSRP products with columns productName, productLine, buyPrice, MSRP.
Select productName, productLine, buyPrice, MSRP from products
order by MSRP desc
Limit 10;

#Select the newly added remote workers and display these employees id, last name, email, and job. 
#Also include a join to display these employees office code, city, and country
Select employeeNumber, lastName, email, jobTitle, officeCode, city, country
from employees
inner join offices using (officeCode)
where officeCode = 0;

#Employees with remote office 0.
Select concat(firstName," ", lastName) as "Full Name" from employees where officeCode = 0;

#Offices with no employees. Include city and office code.
Select city, officeCode  from offices
Left Join employees using (officeCode)
group by officeCode, employeeNumber having count(employeeNumber) = 0;

#Employees with remote office and offices with no employees
Select concat(firstName, ' ', lastName) as 'Full Name', city,officeCode from employees
Left Join offices using (officeCode)
where officeCode =0
union
Select concat(firstName, ' ', lastName) as 'Full Name', city,officeCode from offices
Left Join employees using (officeCode)
group by officeCode, employeeNumber having count(employeeNumber) = 0;

#Write a query to display the amount of employees per country with columns country and number of employees.
#Order by number of employees with the highest values first (use group by and aggregate functions and a join)
Select country, count(employeeNumber) '# of employees' from offices
inner join employees using (officeCode)
group by country
order by count(employeeNumber) desc;

#Top 3 office locations (by city) with most employees. Include columns city and count of employees.
Select city, count(*) as '# of employees' from employees employees
inner join offices using (officeCode)
group by city,officeCode
order by count(*) desc
limit 3;

#Find the top 10 products ordered and the revenue they have generated. Include columns product name, product code, total quantity ordered, and total revenue from orders.
#Hint: The revenue per order can be found by multiplying quatnity ordered by the price each. Use a groupby to get specific info on each product.
Select productName, products.productCode, sum(orderdetails.quantityOrdered) as "Total Ordered", concat('$',format(sum(orderdetails.quantityOrdered*priceEach),2)) as "Total Revenue" from products
inner join orderdetails on (products.productCode = orderdetails.productCode)
group by productName
order by sum(orderdetails.quantityOrdered) desc
limit 10;

#Top 3 product lines by total revenue (quantity ordered times the price)
Select productline, concat('$', format(sum(quantityOrdered*priceEach),2)) as "Sum"
from products
inner join orderdetails using (productCode)
group by productLine
order by sum(quantityOrdered*priceEach) desc
limit 3;


#Top 5 customers by purchase (payment) amount include full name and total money spent in correct format
Select customers.customerNumber, concat(contactFirstName, ' ',contactLastName) as 'Customer Name',
concat("$", format(sum(amount), 2)) as "Total Spent" from customers
inner join payments
on customers.customerNumber = payments.customerNumber
group by customerNumber order by sum(amount) desc limit 5;

#Customers with no purchases in our DB with location information. (Columns full customer name, Location as country,city and # of payments. Order by country and city)
Select concat(contactFirstName, ' ',contactLastName) as 'Customer',
concat(country, ", ", city) as "Location",
count(checkNumber) as '# of payments' from customers
left join payments using (customerNumber)
group by customerNumber having count(checkNumber) = 0
order by country, city asc;

#Number of products ordered and their order status, include columns product, total ordered, and status. Hint: use a double groupby
Select productName as "Product",
sum(quantityOrdered) as "Total",
status as "Status" from products
inner join orderDetails using (productCode)
inner join orders using (orderNumber)
where orderDetails.productCode = products.productCode
group by orderDetails.productCode, status
order by productName asc, status desc;

#Find the top 3 Sales reps by revenue (total payments from customers). Have columns full employee name, total revenue (sum of amount in $) with dollar format.
#Hint: Find a way to connect employees to payments table to calculate sum of payment amount per employee.
Select concat(e.firstName , ' ' , e.lastName) as 'Name of Employee' ,
concat('$',format(sum(amount),2)) as 'Total Sales' from employees e
Inner Join customers c on e.employeeNumber = c.salesRepEmployeeNumber
Inner Join payments using (customerNumber)
group by e.employeeNumber
order by sum(amount)
desc limit 3;

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