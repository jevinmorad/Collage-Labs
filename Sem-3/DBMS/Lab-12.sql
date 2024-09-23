CREATE TABLE Dept (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    DepartmentCode VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) NOT NULL
)

CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    PersonName VARCHAR(100) NOT NULL,
    DepartmentID INT NULL,
    Salary DECIMAL(8, 2) NOT NULL,
    JoiningDate DATETIME NOT NULL,
    City VARCHAR(100) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Dept(DepartmentID)
);

INSERT INTO Dept (DepartmentID, DepartmentName, DepartmentCode, Location) VALUES
(1, 'Admin', 'Adm', 'A-Block'),
(2, 'Computer', 'CE', 'C-Block'),
(3, 'Civil', 'CI', 'G-Block'),
(4, 'Electrical', 'EE', 'E-Block'),
(5, 'Mechanical', 'ME', 'B-Block');

INSERT INTO Person (PersonID, PersonName, DepartmentID, Salary, JoiningDate, City) VALUES
(101, 'Rahul Tripathi', 2, 56000, '2000-01-01', 'Rajkot'),
(102, 'Hardik Pandya', 3, 18000, '2001-09-25', 'Ahmedabad'),
(103, 'Bhavin Kanani', 4, 25000, '2000-05-14', 'Baroda'),
(104, 'Bhoomi Vaishnav', 1, 39000, '2005-02-08', 'Rajkot'),
(105, 'Rohit Topiya', 2, 17000, '2001-07-23', 'Jamnagar'),
(106, 'Priya Menpara', NULL, 9000, '2000-10-18', 'Ahmedabad'),
(107, 'Neha Sharma', 2, 34000, '2002-12-25', 'Rajkot'),
(108, 'Nayan Goswami', 3, 25000, '2001-07-01', 'Rajkot'),
(109, 'Mehul Bhundiya', 4, 13500, '2005-01-09', 'Baroda'),
(110, 'Mohit Maru', 5, 14000, '2000-05-25', 'Jamnagar');


--Part � A:
--1. Find all persons with their department name & code.
SELECT PersonName, Dept.DepartmentID, DepartmentCode from Person join Dept on Person.DepartmentId = Dept.DepartmentId;
--2. Find the person's name whose department is in C-Block.
SELECT PersonName from Person join Dept on Person.DepartmentId = Dept.DepartmentId where Location='C-Block';
--3. Retrieve person name, salary & department name who belongs to Jamnagar city.
SELECT PersonName, Salary, DepartmentName from Person join Dept on Person.DepartmentId = Dept.DepartmentId where City='Jamnagar';
--4. Retrieve person name, salary & department name who does not belong to Rajkot city.
SELECT PersonName, Salary, DepartmentName from Person join Dept on Person.DepartmentId = Dept.DepartmentId where City!='Rajkot';
--5. Retrieve person�s name of the person who joined the Civil department after 1-Aug-2001.
SELECT PersonName from Person join Dept on Person.DepartmentId = Dept.DepartmentId where DepartmentName='Civil' and JoiningDate>'1-Aug-2001';
--6. Find details of all persons who belong to the computer department.
SELECT * from Person join Dept on Person.DepartmentId = Dept.DepartmentId where DepartmentName='Computer';
--7. Display all the person's name with the department whose joining date difference with the current date is more than 365 days.
SELECT * from Person left join Dept on Person.DepartmentId = Dept.DepartmentId where DATEDIFF(day,person.joiningDate,getdate())>365;
--8. Find department wise person counts.
SELECT DepartmentName , COUNT(PersonID) as Count from Person join Dept on Person.DepartmentId = Dept.DepartmentId group by DepartmentName
--9. Give department wise maximum & minimum salary with department name.
SELECT DepartmentName , Min(Salary) as MIN_Salary , Max(Salary) as MAX_Salary from Person join Dept on Person.DepartmentId = Dept.DepartmentId group by DepartmentName
--10. Find city wise total, average, maximum and minimum salary.
SELECT City , Min(Salary) as MIN_Salary , Max(Salary) as MAX_Salary, Sum(Salary) as Total_Salary from Person join Dept on Person.DepartmentId = Dept.DepartmentId group by City
--11. Find the average salary of a person who belongs to Ahmedabad city.
SELECT City, Avg(Salary) as AVG_Salary from Person group by City having City = 'Ahmedabad' 
--12. Produce Output Like: <PersonName> lives in <City> and works in <DepartmentName> Department. (In single column)
SELECT PersonName + ' lives in ' + City + ' and works in ' + DepartmentName + ' Department.' as Details from Person join Dept on Person.DepartmentId = Dept.DepartmentId

--Part � B:
--1. Produce Output Like: <PersonName> earns <Salary> from <DepartmentName> department monthly. (In single column)
SELECT PersonName + ' earns ' + CAST(Salary as VARCHAR) + ' from ' + DepartmentName + ' department monthly.' as Details 
from Person 
join Dept 
on Person.DepartmentId = Dept.DepartmentId
--2. Find city & department wise total, average & maximum salaries.
SELECT City, DepartmentName, Sum(Salary) as Total_Salary, Avg(Salary) as AVG_Salary, Max(Salary) as Max_Salary 
from Person 
join Dept 
on Person.DepartmentID = Dept.DepartmentId
group by City, DepartmentName
--3. Find all persons who do not belong to any department.
SELECT PersonName from Person where DepartmentID is NULL
--4. Find all departments whose total salary is exceeding 100000.
SELECT DepartmentName 
from Dept 
join Person 
on Person.DepartmentId = Dept.DepartmentId 
group by DepartmentName 
having Sum(Salary)>10000

--Part � C:
--1. List all departments who have no person.
SELECT Dept.DepartmentName
FROM Dept
LEFT JOIN Person ON Dept.DepartmentID = Person.DepartmentID
WHERE Person.PersonID IS NULL;
--2. List out department names in which more than two persons are working.
SELECT Dept.DepartmentName 
FROM Dept
JOIN Person ON Dept.DepartmentID = Person.DepartmentID
group by DepartmentName
having Count(Person.PersonID)>2
--3. Give a 10% increment in the computer department employee�s salary. (Use Update)
Update Person
SET Salary=Salary+(Salary*.1)
FROM Person
JOIN Dept ON Person.DepartmentID = Dept.DepartmentID
where DepartmentName = 'Computer'