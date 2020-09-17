word = LOAD '/Luminar/Bigdata/sample.txt' as(words:chararray);
word_grp = FOREACH word GENERATE FLATTEN(TOKENIZE(words))as w;
word_count_grp = GROUP word_grp ALL;

word_count_grp1 = GROUP word_grp by w;
word_cnt = FOREACH word_count_grp1 GENERATE group as wrd,COUNT(word_grp) as cn;
word_asn = ORDER word_cnt by cn ASC;


"MAX and Min"

tempareture = LOAD '/Luminar/WordcountProblem/Temperature' USING PigStorage(' ') as(ye :int,tmp:int);
tmp_grp = Group tempareture BY ye;
tmp_max =FOREACH tmp_grp GENERATE group as y,MAX(tempareture.tmp);

tmp_min =FOREACH tmp_grp GENERATE group as y,MIN(tempareture.tmp);


cust = LOAD '/Luminar/Bigdata/customer' using PigStorage(',') as (id:int,fname:chararray,sname:chararray,age:int,job:chararray,place:chararray);
cust_grp = GROUP cust by age;
cust_max_age = FOREACH cust_grp GENERATE group as age1,MAX(cust.name) as no1;
cust_min_age = FOREACH cust_grp GENERATE group as age1,MIN(cust.name) as no1;

"AVERAGE"

 tmp_avg = FOREACH tmp_grp GENERATE group,AVG(tempareture.tmp) as t;

