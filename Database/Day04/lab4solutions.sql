USE MyCompany;
GO
-------
-- 1. DISPLAY (USING UNION)
--    A) FEMALE DEPENDENTS WHO DEPEND ON FEMALE EMPLOYEES
--    B) MALE DEPENDENTS WHO DEPEND ON MALE EMPLOYEES
SELECT D.Dependent_name AS [DEPENDENT NAME], D.Sex AS [GENDER]
FROM Dependent D
JOIN Employee E ON D.ESSN = E.SSN
WHERE D.Sex = 'F' AND E.Sex = 'F'

UNION

SELECT D.Dependent_name, D.Sex
FROM Dependent D
JOIN Employee E ON D.ESSN = E.SSN
WHERE D.Sex = 'M' AND E.Sex = 'M';
--------------

-- 2. FOR EACH PROJECT, LIST PROJECT NAME AND TOTAL HOURS PER WEEK
SELECT P.Pname AS [PROJECT NAME],
       SUM(W.Hours) AS [TOTAL HOURS PER WEEK]
FROM Project P
JOIN Works_for W ON P.Pnumber = W.Pno
GROUP BY P.Pname;

-- Alternative:
-- SELECT Pname,
--        (SELECT SUM(Hours) FROM Works_for W WHERE W.Pno = P.Pnumber)
-- FROM Project P;
----

-- 3. FIND EMPLOYEES WHO ARE DIRECTLY SUPERVISED BY KAMEL MOHAMED
SELECT Fname + ' ' + Lname AS [EMPLOYEE NAME]
FROM Employee
WHERE Superssn = (
    SELECT SSN FROM Employee
    WHERE Fname = 'Kamel' AND Lname = 'Mohamed'
);
--

-- 4. DISPLAY THE DEPARTMENT THAT HAS THE EMPLOYEE WITH THE SMALLEST SSN
SELECT *
FROM Departments
WHERE Dnum = (
    SELECT Dno
    FROM Employee
    WHERE SSN = (SELECT MIN(SSN) FROM Employee)
);
------------
-- 5. FOR EACH DEPARTMENT DISPLAY MAX, MIN, AVG SALARY
SELECT D.Dname,
       MAX(E.Salary) AS [MAX SALARY],
       MIN(E.Salary) AS [MIN SALARY],
       AVG(E.Salary) AS [AVG SALARY]
FROM Departments D
JOIN Employee E ON D.Dnum = E.Dno
GROUP BY D.Dname;
-------------
-- 6. LIST FULL NAMES OF MANAGERS WHO HAVE NO DEPENDENTS
SELECT E.Fname + ' ' + E.Lname AS [MANAGER NAME]
FROM Employee E
JOIN Departments D ON E.SSN = D.MGRSSN
WHERE NOT EXISTS (
    SELECT 1 FROM Dependent Dep WHERE Dep.ESSN = E.SSN
);
--------------

-- 7. DEPARTMENTS WHERE AVG SALARY < COMPANY AVG SALARY
SELECT D.Dnum,
       D.Dname,
       COUNT(E.SSN) AS [NUMBER OF EMPLOYEES]
FROM Departments D
JOIN Employee E ON D.Dnum = E.Dno
GROUP BY D.Dnum, D.Dname
HAVING AVG(E.Salary) < (SELECT AVG(Salary) FROM Employee);

-- 8. EMPLOYEE NAMES AND PROJECTS ORDERED BY DEPARTMENT THEN NAME
SELECT E.Fname + ' ' + E.Lname AS [EMPLOYEE NAME],
       P.Pname AS [PROJECT NAME],
       E.Dno
FROM Employee E
JOIN Works_for W ON E.SSN = W.ESSN
JOIN Project P ON W.Pno = P.Pnumber
ORDER BY E.Dno, E.Lname, E.Fname;

-- 9. GET MAX 2 SALARIES USING SUBQUERY
SELECT DISTINCT Salary
FROM Employee E1
WHERE 2 > (
    SELECT COUNT(DISTINCT Salary)
    FROM Employee E2
    WHERE E2.Salary > E1.Salary
)
ORDER BY Salary DESC;
--------
-- 10. EMPLOYEES WHO HAVE SAME NAME AS ANY DEPENDENT
SELECT Fname + ' ' + Lname AS [EMPLOYEE NAME]
FROM Employee
WHERE Fname IN (SELECT Dependent_name FROM Dependent);
--------------------------------------------------

-- 11. EMPLOYEES WHO HAVE DEPENDENTS USING EXISTS
SELECT SSN, Fname + ' ' + Lname AS [EMPLOYEE NAME]
FROM Employee E
WHERE EXISTS (
    SELECT 1 FROM Dependent D WHERE D.ESSN = E.SSN
);
--------------------------------------------------

-- 12. INSERT NEW DEPARTMENT "DEPT IT"
INSERT INTO Departments (Dname, Dnum, MGRSSN, [MGRStart Date])
VALUES ('DEPT IT', 100, 112233, '2006-11-01');
--------------------------------------------------

-- 13A. UPDATE NOHA MOHAMED TO MANAGE DEPT 100
UPDATE Departments
SET MGRSSN = 968574
WHERE Dnum = 100;

-- 13B. MAKE YOU (102672) MANAGER OF DEPT 20
UPDATE Departments
SET MGRSSN = 102672
WHERE Dnum = 20;

-- 13C. EMPLOYEE 102660 WILL BE SUPERVISED BY YOU
UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;
--------------------------------------------------

-- 14. DELETE KAMEL MOHAMED SAFELY

DELETE FROM Dependent
WHERE ESSN = 223344;

DELETE FROM Works_for
WHERE ESSN = 223344;

UPDATE Departments
SET MGRSSN = 102672
WHERE MGRSSN = 223344;

UPDATE Employee
SET Superssn = NULL
WHERE Superssn = 223344;

DELETE FROM Employee
WHERE SSN = 223344;
--------------------------------------------------

-- 15. INCREASE SALARY BY 30% FOR EMPLOYEES WORKING ON 'AL RABWAH'
UPDATE Employee
SET Salary = Salary * 1.30
WHERE SSN IN (
    SELECT W.ESSN
    FROM Works_for W
    JOIN Project P ON W.Pno = P.Pnumber
    WHERE P.Pname = 'AL Rabwah'
);
--------------------------------------------------
