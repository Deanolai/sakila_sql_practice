-- 07_store_avg_order_cycle
-- v1  [2026-07-17] submitted version

select
	s.store_id,
	round(AVG(DATEDIFF(r.return_date, r.rental_date)),2) as avg_rental_date
from rental r
inner join staff s
on r.staff_id = s.staff_id 
group by s.store_id 
order by avg_rental_date asc;