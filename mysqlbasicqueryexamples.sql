#basic queries using database_sample

#Select Examples
Select * from people;
Select FirstName from people;
Select FirstName, LastName from people;
Select concat(FirstName," ", LastName) from people;
Select concat(FirstName," ", LastName) as "Full Name" from people;
Select concat(FirstName," ", LastName) as "Full Name", Balance from people where Balance > 500;

#Conditions Examples
Select * from people where State="TX" or State="CA";
Select * from people where State="TX" and Balance > 500;
Select * from people where NOT State="TX";
Select * from people where Balance between 700 and 2000;
Select * from people where State IN ("MN","NY","WA");
Select FirstName from people WHERE FirstName LIKE 'P%';
Select FirstName from people WHERE FirstName LIKE '%e';
Select FirstName from people WHERE FirstName LIKE '____y';
Select FirstName from people WHERE FirstName LIKE '%e_e%';
Select * from people where State IS NULL;
Select * from people where PersonID IN (SELECT PersonID FROM Employee);

#Sorting Examples
Select * from people order by Balance;
Select * from people order by Balance desc;
Select * from people order by LastName limit 3;
Select * from people order by LastName desc limit 3;

#Aggregate Functions
Select sum(balance) from people;
Select count(PersonID) from people where State = "TX";
Select avg(balance) as "Balance Average", max(balance) as "Top Balance", min(balance) as "Lowest Balance" from people;
Select STD(balance) as "Standard Deviation", Variance(balance) as "Variance" from people;

#Group By Examples
Select state,count(PersonID) from people group by State;
Select state,sum(balance) from people group by State;
SELECT COUNT(PersonID) as "Number of People", State FROM people GROUP BY State ORDER BY COUNT(PersonID) DESC Limit 3;



