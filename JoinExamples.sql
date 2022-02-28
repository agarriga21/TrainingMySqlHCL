#Simple Join Examples using database_sample

#Left Join
SELECT * FROM People
LEFT JOIN Employee ON People.PersonID = Employee.PersonID;

#Right Join
SELECT * FROM People
RIGHT JOIN Employee ON People.PersonID = Employee.PersonID;

#Full Join
SELECT * FROM People
LEFT JOIN Employee ON People.PersonID = Employee.PersonID
UNION
SELECT * FROM People
RIGHT JOIN Employee ON People.PersonID = Employee.PersonID;

#Inner Join
SELECT * FROM People
INNER JOIN Employee ON People.PersonID = Employee.PersonID;

#Cross Join
SELECT * FROM People CROSS JOIN Employee;

#Self Join
SELECT A.FirstName AS FirstName1, B.FirstName AS FirstName2, A.State
FROM People A, People B
WHERE A.PersonID <> B.PersonID
AND A.State = B.State
ORDER BY A.State;






