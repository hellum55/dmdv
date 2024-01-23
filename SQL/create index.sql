-- 10. Create a small table with an id column and a text column with some random text. Create an index on the text column.
-- Verify that the index is created by point-and-click in DBeaver.

create table bi.random_shit (
id serial primary key,
text_col text);

insert into bi.random_shit
values(default, 'blabalabalabakhfjbdjj'),
(default, 'hesjan svriage'),
(default, 'hvad skød du den med?');

create index idx_text_col
on bi.random_shit(text_col);
