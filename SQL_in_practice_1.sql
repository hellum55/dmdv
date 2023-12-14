--1. return the first 10 rows of customer table:
select * from customer c 
limit 10;

--2. return the distinct postal codes from adress table:
select distinct postal_code 
from public.address;

--3. select the title of films with length above 90 min.
select title, length 
from public.film f
where length > 90;

--4. Return the title, length and rental rate of all films which has a lentgh
--below 90 minutes and a rental rate above 4 dollars
select title, length, rental_rate
from public.film 
where length < 90 and rental_rate > 4;

--5. return the payment id, the payment date, and the amount where the payment falls in the interval:
-- 19feb 2007 at 7pm ; 20 feb 2007 at 7 pm:
select payment_id, payment_date, amount
from public.payment p
where payment_date between '2007-02-19 07:00:00.00' and '2007-02-20 07:00:00.00';

--6. make the same query as in exercise 5, but only return rows where the amount is above 7 dollars
select payment_id, payment_date, amount
from public.payment p
where (payment_date between '2007-02-19 07:00:00.00' and '2007-02-20 07:00:00.00') and (amount > 7);

--7 make two queries that return the rental table. first query returns rows sorted with respect to the rental_date
--such that first rental date is in first row. Second query is similar but return the opposite sorting of rental_date
select rental_date
from public.rental r 
order by rental_date;

select rental_date
from public.rental r 
order by rental_date desc ;

--8. Orders customer_id and payment_id in ascending order and also shows the amount of each rental
select customer_id, amount, payment_id
from payment p 
order by customer_id, amount;

--9 using the payment table: write a query that gets the number of payments for each customer. the returned table
-- should have customer_id and the number of payments as columns and only show 10 rows which have the highest number
-- of payments:
select count(customer_id), customer_id
from payment p 
group by customer_id 
order by count desc
limit 10;

--10. using the payment table: write a query that gets the number of payments for each customer. The query should only return
--customer_id where the number of payments is between 15 and 17.
select count(customer_id), customer_id
from payment p 
where count >= 15
group by customer_id
having count(customer_id) <= 17;

--11. compute the average value of the amount column in the payment table:
select avg(amount)
from payment p;

--12. assume the avg. of amount is 4.2. write a query that returns a table with a column that indicates whether a payment
--is either 'at the average', 'above average', 'below average' or no data:
select *,
	case
		when amount > 4.2 then 'above average'
		when amount < 4.2 then 'below average'
		when amount = 4.2 then 'at the average'
		else 'no data'
	end avg_classification
from (select amount from public.payment) as p;

--13. this can be written shorter and more efficient show how:
select sum(a.after_vat)
from (select amount*0.8 as after_vat
from payment) as a;

select sum(amount*0.8)
from payment p ;

--14. The following query counts the number of distinct postal codes from the
--address table. write an alternative (and longer) query that returns the same output, but uses aliases
select count(distinct postal_code)
from address;

select count(a.count_distinct)
from (select distinct postal_code as count_distinct
from address) as a;

--15. 








