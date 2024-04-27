---Bài tập 1---
select name
from students
where marks > 75
order by right(name, 3) asc, id asc

---Bài tập 2---
select user_id,
concat(upper(left(name, 1)),lower(right(name,length(name)-1))) as name
from users

---Bài tập 3---
select manufacturer,
concat('$',round(sum(total_sales)/1000000, 0),' ','million') AS sale
from pharmacy_sales
group by manufacturer
order by sum(total_sales) desc

---Bài tập 4---
select extract(month from submit_date) as mth,
product_id as product,
round(avg(stars), 2) as avg_stars
from reviews
group by extract(month from submit_date), product_id
order by extract(month from submit_date), product_id

---Bài tập 5---
select sender_id,
count(message_id) as count_messages
from messages
where extract(month from sent_date) = 8 and extract(year from sent_date) = 2022
group by sender_id
order by count_messages desc
limit 2

---Bài tập 6---
select tweet_id
from tweets
where length(content) > 15

---Bài tập 8---
select
count(id) as hired_employee
from employees
where extract(month from joining_date) between 1 and 7
and extract(year from joining_date) = 2022

---Bài tập 9---
select position('a' in first_name)
from worker
where first_name = 'Amitah'

---Bài tập 10---
select substring(title from length(winery) + 2 for 4)
from winemag_p2
where country = 'Macedonia'

