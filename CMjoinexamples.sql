#Simple Join Examples using classic models and added tables

#Left Join
SELECT * FROM employees
Left JOIN usa_company_cars ON employees.employeeNumber = usa_company_cars.PrimaryDriverID;

#Right Join
SELECT * FROM employees
JOIN usa_company_cars ON employees.employeeNumber = usa_company_cars.PrimaryDriverID;

#Full Join
SELECT * FROM employees
LEFT JOIN usa_company_cars ON employees.employeeNumber = usa_company_cars.PrimaryDriverID
UNION
SELECT * FROM employees
RIGHT JOIN usa_company_cars ON employees.employeeNumber = usa_company_cars.PrimaryDriverID;

#Inner Join
SELECT * FROM employees
INNER JOIN usa_company_cars ON employees.employeeNumber = usa_company_cars.PrimaryDriverID;

#Cross Join
SELECT * FROM employees CROSS JOIN usa_company_cars;

#Self Join
SELECT A.firstName AS firstName1, A.employeeNumber AS employeeNumber1, 
B.firstName AS Manager, B.employeeNumber AS employeeNumber2, A.reportsTo
FROM employees A, employees B
WHERE A.reportsTo = B.employeeNumber
ORDER BY A.officeCode;


#Double Inner Join
Select concat(e.firstName , ' ' , e.lastName) as 'Employee Name' , customerName,
sum(amount) as "Total Amount Payed Revenue" from employees e
Inner Join customers c on e.employeeNumber = c.salesRepEmployeeNumber
Inner Join payments using (customerNumber)
group by c.customerName
order by e.employeeNumber;

#Double Inner Join without customer
Select concat(e.firstName , ' ' , e.lastName) as "Full name",
sum(amount) as "Total Amount Payed Revenue" from employees e
Inner Join customers c on e.employeeNumber = c.salesRepEmployeeNumber
Inner Join payments using (customerNumber)
group by e.employeeNumber
order by e.employeeNumber;
