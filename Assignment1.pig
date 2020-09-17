cust = LOAD '/home/geethu/Downloads/customer' using PigStorage(',') as (id:int,fname:chararray,sname:chararray,age:int,job:chararray,place:chararray);
cust_dist = DISTINCT cust;
cust_gAll = GROUP cust_dist  ALL;
cust_count1 = FOREACH cust_gAll GENERATE group,COUNT(cust_dist);
cust_sort_asc = ORDER cust_dist BY age ASC;
cust_sort_ten = LIMIT cust_sort_asc 10;
cust_sort_details1 = FOREACH cust_sort_ten GENERATE fname,sname,age,place;
cust_sort_des = ORDER cust_dist BY age DESC;
cust_sort_ten1 = LIMIT cust_sort_des 10;
cust_sort_details2 = FOREACH cust_sort_ten GENERATE fname,sname,age,place;


cust_age = GROUP cust by age;
cust_ageCount = FOREACH cust_age GENERATE group,COUNT(cust);
cust_age_grp = FOREACH cust_dist GENERATE age;
dis = DISTINCT cust_age_grp;
cust_age_grpAl = GROUP dis ALL;
Agecount1 = FOREACH cust_age_grpAl GENERATE group,COUNT(dis); 


cust_place = GROUP cust by place;
cust_placeCount = FOREACH cust_place GENERATE group,COUNT(cust);
cust_place_grp = FOREACH cust_dist GENERATE $5;
dis1 = DISTINCT cust_place_grp;
cust_P = GROUP dis1 ALL;
Placecount = FOREACH cust_P GENERATE group,COUNT(dis1); 



cust_job = GROUP cust by job;
cust_jobCount = FOREACH cust_job GENERATE group,COUNT(cust);
cust_job_grp = FOREACH cust_dist GENERATE $4;
dis2 = DISTINCT cust_job_grp;
cust_J = GROUP dis2 ALL;
Placecount = FOREACH cust_J GENERATE group,COUNT(dis2); 

SPLIT cust INTO cust_India IF place=='india',cust_uk IF place=='uk';
India_no = Group cust_India ALL;
India_cnt = FOREACH India_no GENERATE group,COUNT(cust_India);


cust_in_asc = ORDER cust_India BY age ASC;
cust_sort = LIMIT cust_in_asc 1;
cust_in_details1 = FOREACH cust_sort GENERATE fname,sname,age,place;

cust_in_des = ORDER cust_dist BY age DESC;
cust_sort1 = LIMIT cust_in_des 1;
cust_in_details2 = FOREACH cust_sort1 GENERATE fname,sname,age,place;


inDance = FILTER cust_India by job=='Dancer' and age==30;


inDoc = FILTER cust_India by job=='Doctor';


OthDoc = FILTER cust by job=='Doctor';


Acnt = FILTER cust by job=='Accountant';
Acnt_cnt = Group Acnt ALL;
Acnt_cnt1 = FOREACH Acnt_cnt GENERATE group,COUNT(Acnt);
Order1 = ORDER Acnt_cnt1 by $0 ASC;
dump Order1;




