#Views and Triggers

#View Example
DROP VIEW custom_people_view;
CREATE VIEW custom_people_view AS
SELECT concat(FirstName," ", LastName) as "Full Name", 
TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age,
CASE
    WHEN Balance >= 20000 THEN "They have a high savings"
    WHEN Balance < 20000 AND Balance >=1000 THEN "They have a medium savings"
    ELSE "Low savings"
END as "Balance Description"
FROM people
WHERE Balance and DOB and FirstName IS NOT NULL;

#Trigger Example

CREATE TABLE new_person_join (
    id INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);
Select * From new_person_join;

CREATE TRIGGER after_people_insert 
    AFTER INSERT ON people
    FOR EACH ROW 
 INSERT INTO new_person_join
 SET action = 'insert',
     PersonID = NEW.PersonID,
     FirstName = NEW.FirstName,
    LastName = NEW.LastName,
     changedat = NOW();

SHOW TRIGGERS;

INSERT INTO People (FirstName,LastName,DOB,State,Balance)
VALUES ("Trigger", "Happy", "1999-12-25","MN",1000.34);

