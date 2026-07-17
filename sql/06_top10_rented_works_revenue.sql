-- 06_top10_rented_works_revenue
-- v1  [2026-07-17] submitted version

select
	f.title as title,
	count(*) as rental_cnt,
	sum(p.amount) as total_amount
from film f
inner join inventory i
on f.film_id  = i.film_id 
inner join rental r
on i.inventory_id  = r.inventory_id 
inner join payment p
on r.rental_id  = p.rental_id 
group by f.title 
order by count(*) desc
limit 10;