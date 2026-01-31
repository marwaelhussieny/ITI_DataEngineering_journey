
-- DDL 
-- create 
-- drop
-- alter

create table emp
(
  ID int primary key,
  Salary float ,  -- allow null by default
  DepID int 
)

-- delete table
drop table emp

-- alter table structure

-- add coulumn
alter table emp 
add hiredate date

-- delte column
alter table emp 
drop column hiredate

-- change column type
alter table emp
alter column salary bigint

-- DML (Data)
-- insert 
-- update 
-- delete 

insert into emp values (1, 25000, NULL, NULL)

insert into emp (ID, Salary) 
values (2, 30000)

-- update column data 
update emp 
set salary = 15000

-- conditions (where)
update emp 
set salary = 25000
where id = 2


-- delete 
delete from emp  -- delete all data (Row)

delete from emp
where id = 2


--- delete (handle data)   vs    drop Structure (columns)

-- delete column data 
update emp 
set salary = NULL


-- DQL 
select *               -- all cloumns 
from Student

select st_id , st_fname
from Student

select * 
from Student
where Dept_Id = 10

select * 
from Student 
where St_Address = 'Alex'  -- data ordered by id asc

select *
from Student
order by St_Fname desc



-- NULL reprsent no existing data
select *
from Student
where St_Fname = NULL

-- is null / is not null
select *
from Student
where St_Fname is not NULL


-- distinct 
-- order by asc 
select distinct St_Fname
from Student 


-- range 
select *
from Student
where st_age >= 18 and St_Age <= 60

select *
from Student 
where st_age between 18 and 60

select * 
from Student
where St_Age = 25 or St_Age = 22

-- in vlauees
select *
from Student
where St_Address in ('Alex', 'Mansoura' , 'Cairo')

-- student in dept = 20 and age >= 24
select *
from Student 
where Dept_Id = 20 and st_age >= 24

--- concation between more than column
select St_Fname+ ' ' + St_Lname AS fullname
from Student


select s.St_Id , s.St_Fname , D.Dept_Id
from Student s , Department D