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

#some test data
INSERT INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (0,"N/A","N/A","N/A","N/A","N/A","N/A", "Remote" ,"USA");

INSERT INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (9,"435-647-7654","1435 Bart ST","Office 36","MN","94324","USA", "St. Paul" ,"USA");

INSERT INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (7567,"Worker", "Remote" ,"x3643", "remotework@gmail.com",0,1143,"Sales Rep");

#Top 3 Sales reps by amount
Select concat(e.firstName , ' ' , e.lastName) as 'Name of Employee' ,
concat('$',format(sum(amount),2)) as 'Total Sales' from employees e
Inner Join customers c on e.employeeNumber = c.salesRepEmployeeNumber
Inner Join payments using (customerNumber)
group by e.employeeNumber
order by sum(amount)
desc limit 3;

#Employees who work remotely (office code 0)
Select concat(firstName, ' ', lastName) as 'Name', officeCode, city from employees
Left Join offices using (officeCode)
where officeCode =0;

#Top 2 employees by total sales booked
Select concat(employees.firstName, ' ',employees.lastName) as 'Full Name',
concat('$', format(sum(orderdetails.quantityOrdered*orderdetails.priceEach),2))
as "Total Sales Booked" from employees
inner join customers on (employeeNumber = salesRepEmployeeNumber)
inner join orders on (orders.customerNumber = customers.customerNumber)
inner join orderdetails on (orders.orderNumber = orderdetails.orderNumber)
group by employeeNumber
order by (sum(orderdetails.quantityOrdered*orderdetails.priceEach)) desc
limit 2;

#Top 3 locations with most employees
Select city, count(*) as '# of employees' from employees employees
inner join offices using (officeCode)
group by city
order by count(*) desc
limit 3;

#Employees with no office and office with no employees
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

#Top 2 products by amount
Select productName as "Product",
concat("$",format(sum(quantityOrdered*priceEach),2)) as "Total Sales"
from products
inner join orderDetails using (productCode)
group by productCode
order by sum(quantityOrdered*priceEach) desc
limit 2;
