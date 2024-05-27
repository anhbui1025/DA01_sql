---1. Chuyển đổi dữ liệu cho từng trường:
alter table public.sales_dataset_rfm_prj
alter column ordernumber type integer USING (ordernumber::integer),
alter column quantityordered type integer USING (quantityordered::integer),
alter column priceeach type float USING (priceeach::double precision),
alter column orderlinenumber type integer USING (orderlinenumber::integer),
alter column sales type float USING (sales::double precision),
alter column orderdate type timestamp USING (orderdate::timestamp without time zone),
alter column msrp type integer USING (msrp::integer)

---2. Check NULL/BLANK:
select *
from public.sales_dataset_rfm_prj
where ORDERNUMBER is null 
or QUANTITYORDERED is null
or PRICEEACH is null
or ORDERLINENUMBER is null
or SALES is null
or ORDERDATE is null

---3. Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME: 
select * from public.sales_dataset_rfm_prj
---Add 2 cột:
alter table public.sales_dataset_rfm_prj
add column contactlastname varchar(50),
add column contactfirstname varchar(50)
---Update dữ liệu vào cột first name:
update public.sales_dataset_rfm_prj
set contactfirstname = left(contactfullname, position('-' in contactfullname) -1)
---Viết hoa chữ đầu tiên của cột:
update public.sales_dataset_rfm_prj
set contactfirstname = initcap(contactfirstname)
---Update dữ liệu vào cột last name:
update public.sales_dataset_rfm_prj
set contactlastname = substring(contactfullname from (position('-' in contactfullname) +1) for (length(contactfullname) - length(contactfirstname) - 1))
---Viết hoa chữ đầu tiên của cột:
update public.sales_dataset_rfm_prj
set contactlastname = initcap(contactlastname)

---4. Thêm cột QTR_ID, MONTH_ID, YEAR_ID:
alter table public.sales_dataset_rfm_prj
add column qtr_id integer,
add column month_id integer,
add column year_id integer
---Update dữ liệu vào cột month_id:
update public.sales_dataset_rfm_prj
set month_id = extract(month from orderdate)
---Update dữ liệu vào cột year_id:
update public.sales_dataset_rfm_prj
set year_id = extract(year from orderdate)
---Update dữ liệu vào cột qtr_id:
update public.sales_dataset_rfm_prj
set qtr_id = extract(quarter from orderdate)

---5. Tìm Outlier và xử lý:
---Tìm Outlier bằng IQR/Boxplot:
with min_max_value as(
select q1-1.5*iqr as min_value, q1+1.5*iqr as max_value
from(
select 
percentile_cont(0.25) within group (order by QUANTITYORDERED) as q1,
percentile_cont(0.75) within group (order by QUANTITYORDERED) as q3,
percentile_cont(0.75) within group (order by QUANTITYORDERED) - percentile_cont(0.25) within group (order by QUANTITYORDERED) as iqr 
from public.sales_dataset_rfm_prj) as a)

, outlier as (select * 
from public.sales_dataset_rfm_prj
where QUANTITYORDERED < (select min_value from min_max_value)
or QUANTITYORDERED > (select max_value from min_max_value))

---Xử lí outlier bằng cách cập nhật outlier thành giá trị trung bình:
update public.sales_dataset_rfm_prj
set quantityordered = (select avg(quantityordered) from public.sales_dataset_rfm_prj)
where quantityordered in (select quantityordered from outlier)
