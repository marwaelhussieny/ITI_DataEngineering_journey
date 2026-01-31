
--Data Types
/*
--Numeric 
bit             -- bool 0 , 1 
tinyint         -- -128: 127   1B
smallint        --2B   -32768:32767
int             --4B    
bigint          --8B


--Decimal
money        -- 8B     .0000
smallMoney      --4B      .0000
real             -- .00000000
float            -- 0.00000000000000000
dec(5, 3)        --00000.000

--char 
char(3)         -- fixed length text amr
varchar(20)      -- variable length 
nchar (4)          -- unicode /n  + text   /n 'Ahm' 
nvarchar(30)       -- unicode + text vaiable length 
nvarchar(max)       -- limit of text to be reserved in memory

-- DateTime
Date     MM/DD/YYYY
time     HH:MM:SS
time(7)    HH:MM:SS.0000000
smalldatetime    MM/DD/YYYY HH:MM:00
datetime          MM/DD/YYYY HH:MM:SS 
datetimeoffset     MM/DD/YYYY HH:MM:00  +2UTC 

-- Binary 
binary(5)            00011

--Images 
-- local in DB 
image               00001111100000111110 
                    00111000111111111111

-- upload images to cloud ----> Link save to DB as string

--another:
hirarchy
sql_varient 
uniqueIdentifier
XML 
*/

-- Drop  vs Delete vs truncate

--drop 
table structure 

-- delete 
data only (rows)
--where 
--save query into log file 

--Truncate 
data only 
no where allowed 
-- much faster than delete 
-- can not be roll back
-- can not be saved log file (save on it all actions performed on database)


-- batch 
--select + run 
delete from emp;
update emp
set Salary = 3000

--script 
-- go 
-- successed -- executed
-- failed   -- error 
-- run as file

--transactions
--single unit of work 

--run realted each other 
begin transaction 
	update Student 
	set St_Age = 20;

	delete Department
	where Dept_Id = 100

rollback   -- rollback any changes 
commit   -- execute changes 

--explict transaction
begin try 
	begin transaction
			update Student 
	        set St_Age = 20;

	        delete Department
	        where Dept_Id = 100
	commit 
end try
begin catch 
    select 'there issue happend';
	rollback    -- roll changes that happened
	-- any DML 
end catch


begin try 
	begin transaction
	    update Student 
	set St_Age = 20;

	        delete Department
	        where Dept_Id = 100
	commit 
end try
begin catch 
	rollback    -- roll changes that happened
	update Student 
	set St_Age = 20;

end catch



------------------------------------
-- integrity
create table employee
(
	eid int,
	ename varchar(20),
	lname varchar(30) unique,    -- no dublicaations , allow null value 
	eaddress varchar(50),
	hiredate date default GetDate(),
	age tinyint,
	overtime tinyint,
	netSalary money not null,
	gender char(1),    -- F M
	dept_id int 

	constraint PK primary key (eid, ename),
	constraint ageconst check (age between 18 and 60),
	constraint genderconst check (gender = 'F' or gender = 'M'),
	constraint deptFK foreign key (dept_id) references Department(dept_id)
	on delete set null
	on update cascade	
)

-- error 
-- old will not affected , new will be checked   (rule)

alter table employee with nocheck  
add constraint deptID2 check (dept_id > 300)


-- constriant  (old + new)

-- old will not affected , new will be checked   (rule)

create rule r1 as @x > 1000

sp_bindrule r1 , 'instructor.salary'

sp_bindrule r1 , 'employee.netsalary'

sp_unbindrule 'instructor.salary'

sp_unbindrule 'employee.netsalary'

drop rule r1


-- default value
create default def1 as 2000
go
sp_bindefault def1, 'instructor.salary'


-- constraint vs rule
-- speicfic for table                      -- object on DB
-- many constraint on column               -- one rule on coulmn
-- old & new data                         -- only new 
-- with no check (new data only) 


----------------------------------------------------------------------
-- identity
1 2 3 4 5 6 
2 5 8 11

create table dept
(
id int primary key identity(2, 3),
name varchar(30)
)

drop table dept

-- issues on insert data (1 row added)
insert into dept(name) values('omar')


-- backup & issues database 
-- expse info 
select *, newID() from
Instructor


drop table dept
CREATE TABLE dept
(
    id nvarchar(100) PRIMARY KEY DEFAULT NEWID(),
    name VARCHAR(30)
);


------------------------------------------------------------------

 -- insert into / insert based on select
 -- table exist 
 -- same structure 
 -- datatype
 -- order of columns
 -- data only 

 insert into newtable3
 select s.St_Fname ,  s.St_Id,  s.St_Age
 from Student s

-- select into 
-- copy table to antoher 
-- create table newtable1  + structure of instructor + data
-- structure withour constaints 
select * into newtable5
from Instructor

-- copy without data
-- epmty table from instructore ( id , name , salary)
select I.Ins_Id , I.Ins_Name, I.Salary into newtable3
from Instructor I

select * from newtable3

select * into newtable6
from Instructor I
where I.Salary > 15000


select * into newtable7
from Instructor I
where I.Ins_Id is null


select * into newtable8
from Instructor I
where 1 = 0

select * from newtable7
-------------------------------------------------------

select top(5) *
from Student

select top(2) *
from Instructor I
order by I.Salary desc

--- select 
--- order
--- top

-- search top with ties + order by 


-- Ranking functions
select *
from
(select * , ROW_NUMBER() over (order by salary desc) as rownumber
from Instructor) as newtable
where rownumber <= 4


select * 
from
(select * , Dense_RANK() over (partition by dept_id order by salary desc) as ranknum
from Instructor) as newtable
where ranknum <=2

select * 
from
(select * , Ntile(3) over (order by salary desc) as ntilero
from Instructor) as newtable
where ntilero = 2


 














