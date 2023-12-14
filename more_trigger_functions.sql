drop schema if exists bi cascade;
create schema bi;

-- Department table
create table bi.Department (
	department_code serial primary key,
	department_name varchar(255),
	department_location varchar(255),
	last_update timestamp(0) without time zone default current_timestamp(0)
);

insert into bi.Department
	values (default, 'Computer Science', 'Aarhus C')
		  ,(default, 'Economics and Business Economics', 'Aarhus V')
		  ,(default, 'Law', 'Aarhus C')
		  ,(default, 'Medicine', 'Aarhus C');


-- Student table
create table bi.Student (
	student_number serial primary key,
	student_name varchar(255),
	department_code integer,
	last_update timestamp(0) without time zone default current_timestamp(0),
	constraint FK_department_code foreign key(department_code)
	references bi.Department (department_code)
);

insert into bi.Student
	values (default, 'Birgit', 2)
		  ,(default,'Anders', 1)
		  ,(default,'Pia', null)
		  ,(default,'Henrik', 3);

-- Course
create table bi.Course(
	course_id serial primary key,
	course_name varchar(250),
	course_major varchar(250),
	last_update timestamp(0) without time zone default current_timestamp(0)
);

insert into bi.Course 
	VALUES (default, 'Programming I', 'BSc in Computer Science')
		  ,(default, 'Principles of Economics', 'BSc in Economics')
		  ,(default, 'Distributed systems', 'BSc in Computer Science')
		  ,(default, 'Animal Law', 'Bsc in Law')
		  ,(default, 'Biochemistry', 'Bsc in Medicine');
		  
-- Student course
create table bi.Student_course(
	student_number integer,
	course_id integer,
	accepted varchar(50),
	last_update timestamp(0) without time zone default current_timestamp(0),
	constraint PK_student_course primary key (student_number, course_id),
	constraint FK_student_number foreign key (student_number)
	references bi.Student (student_number),
	constraint FK_course_id foreign key (course_id)
	references bi.Course (course_id)
	);

insert into bi.student_course
	values (1, 2, 'Accepted')
		  ,(1, 3, 'Not accepted')
		  ,(2, 1, 'Accepted')
		  ,(3, 4, 'Accepted')
		  ,(3, 3, 'Awaiting')
		  ,(4, 2, 'Not accepted');

-- 1. Create tables according to the create tables for update delete triggers.sql file. Update the
-- department table such that Computer Science is changed to Computer and Data Science.
update bi.department 
set department_name = 'Computer and Data Science',
last_update = default
where department.department_name = 'Computer Science';

-- 2. Update the department code of the student Pia such that she is associated with
-- the Computer and Data Science department. 
update bi.student 
set department_code = d.department_code,
last_update = default
from bi.department d
where (d.department_name = 'Computer and Data Science') and (student.student_name='Pia');

-- 3. Delete the student Pia from the student table.
delete from bi.student_course sc
where sc.student_number = (select s.student_number from bi.student s where s.student_name = 'Pia');

-- 4. Create a history table, of the SCD2 type, which is related to the course table. Then create a trigger 
-- such that this history table automatically gets updated whenever the course name in the course table gets updated. 
-- Test that the trigger works correctly (i.e. check that the history table gets updated).
drop table bi.department_history;

create table bi.department_history (
department_hist_sk serial primary key,
department_code_durable int,
department_name varchar(100),
department_location varchar(100),
effective_date timestamp,
ineffective_date timestamp,
current_indicator boolean,
constraint fk_department_hist_sk foreign key (department_code_durable) references department(department_code));

insert into bi.department_history
	values (default, 1, 'Computer Science', 'Aarhus C', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 2, 'Economics and Business Economics', 'Aarhus V', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 3, 'Law', 'Aarhus C', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 4, 'Medicine', 'Aarhus C', current_timestamp(0), '3022-10-30 23:19:23', '1');

create table bi.course_history (
course_hist_sk serial primary key,
course_id_durable int,
course_name varchar(100),
course_major varchar(100),
effective_date timestamp,
ineffective_date timestamp,
current_indicator boolean,
constraint fk_course_hist_sk foreign key (course_id_durable) references bi.course(course_id));

insert into bi.course_history 
	VALUES (default, 1, 'Programming I', 'BSc in Computer Science', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 2, 'Principles of Economics', 'BSc in Economics', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 3, 'Distributed systems', 'BSc in Computer Science', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 4, 'Animal Law', 'Bsc in Law', current_timestamp(0), '3022-10-30 23:19:23', '1')
		  ,(default, 5, 'Biochemistry', 'Bsc in Medicine', current_timestamp(0), '3022-10-30 23:19:23', '1');
		 
create or replace function course_name_changes()
returns trigger 
language PLPGSQL
as 
$$
begin
	if new.course_name <> old.course_name then 
	--Update postalcode
	update bi.course_history  
		set ineffective_date = current_date,
			current_indicator  = '0'
	where course_hist_sk = (select max(course_hist_sk)
								from bi.course_history ch
							where (ch.course_id_durable = old.course_id));
	--insert new values in rows
	insert into bi.course_history(course_hist_sk, course_id_durable , course_name, course_major, effective_date, ineffective_date, current_indicator)
	values(default, old.course_id, new.course_name, old.course_major, current_date, '3022-10-30 23:19:23', '1');
end if;
return new;
end;
$$

--- Create trigger
create or replace trigger course_name_changes
 before update  
 on bi.course  
 for each row  
 execute procedure course_name_changes();

update bi.course    
set course_name = 'Programming 1.01'
where course_id = 1;






		 

