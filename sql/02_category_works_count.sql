-- 02_category_works_count
-- v1  [2026-07-15] submitted version

select
    c.name as category,
    count(*) as film_cnt
from category c
inner join film_category fc on c.category_id = fc.category_id
group by c.name
having film_cnt > 50
order by film_cnt desc;
