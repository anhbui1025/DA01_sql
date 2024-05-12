---Bài tâp 1----
with job_count as (
  select
    company_id, 
    title, 
    description, 
    count(job_id) as job_count
  from job_listings
  group by company_id, title, description
)

select count(distinct company_id) as duplicate_companies
from job_count
where job_count > 1

---Bài tâp 2----


---Bài tâp 3----
WITH policy_holder_count AS
(
select policy_holder_id,
count(case_id) as policy_holder_count
from callers
group by policy_holder_id)

select count(policy_holder_id)
from policy_holder_count
where policy_holder_count >= 3

---Bài tâp 4----
select p.page_id
from pages as p
left join page_likes as pl
on p.page_id = pl.page_id
where pl.liked_date is null
group by p.page_id
order by p.page_id asc

---Bài tâp 5----


---Bài tâp 6----
with approved_transactions as 
(
select count(id) as trans_count, to_char(trans_date, 'YYYY-MM') as month,
country, sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(case when state = 'approved' then amount else 0 end) as approved_total_amount,
sum(amount) as trans_total_amount
from transactions
group by country, to_char(trans_date, 'YYYY-MM')
)

select month,
country, trans_count, approved_count, trans_total_amount, approved_total_amount
from approved_transactions 
order by month asc

---Bài tâp 7----
with first_year_product as 
(
select product_id, min(year) as first_year
from Sales
group by product_id
)

select sales.product_id, sales.year as first_year , sales.quantity, sales.price
from first_year_product
join sales 
on sales.product_id = first_year_product.product_id
where sales.year = first_year_product.first_year
order by product_id asc

---Bài tâp 8----
with customer_buying as 
( 
select customer_id,
count(distinct product_key) as product_amount
from Customer
group by customer_id
)

select cb.customer_id
from customer_buying cb
where product_amount = (select count(product_key) from product)

---Bài tâp 9----
select employee_id
from employees
where salary < 30000
and manager_id not in (select employee_id from employees)
order by employee_id

---Bài tâp 10----


---Bài tâp 11----
with movie_rate as (
    select *
    from MovieRating
    where to_char(created_at, 'yyyy-mm') = '2020-02'
),

movie_with_highest_rating as (
    select title
    from movie_rate
    inner join Movies
    on movie_rate.movie_id = movies.movie_id
    group by Movies.movie_id, title
    order by avg(rating) desc,
            title asc
    limit 1
),

user_with_greatest_number_of_movies as (
    select name
    from MovieRating
    join Users
    on MovieRating.user_id = users.user_id
    group by MovieRating.user_id, name
    order by count(movie_id) desc,
            name asc
    limit 1
)

select name as results
from user_with_greatest_number_of_movies

union all

select title
from movie_with_highest_rating

---Bài tâp 12----
with friend_count as
(
    select requester_id as id
    from RequestAccepted
    union all
    select accepter_id as id
    from RequestAccepted
)

select id, COUNT(id) as num
from friend_count
group by id
order by num desc
limit 1
