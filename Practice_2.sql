---Bài tập 1---
select distinct city
from station
where ID % 2= 0

---Bài tập 2---
select count(city) - count(distinct city)
from station

---Bài tập 4---
select round(cast(sum(item_count*order_occurrences)/sum(order_occurrences) as decimal),1) as mean ---cast để biến int thành decimal, từ đó mới round được
from items_per_order;

---Bài tập 5---
select candidate_id
from candidates
where skill in ('Python', 'PostgreSQL', 'Tableau')
group by candidate_id
having count(skill)=3
order by candidate_id asc;

---Bài tập 6---
select user_id,
date(max(post_date))-date(min(post_date)) as day_between
from posts
where post_date BETWEEN '2021-01-01' AND '2022-01-01'
group by user_id
having count(post_id) >= 2

---Bài tập 7---
select card_name,
max(issued_amount) - min(issued_amount) as difference
from monthly_cards_issued
group by card_name
order by difference desc

---Bài tập 8---
SELECT manufacturer,
COUNt(drug) AS drug_count,
abs(sum(cogs - total_sales)) AS total_loss
FROM pharmacy_sales
WHERE total_sales<cogs
GROUP BY manufacturer
ORDER BY total_loss desc

---Bài tập 9---
select *
from Cinema
where id % 2 <> 0
and description != 'boring'
order by rating desc

---Bài tập 10---
select teacher_id,
count(distinct(subject_id)) as cnt
from teacher
group by teacher_id

---Bài tập 11---
select user_id,
count(follower_id) as followers_count
from followers
group by user_id
order by user_id asc

---Bài tập 12---
select class
from courses
group by class
having count(student) >= 5
