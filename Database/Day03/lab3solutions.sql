USE MyCompany;
GO
-- 1. Display all the employees data.
SELECT * 
FROM Employee;

-- 2. Display the employee first name, last name, salary and department number.
SELECT Fname AS 'First Name',
       Lname AS 'Last Name',
       Salary,
       Dno AS 'Department Number'
FROM Employee;

-- 3. Display all the project names, locations and the department which is responsible for it.
SELECT P.Pname   AS 'Project Name',
       P.Plocation AS 'Project Location',
       D.Dname   AS 'Department Name'
FROM Project P
JOIN Departments D ON P.Dnum = D.Dnum;

-- ANOTHER SOLVE
-- SELECT Pname, Plocation,
--        (SELECT Dname FROM Departments D WHERE D.Dnum = P.Dnum) AS 'Department Name'
-- FROM Project P;

-- 4. Display each employee full name and his/her annual commission (10% of annual salary).
SELECT Fname + ' ' + Lname AS 'Full Name',
       Salary * 12 * 0.10  AS 'ANNUAL COMMISSION'
FROM Employee;

-- 5. Display the employees Id and name who earn more than 1000 LE monthly.
SELECT SSN AS [Employee ID],
       Fname + ' ' + Lname AS 'Full Name'
FROM Employee
WHERE Salary > 1000;

-- 6. Display the employees Id and name who earn more than 10000 LE annually.
SELECT SSN AS 'Employee ID',
       Fname + ' ' + Lname AS 'Full Name'
FROM Employee
WHERE Salary * 12 > 10000;

-- 7. Display the names and salaries of the female employees.
SELECT Fname + ' ' + Lname AS 'Full Name',
       Salary
FROM Employee
WHERE Sex = 'F';

-- 8. Display each department id and name managed by a manager with id = 968574.
SELECT Dnum AS 'Department ID',
       Dname AS 'Department Name'
FROM Departments
WHERE MGRSSN = 968574;

-- 9. Display the ids, names and locations of the projects controlled by department 10.
SELECT Pnumber AS 'Project ID',
       Pname   AS 'Project Name',
       Plocation AS 'Project Location'
FROM Project
WHERE Dnum = 10;

-- 10. Display the department id, name and the id and name of its manager.
SELECT D.Dnum  AS 'Department ID',
       D.Dname AS 'Department Name]',
       E.SSN   AS 'Manager ID',
       E.Fname + ' ' + E.Lname AS [Manager Name]
FROM Departments D
JOIN Employee E ON E.SSN = D.MGRSSN;

-- 11. Display the name of the departments and the name of the projects under its control.
SELECT D.Dname AS 'Department Name',
       P.Pname AS 'Project Name'
FROM Departments D
JOIN Project P ON D.Dnum = P.Dnum;

-- 12. Display full data about all dependents with the name of the employee they depend on.
SELECT Dep.*,
       E.Fname + ' ' + E.Lname AS 'Employee Name'
FROM Dependent Dep
JOIN Employee E ON Dep.ESSN = E.SSN;

-- 13. Display the Id, name and location of the projects in Cairo or Alex.
SELECT Pnumber,
       Pname,
       Plocation
FROM Project
WHERE Plocation IN ('Cairo', 'Alex');

-- 14. Display full data of projects with a name starting with letter 'A'.
SELECT *
FROM Project
WHERE Pname LIKE 'A%';

-- 15. Display all employees in department 30 whose salary is between 1000 and 2000 LE monthly.
SELECT *
FROM Employee
WHERE Dno = 30
AND Salary BETWEEN 1000 AND 2000;

-- 16. Retrieve names of employees in department 10 who work >= 10 hours/week on "AL Rabwah".
SELECT E.Fname + ' ' + E.Lname AS [Employee Name]
FROM Employee E
JOIN Works_for W ON E.SSN = W.ESSN
JOIN Project P ON W.Pno = P.Pnumber
WHERE E.Dno = 10
AND P.Pname = 'AL Rabwah'
AND W.Hours >= 10;

-- using subquery
-- SELECT Fname + ' ' + Lname
-- FROM Employee
-- WHERE Dno = 10
-- AND SSN IN (
--     SELECT ESSN
--     FROM Works_for W JOIN Project P ON W.Pno = P.Pnumber
--     WHERE P.Pname = 'AL Rabwah' AND Hours >= 10
-- );

-- 17. Retrieve names of all employees and the projects they work on, sorted by project name.
SELECT E.Fname + ' ' + E.Lname AS 'Employee Name',
       P.Pname AS 'Project Name'
FROM Employee E
JOIN Works_for W ON E.SSN = W.ESSN
JOIN Project P ON W.Pno = P.Pnumber
ORDER BY P.Pname;

-- using subquery
-- SELECT Fname + ' ' + Lname,
--        (SELECT Pname FROM Project P WHERE P.Pnumber = W.Pno)
-- FROM Employee E JOIN Works_for W ON E.SSN = W.ESSN;

-- 18. For each project in Cairo, find project number, department name, manager last name, address, birthdate.
SELECT P.Pnumber,
       D.Dname,
       E.Lname,
       E.Address,
       E.Bdate
FROM Project P
JOIN Departments D ON P.Dnum = D.Dnum
JOIN Employee E ON D.MGRSSN = E.SSN
WHERE P.Plocation = 'Cairo';

-- 19. Display all data of the managers.
SELECT E.*
FROM Employee E
JOIN Departments D ON E.SSN = D.MGRSSN;

-- Alternative
-- SELECT * FROM Employee
-- WHERE SSN IN (SELECT MGRSSN FROM Departments);

-- 20. Display all employees data and their dependents even if they have none.
SELECT E.*, Dep.*
FROM Employee E
LEFT JOIN Dependent Dep ON E.SSN = Dep.ESSN;

-- 21. Insert your personal data as a new employee in department 30.
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
VALUES ('Marwa','Elhussieny',262626,'2003-06-26','Egypt','F',20000,335556,30);
--------------------------------------------------

-- 22. Insert another employee (friend) without salary or supervisor.
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Dno)
VALUES ('BLA','BLABLA',102660,'2003-06-27','Egypt','F',30);

-- 23. Upgrade your salary by 20%.
UPDATE Employee
SET Salary = Salary * 1.20
WHERE SSN = 102672;

-- 24. Display data using GETDATE in different formats.
SELECT 
    GETDATE() AS DefaultFormat,
    CONVERT(VARCHAR, GETDATE(), 101) AS US_Format,
    CONVERT(VARCHAR, GETDATE(), 103) AS British_Format,
    CONVERT(VARCHAR, GETDATE(), 120) AS ISO_Format,
    CONVERT(VARCHAR, GETDATE(), 113) AS Full_Date_Time;


