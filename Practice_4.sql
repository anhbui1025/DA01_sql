---Bài tập 1---
select 
sum(case 
  WHEN device_type = 'laptop' then 1
  else 0
end) as laptop_views,
sum(case 
  WHEN device_type = 'tablet' or device_type = 'phone' then 1
  else 0
end) as mobile_views
from viewership

---Bài tập 2---
select *,
(case
    when x + y > z and y + z > x and x + z > y then 'Yes'
    else 'No'
end) as triangle
from triangle

---Bài tập 3---
select 
round(cast(sum(case 
                  when call_category = 'n/a' or call_category is null then 1
                  else 0
              end) * 100/ count(*) as decimal), 1) as uncategorised_call_pct
from callers 

---Bài tập 4---
select name
from Customer
where referee_id <> 2 
or referee_id is null

---Bài tập 5---
select
    survived,
    sum(case when pclass = 1 then 1 else 0 end) as first_class,
    sum(case when pclass = 2 then 1 else 0 end) as second_class,
    sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by survived
