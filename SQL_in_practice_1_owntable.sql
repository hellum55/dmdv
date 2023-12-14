create table public.example_table (
id serial primary key,
heltal integer,
tekst varchar(200),
numerisk numeric(10, 3),
dato_tid date,
nul_eller_et boolean
);

insert into public.example_table (id, heltal, tekst, numerisk, dato_tid, nul_eller_et)
	values(default, 3, 'hund', 100.333, '2000-01-01', '1')
	,(default, 10, 'giraf', 333.111, '2010-08-08', '1');
	
select * from example_table et;