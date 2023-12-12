create table customers.customer_current (
customer_durable_sk serial primary key,
firstname varchar(250),
location_postcode varchar(50),
last_update date default current_date);

drop table customer_current ;

insert into customer_current
values(default, 'Donald', 67133, '2023-11-09'),
(default, 'Victoria', 46908, '2023-10-10');

create table customers.products (
product_sk serial primary key,
name text,
color varchar(50));

insert into products 
values(default, 'HL Road Frame - Black, 58', 'Black'),
(default, 'AWC Logo Cap', 'Multi'),
(default, 'Long-Sleeve Logo Jersey, L', 'Multi'),
(default, 'Road-150, 52', 'Red');

drop table products ;

create table customers.customer_history (
customer_sk serial primary key,
customer_durable_sk int,
effective_date date,
ineffective_date date,
current_indicator boolean,
firstname varchar(50),
location_postcode varchar(20));

insert into customer_history
values(default, 1, '2023-02-01', '2023-10-09', '0', 'Donald', 98052),
(default, 2, '2023-10-10', '9999-10-10', '1', 'Victoria', 46908),
(default, 1, '2023-11-09', '9999-11-09', '1', 'Donald', 67133);

drop table customer_history 

create table customers.fact_sale (
customer_sk int,
customer_durable_sk int,
product_sk int,
date_sk int,
sales_quantity int,
unit_price decimal(10, 3),
constraint PK_fact_sale primary key (customer_sk, customer_durable_sk, product_sk, date_sk),
constraint fk_customer_sk foreign key (customer_sk) references customers.customer_history(customer_sk),
constraint fk_customer_durable_sk foreign key (customer_durable_sk) references customers.customer_current(customer_durable_sk),
constraint fk_product_sk foreign key (product_sk) references customers.products(product_sk));

drop table customers.fact_sale;

insert into fact_sale
values(1, 1, 2, 20230202, 1, 349),
(2, 2, 3, 20231810, 1, 20),
(3, 1, 4, 20231509, 1, 503);

DROP TRIGGER IF EXISTS location_postcode_changes ON customer_current;


create or replace function location_postcode_changes()
returns trigger 
language PLPGSQL
as 
$$
begin
	if new.location_postcode <> old.location_postcode then 
	--Update postalcode
	update customers.customer_history 
		set ineffective_date = current_date,
			current_indicator  = '0'
	where customer_sk = (select max(customer_sk)
								from customers.customer_history ch
							where (ch.customer_durable_sk = old.customer_durable_sk));
	--insert new values in rows
	insert into customers.customer_history(customer_sk, customer_durable_sk, effective_date, ineffective_date, current_indicator, firstname, location_postcode)
	values(default, old.customer_durable_sk, current_date, '9999-01-01', '1', old.firstname, new.location_postcode);
end if;
return new;
end;
$$

DROP TRIGGER IF EXISTS postcode_changes ON customer_current;

create or replace trigger postcode_changes
before update on customers.customer_current 
for each row 
execute procedure location_postcode_changes();

update customers.customer_current
set location_postcode = 32584,
last_update = default
where customer_durable_sk = 1;

update customers.customer_current 
set location_postcode = 73611,
last_update = default 
where customer_durable_sk = 2;

select * from customer_history ch ;
select * from customer_current cc 
