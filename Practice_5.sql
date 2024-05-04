---Bài tập 1---
select co.continent, floor(avg(ci.population))
from country as co
left join city as ci 
on co.code = ci.countrycode
group by co.continent
having avg(ci.population) is not null
order by avg(ci.population) asc

---Bài tập 2---
select
round(sum(case when t.signup_action = 'Confirmed' then 1 else 0 end)*1.0 
/ count(t.signup_action),2) as confirm_rate
from emails e
left join texts t
on e.email_id = t.email_id 
where e.email_id is not null

---Bài tập 3---
select ab.age_bucket,
round (sum(case when a.activity_type = 'send' then a.time_spent else 0 end) * 100.0/
sum(time_spent), 2) as send_perc,
round (sum(case when a.activity_type = 'open' then a.time_spent else 0 end) * 100.0/
sum(time_spent), 2) as open_perc
from activities as a
inner join age_breakdown as ab
on a.user_id = ab.user_id
where a.activity_type = 'send' or a.activity_type = 'open'
group by ab.age_bucket

---Bài tập 4---
select c.customer_id
from customer_contracts as c
left join products as p
on c.product_id = p.product_id
group by c.customer_id
having count(distinct p.product_category) = 3

---Bài tập 5---
select emp.employee_id, 
emp.name, 
count(mng.employee_id) as reports_count,
round(avg(mng.age)) as average_age
from employees as emp
left join employees as mng
on emp.employee_id = mng.reports_to
group by emp.employee_id, emp.name
having count(mng.reports_to) > 0
order by employee_id

---Bài tập 6---
select p.product_name, sum(unit) as unit
from products as p
left join orders as o
on p.product_id = o.product_id
where extract(month from order_date) = 2
group by p.product_name
having sum(unit) >= 100

---Bài tập 7---
select p.page_id
from pages as p
left join page_likes as pl
on p.page_id = pl.page_id
where pl.liked_date is null
group by p.page_id
order by p.page_id asc
