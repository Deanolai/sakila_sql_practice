-- 01_active_customer_list
-- v1  [2026-07-15] submitted version
-- v2  [2026-07-15] refine: CONCAT full name, table alias, code formatting

select
    c.customer_id,
    concat(c.first_name, ' ', c.last_name) as full_name
from customer c
where c.active = 1
order by c.last_name, c.first_name;
