-- 08_all_category_customers
-- v1  [2026-07-17] submitted version

with cnt_total_categories as(
	select count(*) 
		as total_categories
	from category cat 		
)
select
	CONCAT(cus.first_name, ' ', cus.last_name) as active_customers
from customer cus
inner join rental r
on cus.customer_id = r.customer_id 
inner join inventory i 
on r.inventory_id = i.inventory_id 
inner join film_category fc 
on i.film_id = fc.film_id
group by cus.customer_id
having count(distinct fc.category_id) =(
	select 
		total_categories
	from cnt_total_categories)
order by cus.customer_id;