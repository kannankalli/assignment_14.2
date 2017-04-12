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


-- select date and temperature b/w 300000 to 399999
select date,temperature,zipcode from temperature_data where zipcode between 300000 and 399999;
