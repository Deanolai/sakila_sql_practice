--01_active_customer_list


use sakila;
select customer.customer_id, customer.first_name, customer.last_name
from customer
where customer.active = 1
order by customer.last_name, customer.first_name;