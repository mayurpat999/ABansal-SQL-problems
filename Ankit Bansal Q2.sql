-- Create the table
CREATE TABLE customer_orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_amount INT
);

-- Insert rows
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount)
VALUES
    (1, 100, '2022-01-01', 2000),
    (2, 200, '2022-01-01', 2500),
    (3, 300, '2022-01-01', 2100),
    (4, 100, '2022-01-02', 2000),
    (5, 400, '2022-01-02', 2200),
    (6, 500, '2022-01-02', 2700),
    (7, 100, '2022-01-03', 3000),
    (8, 400, '2022-01-03', 1000),
    (9, 600, '2022-01-03', 3000);

-- Query all rows
SELECT * FROM customer_orders;

-- Solution 1
with first_visit as (
select customer_id, min(order_date) as first_visit from customer_orders
group by customer_id),

flag_table as (
select co.*,fv.first_visit,
case when co.order_date = fv.first_visit then 1 else 0 end as first_visit_flag,
case when co.order_date != fv.first_visit then 1 else 0 end as repeat_visit_flag
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
order by order_id)

select order_date, sum(first_visit_flag) as first_visit_customers, sum(repeat_visit_flag) as repeat_visit_customers
from flag_table
group by order_date;
 
-- Solution 2
with first_visit as (
select customer_id, min(order_date) as first_visit from customer_orders
group by customer_id)

select co.order_date,
sum(case when co.order_date = fv.first_visit then 1 else 0 end) as first_visit_flag,
sum(case when co.order_date != fv.first_visit then 1 else 0 end) as repeat_visit_flag
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
group by order_date;

-- -- Solution 2 add order amount also
with first_visit as (
select customer_id, min(order_date) as first_visit from customer_orders
group by customer_id)

select co.order_date,
sum(case when co.order_date = fv.first_visit then 1 else 0 end) as first_visit_flag,
sum(case when co.order_date = fv.first_visit then co.order_amount else 0 end) as first_visit_order_amt,
sum(case when co.order_date != fv.first_visit then 1 else 0 end) as repeat_visit_flag,
sum(case when co.order_date != fv.first_visit then co.order_amount else 0 end) as repeat_visit_order_amt
from customer_orders co
inner join first_visit fv on co.customer_id = fv.customer_id
group by order_date;