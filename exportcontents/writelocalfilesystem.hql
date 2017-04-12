-- create a database custom
create database custom;

-- entering to database custom
use custom;

-- create table temperature_data
create table temperature_data 
(date date,zipcode int,temperature float)
row format delimited
fields terminated by ',';

--create temp table for conversion date to expected format (MM-dd-yyyy)

create table temp 
(date string,zipcode int,temperature float)
row format delimited
fields terminated by ',';


-- load data into temperature_data
load data local inpath '/home/acadgild/Downloads/dataset_Session_14.txt' into table temp;

-- move data from temp to temperature_data
insert into table temperature_data select to_date(from_unixtime(unix_timestamp(date,'dd-MM-yyyy'),'yyyy-MM-dd')),zipcode,temperature from temp;


-- create view with maximum temperature by year at least 2 entries
create view temperature_data_view as select year(date),max(temperature) from temperature_data group by year(date) having count(1) > 1 ;

-- write view to local file sytem with fields terminated by '|'
insert overwrite local directory '/home/acadgild/Downloads/temp_output' row format delimited 
fields terminated by '|' select * from temperature_data_view;


