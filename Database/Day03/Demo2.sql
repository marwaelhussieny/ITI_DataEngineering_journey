-- cross joins 
select s.St_Fname , D.Dept_Name
from Student s , Department D

select s.St_Fname , D.Dept_Name
from Student s cross join Department D

-- inner join 
-- student , deprtment of each student 

-- equi join
select s.St_Fname , d.Dept_Name
from Student s , Department D
where s.Dept_Id = D.Dept_Id

-- inner join 
select s.St_Fname , d.Dept_Name
from Student s join Department D
on s.Dept_Id = D.Dept_Id

-- show sutudent names , department name 
-- notes : live in ALEX

-- join + where
select s.St_Fname , d.Dept_Name
from Student s inner join Department D
on s.Dept_Id = d.Dept_Id
where s.St_Address = 'Alex'

-- join + order by
select s.St_Fname , d.Dept_Name
from Student s inner join Department D
on s.Dept_Id = d.Dept_Id and s.St_Address = 'Alex'
order by d.Dept_Name desc

-- all student and their department even if they have no department 
-- show null

select s.St_Id , D.Dept_Name
from Student s left join Department D
on s.Dept_Id = d.Dept_Id

select D.Dept_Name, s.St_Fname
from Student s right join Department D
on s.Dept_Id = d.Dept_Id



select D.Dept_Name, s.St_Lname
from Student s full outer join Department D
on s.Dept_Id = d.Dept_Id

-- join between multiple tables
-- name , grade , course 

select s.St_Fname , sc.Grade , c.Crs_Name
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id
inner join Course c
on c.Crs_Id = sc.Crs_Id


select s.St_Fname , sc.Grade , c.Crs_Name , t.Top_Name
from Student s join Stud_Course sc on s.St_Id = sc.St_Id
join Course c on c.Crs_Id = sc.Crs_Id
join topic t on c.Top_Id = t.Top_Id



-- join + DML
update Stud_Course
set Grade += 10
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id
where s.St_Address = 'alex'

-- search delete + join 


-- defualt 
-- can not delete parent with child 
delete from Department where Dept_Id = 10

-- no action : prevent delete / update parent with child 

-- set NULL  : delete / update parent ----> set NULL child

--Cascade : update parent ---------> follow same change 


-- relation : delete rule , update rule 

select GETDATE()

select FORMAT(getDate(), 'dd/MM/yyyy')
select FORMAT(getDate(), 'dddd MM yyyy')
select FORMAT(getDate(), 'MMMM')
-- try another formats + convert  


