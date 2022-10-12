#View Example using classicmodels

#Simple View example
CREATE VIEW custom_orderdetails_view AS
select orderNumber,quantityOrdered,priceEach,(quantityOrdered*priceEach) as "Total Price" from orderdetails;

#view view
Select * From custom_orderdetails_view
Order by `Total Price` desc;

#Complex View
CREATE VIEW custom_employee_view AS
SELECT CONCAT_WS(" ",jobTitle,firstName, lastName) as "Title and Name",
concat(city,", ", country) as Location, 
CONCAT_WS(" ",ModelYear,Make,Model) as "Vehicle",
CASE
    WHEN Cost >= 25000 THEN "High Cost Vehicle"
    WHEN Cost < 25000 AND Cost >=0 THEN "Low Cost Vehicle"
    ELSE "Not a primary driver"
END as "Company Car Value"
from employees
LEFT JOIN usa_company_cars ON employees.employeeNumber = usa_company_cars.PrimaryDriverID
Inner Join offices using (officeCode)
order by CarID
desc;

#view view
Select * From custom_employee_view;

Select * From custom_employee_view where `Company Car Value` ="High Cost Vehicle";


