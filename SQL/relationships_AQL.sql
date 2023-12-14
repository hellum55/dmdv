-- 1. create a simple table:
create table bi.Employee (
id serial primary key,
name varchar(250),
business_unit varchar(250)
);

insert into bi.Employee (
id, name, business_unit)
values (default, 'Hanzi', 'ECON'),
		(default, 'Jogge', 'Jura'),
		(default, 'Mona', 'Medicin'),
		(default, 'Nima', 'Tømrer')
		
select * from bi.Employee;

 -- 2. create another table with foreign key:
create table bi.Employee_contact (
employee_id serial primary key,
phone integer,
email varchar(250),
constraint FK_employee_id foreign key (employee_id) references bi.Employee(id));

insert into bi.Employee_contact
values (1, '74983623', 'niller@jul.dk'),
		(2, '72975382', 'ulla@påske.dk'),
		(3, '13864398', 'birger@pinse.dk'),
		(4, '93095372', 'sigurd@helligtrekonger.dk');

select * from bi.Employee_contact;

-- 3. the foreign key can not contain values that are not represented in the primary key column (1-4)

-- 4. A composite primary key consist of multiple columns, and
-- rows are uniquely identified across the columns holding the primary key

-- 5. The relation created on slide 12 is an identifying relationship because the primary key of the parent migrates
-- to the child primary key. This relation is enforced by the foreign key in the bi.student contact table.

-- 6. non-identifying optional relationship.

-- 7. Consider the many-to-many relation depicted on slide 20. Write these tables in your bi schema, 
-- but also include the book ”Database Systems for real” and assume it is authored by Ramez Elmasri and Thomas Nield.

create table bi.books (
id serial primary key,
title varchar(250),
description varchar(250));

insert into bi.books (id, title, description)
values(default, 'SQL cookbook', 'Interesting read'),
(default, 'SQL for beginners', 'Nice introduction'),
(default, 'Advanced SQL', 'Good for the experienced user'),
(default, 'Database Systems for real', 'Shit ass book');

create table bi.authors (
id serial primary key,
name varchar(250));

insert into bi.authors
values(1, 'Lynn Beighley'),
(2, 'Anthony DeBaros'),
(3, 'Thomas Nield'),
(4, 'Ramez Elmasri');

create table bi.books_authors (
book_id int,
author_id int,
constraint PK_books_authors primary key (book_id, author_id), 
constraint FK_book_id foreign key (book_id) references bi.books(id),
constraint FK_book_author foreign key (author_id) references bi.authors(id));

insert into bi.books_authors
values(1, 2),
(1, 3),
(2, 2),
(3, 1),
(4, 3),
(4, 4);

select * from bi.books_authors;

-- 8. Write SQL queries such that you reproduce the tables, constraints, and values given below. 
-- Hint: Consider the order in which you create tables and remember that a black dot in a relation in the ER diagram
-- signifies the location of the foreign key.

create table bi.department (
department_code serial primary key,
department_name varchar(250),
deparment_location varchar(50));

drop table bi.department ;

insert into bi.department
values(default, 'Computer Science', 'Aarhus C'),
(default, 'Economics and Business Economics', 'Aarhus V'),
(default, 'Law', 'Aarhus C'),
(default, 'Medicine', 'Aarhus C');

create table bi.student (
student_number serial primary key,
student_name varchar(250),
department_code int,
constraint FK_department_code foreign key (department_code) references bi.department(department_code));

drop table bi.student ;

insert into bi.student 
values(default, 'Birgit', 2),
(default, 'Anders', 1),
(default, 'Pia', 3),
(default, 'Henrik', 3),
(default, 'Per', null);

drop table bi.course_id;

create table bi.course (
course_id serial primary key,
course_name varchar(250),
course_major varchar(250));

drop table bi.course;

insert into bi.course
values(default, 'Programming 1', 'BSc in Computer Science'),
(default, 'Principles of Economics', 'BSc in Economics'),
(default, 'Distributed systems', 'BSc in Computer Science'),
(default, 'Animal Law', 'BSc in Law'),
(default, 'Biochemistry', 'BSc in Medicine');

create table bi.student_course (
student_number int,
course_id int,
accepted varchar(50),
constraint PK_student_course primary key (student_number, course_id),
constraint FK_student_number foreign key (student_number) references bi.student(student_number),
constraint FK_course_id foreign key (course_id) references bi.course(course_id));

drop table bi.student_course CASCADE ;

insert into bi.student_course
values(1, 2, 'Accepted'),
(1, 3, 'Not Accepted'),
(2, 1, 'Accepted'),
(3, 3, 'Awaiting'),
(3, 4, 'Accpted'),
(4, 4, 'Not Accpted');









