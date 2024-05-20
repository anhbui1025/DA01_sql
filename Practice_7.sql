---Bài tập 1---
select year, product_id, curr_year_spend, prev_year_spend,
round(100 * (curr_year_spend - prev_year_spend)/ prev_year_spend, 2) as yoy_rate
from 
(
select extract(year from transaction_date) as year,
product_id, spend as curr_year_spend, 
lag(spend) over(partition by product_id order by product_id,transaction_date) as prev_year_spend
from user_transactions
) as t
  
---Bài tập 2---
select card_name, issued_amount
from
(
select *, 
row_number() over (partition by card_name order by issue_year, issue_month) as rn
from monthly_cards_issued
) as t
where rn = 1
order by issued_amount desc;
---Bài tập 3---
select user_id,
spend,
transaction_date
from 
(
select *,
row_number() over(partition by user_id order by transaction_date) as rn
from transactions) as t 
where rn=3

---Bài tập 4---
select transaction_date, user_id, count(product_id) as purchase_count
from 
(
select product_id, user_id, transaction_date,
rank() over(partition by user_id order by transaction_date desc) as rn
from user_transactions) as t 
where rn = 1
group by transaction_date, user_id

---Bài tập 5---

---Bài tập 6---
select count(merchant_id) as payment_count
from 
(
select merchant_id,
extract(epoch from transaction_timestamp - lag(transaction_timestamp) over(partition by merchant_id, 
credit_card_id, amount order by transaction_timestamp))/60 as min_diff
from transactions
) as t 
where min_diff <= 10

---Bài tập 7---
select category, product, total_spend
from 
(
select category, product,
sum(spend) as total_spend,
rank() over(partition by category order by sum(spend) desc) as ranking
from product_spend
where extract(year from transaction_date) = 2022
group by category, product
) as spend_ranking
where ranking <= 2
order by category, ranking

---Bài tập 8---
with top_10 as 
(
select a.artist_name,
dense_rank() over(order by count(s.song_id) desc) as artist_rank
from artists a
join songs s
on a.artist_id=s.artist_id
join global_song_rank gsr
on gsr.song_id = s.song_id
where gsr.rank <= 10
group by a.artist_name
)

select artist_name, artist_rank
from top_10
where artist_rank <= 5
