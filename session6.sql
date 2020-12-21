
--EX1
USE AdventureWorks2014

SELECT * FROM Employee

--EX2
USE AdventureWorks2014
-- Employee table contains the details of an employee.
-- This statement retrieves all the rows of the table Employee.
SELECT * FROM Employee


--EX3
/* Employee table contains the details of an employee.
This statement retrieves all the rows of the table Employee. */
SELECT * FROM Employee

--EX4
CREATE TABLE Contacts
(MailID varchar(20),
Name text,
TelephoneNumber int)

--Snippet1
CREATE TABLE Class
{
RollNumber int PRIMARY KEY,
StudentName text)

--Snippet2
CREATE TABLE Class
{
RollNumber int NOT NULL,
StudentName text)

--Snippet5
ALTER TABLE Contacts ADD FaxNumber int

--Snippet6
DROP TABLE Contacts


--EX7
USE AdventureWorks2014
SELECT * Employee

--EX8
USE AdventureWorks2014
INSERT INTO Contacts
VALUES(‘john@abc.com’,’John’,5432677,5432678)

--EX9
UPDATE Contacts
SET TelephoneNumber = 5432679
WHERE Name LIKE ‘John’

--EX10
DELETE FROM Contacts
WHERE TelephoneNumber = 5432679

--EX11
CREATE TABLE NewEmployees (EmployeeID smallint,FirstName char(10),
LastName char(10), Department varchar(50), HiredDate datetime, Salary
money );
INSERT INTO NewEmployees
VALUES(11,’Kevin’,’Blaine’,’Research’,’2006-07-31 00:00:00.000’,54000);
WITH EmployeeTemp (EmployeeID,FirstName,LastName,Department,
HiredDate, Salary)
AS
(
SELECT * FROM NewEmployees
)
INSERT INTO Employee
SELECT * FROM EmployeeTemp

--EX12
GRANT SELECT
ON Employee
TO JOHN

--EX13
REVOKE SELECT
ON Employee
FROM JOHN

--EX14
DENY SELECT
ON Employee
TO JOHN

--EX15
SELECT * FROM Employee

--EX16
USE AdventureWorks2014
GO
SELECT * FROM Employee
GO

--EX17
DECLARE @PriceChangeDetails TABLE
(
HotelNumber int,
Price money,
NewPrice money
)
UPDATE Hotels
SET Price = 3000
OUTPUT INSERTED.HotelNumber,DELETED.Price, INSERTED.Price
INTO @PriceChangeDetails
WHERE HotelNumber = 101
SELECT * FROM @PriceChangeDetails
