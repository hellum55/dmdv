/* Creating intital leads table */
create table bi.leads(
	employee_id integer primary key,
	employee_name varchar(250),
	lead_responsible boolean,
	unit_name varchar(250),
	unit_city varchar(250),
	customer_id1 integer,
	customer_name1 varchar(250),
	customer_id2 integer,
	customer_name2 varchar(250),
	customer_id3 integer,
	customer_name3 varchar(250)
);

insert into bi.leads 
	values (1, 'John Smith', 'TRUE', 'Sales', 'Aarhus', 1, 'Danske Commodities', null, null, null, null),
		   (2, 'Vicki Adams', 'TRUE', 'Marketing', 'Copenhagen', null, null, 2, 'Copenhagen Economics', null, null),
		   (3, 'Jane Morgan', 'FALSE', 'Marketing', 'Copenhagen', null, null, 2, 'Copenhagen Economics', null, null),
           (4, 'Dennis Shoemaker', 'TRUE', 'Business Intelligence', 'Aalborg', null, null, null, null, 3, 'Aalborg Portland');

 select * from bi.leads;


create table bi.unit (
unit_id int primary key,
unit_name varchar(250),
unit_city varchar(250));

drop table bi.unit;

insert into bi.unit
values(1, 'Sales', 'Aarhus'),
(2, 'Marketing', 'Copenhagen'),
(3, 'Business Intelligence', 'Aalborg');

create table bi.employee(
employee_id serial primary key,
employee_name varchar(250),
unit_id int,
constraint FK_unit_id foreign key (unit_id) references bi.unit(unit_id));

insert into bi.employee
values(default, 'John Smith', 1),
(default, 'Vicki Adams', 2),
(default, 'Jane Morgan', 2),
(default, 'Dennis Shoemaker', 3);
 
drop table bi.employee;

create table bi.customers (
customer_id int primary key,
customer_name varchar(250));

drop table bi.customers

insert into bi.customers
values(1, 'Danske Commodities'),
(2, 'Copenhagen Economics'),
(3, 'Aalborg Portland');

create table bi.employee_customers(
employee_id int,
customer_id int,
lead_responsible boolean,
constraint PK_employee_customers primary key (employee_id, customer_id),
constraint FK_employee_id foreign key (employee_id) references bi.employee(employee_id),
constraint FK_customer_id foreign key (customer_id) references bi.customers(customer_id));

insert into bi.employee_customers
values(1, 1, 'TRUE'),
(2, 2, 'TRUE'),
(3, 2, 'FALSE'),
(4, 3, 'TRUE');


