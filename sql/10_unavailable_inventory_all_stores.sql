-- 10_unavailable_inventory_all_stores
-- v1  [2026-07-17] submitted version

with
	film_inventory_table as(
        select
            f.film_id as film_id,
            i.inventory_id as inventory_id
        from film f
        inner join inventory i
        on f.film_id = i.film_id
    ),
	total_inventory as(
		select
			f.film_id ,
			count(*) as cnt_inventory
		from inventory i 
		inner join film f 
		on i.film_id = f.film_id 
		group by f.film_id
		order by f.film_id 
	),
	rented_out as(
		select
			f.film_id,
			count(*) as cnt_rented_out
		from rental r 
		inner join inventory i 
		on r.inventory_id = i.inventory_id 
		inner join film f 
		on i.film_id = f.film_id 
		where r.return_date is null
		group by f.film_id 
	),
	last_rental as(
        select
            i.film_id,
            max(r.rental_date) as recently_date
        from rental r
        inner join inventory i
        on r.inventory_id = i.inventory_id
        group by i.film_id
    ),
	all_unavailable as(
		select
			film_id 
		from film f 
		where (
  		(select cnt_inventory from total_inventory ti where ti.film_id = f.film_id)
  		=
  		(select cnt_rented_out from rented_out ro where ro.film_id = f.film_id)
		)
	)
select
    f2.film_id,
    f2.title,
    lr.recently_date
from film f2
left join(
    select film_id from film_inventory_table
) fit
on f2.film_id = fit.film_id
left join last_rental lr
on f2.film_id = lr.film_id
where fit.film_id is null
or f2.film_id in (select film_id from all_unavailable)
order by f2.film_id;