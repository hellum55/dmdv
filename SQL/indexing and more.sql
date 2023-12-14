-- 5. Return all rows in the bi five.training table where rows in the text column contains ”Henry”
select * from bi_five.training t where t.text like '%Henry';

-- 6. Return all rows in the bi five.training table where rows in the text column has the second last character being ”p"
select * from bi_five.training t where t.text like '%_p';

-- 7. Compare the query time between bi five.turkers and bi five.turkers indexes when ordering on the phone column.
explain analyze select * from bi_five.turkers t 
order by t.phone ;

explain analyze select * from bi_five.turkers_indexes ti 
order by ti.phone ;

-- 8. Compare the query time between bi five.training and bi five.training indexes when ordering on the line and chapter
-- columns simultaneously. Use point-and-click in DBeaver to figure out which columns hold the index.
explain analyze select * from bi_five.training t 
order by t.line, t.chapter  ;

explain analyze select * from bi_five.training_indexes ti 
order by ti.line, ti.chapter  ;

-- 9. Do a left join with bi five.training being the left table and bi five.turkers being the right table.
-- Also, do a left join with bi five.training indexes being the left table and bi five.turkers indexes being the right table.
-- In both cases, after the join is completed you should sort on the phone column. Can you generally say that one operation
-- is faster than another? Do we still use an index after the join operation?

explain analyze select *
from bi_five.training t 
left join bi_five.turkers t2  
on t.turk_fk  = t2.turk_pk
order by t2.phone;

explain analyze select *
from bi_five.training_indexes ti 
left join bi_five.turkers_indexes ti2
on ti.turk_fk  = ti2.turk_pk
order by ti2.phone;
/*After the join operation the index on the phone column is no longer used.
We cannot say that one query is in general faster than another */





