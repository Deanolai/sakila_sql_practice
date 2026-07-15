-- 03_monthly_revenue_report
-- v1  [2026-07-15] submitted version

select
    year(p.payment_date) as year,
    month(p.payment_date) as month,
    round(sum(p.amount), 2) as monthly_revenue
from payment p
where year(p.payment_date) = (select max(year(payment_date)) from payment)
group by year, month
order by month;
