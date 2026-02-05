select * from telecom_customer_churn

update telecom_customer_churn
set online_security ='No',
internet_type ='No',
online_backup = 'No',
device_protection_plan = 'No',
premium_tech_support ='No',
streaming_tv ='No',
streaming_movies ='No',
streaming_music ='No',
unlimited_data = 'No',
avg_monthly_gb_download = 0
where internet_service = 'No';
commit;


update telecom_customer_churn
set multiple_lines ='Yes'
WHERE internet_service = 'Yes';
COMMIT;

update telecom_customer_churn
SET churn_category = 'N0 Churn',
churn_reason = 'Active Customer'
WHERE customer_status in ('Stayed','Joined');

COMMIT;


select count(*) as total_rows,count(churn_reason) as non_null_values 
from telecom_customer_churn

select customer_status,
round(avg(monthly_charge),2) as avg_monthly_charges,
count(*) as total_customers
from telecom_customer_churn
group by customer_status;

select * from(select city,count(*) as churn_count,
round(sum(total_revenue),2) as revenue_lost
from telecom_customer_churn
where customer_status = 'Churned'
group by city
order by churn_count desc)
where rownum <=3;



select 
case
when age between 19 and 39 then 'Young_age 19-39'
when age between 40 and 59 then 'Middle_age 40-59'
when age >=60 then 'Senoir 60-80' end as age_group,
count(*) as total_customers,
sum(case when customer_status='Churned' then 1 else 0 end ) as churned_count,
round(avg(case when customer_status='Churned' then 1 else 0 end),2)*100 ||'%' as churn_rate
from telecom_customer_churn
group by
case
when age between 19 and 39 then 'Young_age 19-39'
when age between 40 and 59 then 'Middle_age 40-59'
when age >=60 then 'Senoir 60-80' end
order by age_group;

select 
premium_tech_support,count(*) as total_customers,
sum(case
when customer_status = 'Churned' then 1 else 0 end) as churned_count,
round(avg(case when customer_status='Churned' then 1 else 0 end ),2)*100 ||'%' as churn_rate
from telecom_customer_churn
group by premium_tech_support;


select contract,
count(*) as total_customers,
sum(case when customer_status = 'Churned' then 1 else 0 end) as churn_count,
round(avg(case when customer_status='Churned' then 1 else 0 end),2)||'%' as churn_rate
from telecom_customer_churn
group by contract;

select internet_type,
count(*) as total_customers,
round(avg(monthly_charge),2) as avg_bills,
sum(case when customer_status = 'Churned' then 1 else 0 end) as chun_count,
round(avg(case when customer_status = 'Churned' then 2 else 0 end),2) ||'%' as churn_rate
from telecom_customer_churn
group by internet_type
order by  churn_rate;


select 
churn_category,
count(*) as total_customer,
round(sum(total_revenue),2) as total_lost_revenue
from telecom_customer_churn
group by churn_category
order by total_lost_revenue desc;