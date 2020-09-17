movie = LOAD '/home/geethu/Downloads/movies.csv' using PigStorage(',') as (mid:int,name:chararray,rYear:int,rate:float,dur:int);
distM = DISTINCT movie;
MovieGrAl = GROUP distM ALL; 
MovieCnt = FOREACH MovieGrAl GENERATE group,COUNT(distM) as total;


MovieLRate = ORDER distM by rate ASC;
MovieHRate = ORDER distM by rate DESC;
under_rateMovie = LIMIT MovieLRate 10;
top_rateMovie = LIMIT MovieHRate 10;

under_rate_det = FOREACH under_rateMovie GENERATE name,rYear;
top_rate_det = FOREACH top_rateMovie GENERATE name,rYear;
STORE under_rate_det INTO '/Result/op_HratedMovie' using PigStorage(',');
STORE top_rate_det INTO '/Result/op_TRatedMovie' using PigStorage(',');

MYearCnt = GROUP distM by rYear;
MoYearCnt = FOREACH MYearCnt GENERATE group as mo,COUNT(distM) as total;
MoYearCnt_sort = ORDER MoYearCnt by total ASC;
dump MoYearCnt_sort;
STORE MoYearCnt_sort INTO '/Result/MovieNumInYear' using PigStorage(',');

Movie50and60 = FILTER distM by rYear>=1950 and rYear<=1960;
STORE Movie50and60 INTO '/Result/Movie50and60' using PigStorage(',');

Lrate_Movie50and60= ORDER Movie50and60 by rate ASC;
sel_Lrate_Movie50and60 = LIMIT Lrate_Movie50and60 1;
Hrate_Movie50and60= ORDER Movie50and60 by rate DESC;
sel_Hrate_Movie50and60 = LIMIT Hrate_Movie50and60 1;

STORE sel_Lrate_Movie50and60 INTO '/Result/op_sel_Lrate_Movie50and60' using PigStorage(',');
STORE sel_Hrate_Movie50and60 INTO '/Result/op_sel_Hrate_Movie50and60' using PigStorage(',');

movie_dur_ASN = ORDER distM by dur ASC;
movie_dur_DESN = ORDER distM by dur DESC;
movie_dur_max5 = LIMIT movie_dur_DESN 5;
dump movie_dur_max5;
movie_dur_min5 = LIMIT movie_dur_ASN 5;
dump movie_dur_min5;


STORE movie_dur_max5 INTO '/Result/op_movie_dur_max5' using PigStorage(',');
STORE movie_dur_min5 INTO '/Result/op_movie_dur_min5' using PigStorage(',');


movie_rate_range = FILTER distM by rate>=3.5 and rate<=4;
movieRate_Mindur = ORDER movie_rate_range by rate ASC;
movieRate_Maxdur = ORDER movie_rate_range by rate DESC;

movieRate_Mindur1 = LIMIT movieRate_Mindur 1;
movieRate_Maxdur1 =LIMIT movieRate_Maxdur 1;

movie_range70a80 = FILTER distM by rYear>=1970 and rYear<=1980;
movie_nameA = FILTER movie_range70a80 by name matches 'A.*';





