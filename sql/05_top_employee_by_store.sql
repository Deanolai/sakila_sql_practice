-- 05_top_employee_by_store
-- v1  [2026-07-17] submitted version

with staff_total_amount as(
	select
		s.store_id as store_id ,
		CONCAT(s.first_name, ' ', s.last_name) as staff_name,
		round(sum(p.amount), 2) as total_amount
	from staff s
	inner join store s2 
	on s.store_id = s2.store_id 
	inner join payment p 
	on s.staff_id = p.staff_id 
	group by s.store_id , s.staff_id , s.first_name , s.last_name  
)
select
	sta.store_id,
	sta.staff_name,
	FORMAT(sta.total_amount, 2) as total_amount
from staff_total_amount sta
where total_amount = (
	select max(total_amount)
	from staff_total_amount sta2
	where sta.store_id = sta2.store_id 
);

