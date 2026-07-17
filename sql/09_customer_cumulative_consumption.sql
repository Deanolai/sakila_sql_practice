-- 09_customer_cumulative_consumption
-- v1  [2026-07-17] submitted version

select
	cus.customer_id,
	CONCAT(cus.first_name,' ', cus.last_name) as customer,
	p.amount,
	sum(p.amount) over(
		partition by cus.customer_id
		order by p.payment_date
	) as cumulative_amount
from payment p
inner join customer cus
on cus.customer_id = p.customer_id
order by cus.customer_id, p.payment_date;
