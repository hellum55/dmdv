-- 11.
select min(d.date) as first_date, max(d.date) as last_date
from dim_mod.dimdate d;

-- 12. Define a sale as salesquantity · unitprice. Make a query that gives the total sale per week day 
-- over the entire period. Sort the results such that the weekday with the highest total sale is
-- listed first in the returned table.

select sum(f.salesquantity * f.unitprice) as sale, d.dayname
from dim_mod.fact_onlinesales f
left join dim_mod.dimdate d 
on f.datekey_fk  = d.datenum_pk
group by d.dayname 
order by sale DESC;