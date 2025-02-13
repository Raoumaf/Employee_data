create table employee (
Employee_ID text,
Name        text,
Department text,
Position  text,
Salary int,
Hire_Date date,
Performance_Rating int,
Years_of_Experience	int,
Age	int,
Region text
)

select * from employee ;


select * , row_number() over(
partition by  Employee_ID , Name ) as row_num
from employee;


with duplicate_cte as (
select * , row_number() over(
partition by  Employee_ID , Name )
from employee
)
select * from duplicate_cte 
where row_number >1;



create table employee1(
Employee_ID text,
Name        text,
Department text,
Position  text,
Salary text,
Hire_Date text,
Performance_Rating text,
Years_of_Experience	text,
Age	int,
Region text ,
row_number int 
);

select * from employee1;

insert into employee1
select  *,  row_number() over(
partition by  Employee_ID , Name )
from employee;


delete from employee1 
where row_number >1;

select * from employee1;


select distinct department from employee1;
select distinct region  from employee1;

select * from employee1 where Department IS null;

update employee1 set Department='Unknown' where Department IS null;

select * from employee1 where position IS null;

update employee1 set position='Unknown' where position IS null;

select * from employee1 where hire_date IS null;

update employee1 set hire_date='Invalid Date' where hire_date IS null;


select * from employee1 where region IS null;

update employee1 set region='Unknown' where region IS null;


select distinct performance_rating from employee1;

update employee1 set performance_rating='1' where performance_rating IS null ;


select distinct salary from employee1;


select salary from employee1 
where salary > 100000 or salary<2000;

update employee1 set salary=100000 where salary > 100000  ;
update employee1 set salary=2000 where salary < 2000  ;

select distinct age from employee1;


select age from employee1 
where age > 70 or age < 18;

update employee1 set age=18 where age < 18  ;
update employee1 set age=70 where age > 70  ;

-- Replace negative or very large values in Years of Experience with 0.

update employee1 set Years_of_Experience=0  where Years_of_Experience > 30  ;
update employee1 set Years_of_Experience=0  where Years_of_Experience < 0  ;

-- The hire_date is a string , so we need to convert it to a date 

alter table employee1
alter column hire_date type date USING hire_date::date;

update employee1 set hire_date = to_date(hire_date , 'DD-MM-YYYY');

select * from employee1;

ALTER TABLE employee1
drop column row_number;
