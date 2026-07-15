-- 04_orders_no_payment_customers
-- v1  [2026-07-15] submitted version

select distinct
	concat(c.first_name, ' ', c.last_name) as name,
	c.create_date
from customer c
inner join rental r
on c.customer_id = r.customer_id
left join payment p
on c.customer_id = p.customer_id
where p.payment_id is null
order by c.create_date;
