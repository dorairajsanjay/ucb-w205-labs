In which counties is the mix of party registrations most different from state-wide averages?
*******************************************************************************************
use elections;
drop table county_party_props;
create table county_party_props as 
select a.countycode,b.county,
round(sum(case when a.partycode="DEM" then 1 else 0 end)/count(*),4) as avg_dem_prop,
round(sum(case when a.partycode="REP" then 1 else 0 end)/count(*),4) as avg_rep_prop,
round(sum(case when a.partycode="GRN" then 1 else 0 end)/count(*),4) as avg_grn_prop,
round(sum(case when a.partycode="LIB" then 1 else 0 end)/count(*),4) as avg_lib_prop
from voter_grand a
join countytable b on (cast(a.countycode as int)=cast(b.countycode as int))
group by a.countycode,b.county;

select * from county_party_props order by avg_rep_prop desc limit 3;
select * from county_party_props order by avg_dem_prop desc limit 3;
select * from county_party_props order by avg_lib_prop desc limit 3;
select * from county_party_props order by avg_grn_prop desc limit 3;

In which counties was turnout (number who voted as a % of those registered) highest and lowest?
***********************************************************************************************

use elections;
drop table county_turnout;
create table county_turnout as 
select a.countycode, b.county,
round(sum(case when a.2016ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2016ge,
round(sum(case when a.2014ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2014ge,
round(sum(case when a.2012ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2012ge,
round(sum(case when a.2010ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2010ge,
round(sum(case when a.2008ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2008ge,
round(sum(case when a.2016pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2016pe,
round(sum(case when a.2014pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2014pe,
round(sum(case when a.2012pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2012pe,
round(sum(case when a.2010pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2010pe,
round(sum(case when a.2008pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2008pe
from voter_grand_royale a
join countytable b on (cast(a.countycode as int)=cast(b.countycode as int))
group by a.countycode,b.county;

select * from county_turnout order by turnout_2016ge desc limit 3;
select * from county_turnout order by turnout_2014ge desc limit 3;
select * from county_turnout order by turnout_2012ge desc limit 3;
select * from county_turnout order by turnout_2010ge desc limit 3;
select * from county_turnout order by turnout_2008ge desc limit 3;
select * from county_turnout order by turnout_2016pe desc limit 3;
select * from county_turnout order by turnout_2014pe desc limit 3;
select * from county_turnout order by turnout_2012pe desc limit 3;
select * from county_turnout order by turnout_2010pe desc limit 3;
select * from county_turnout order by turnout_2008pe desc limit 3;

select * from county_turnout order by turnout_2016ge asc limit 3;
select * from county_turnout order by turnout_2014ge asc limit 3;
select * from county_turnout order by turnout_2012ge asc limit 3;
select * from county_turnout order by turnout_2010ge asc limit 3;
select * from county_turnout order by turnout_2008ge asc limit 3;
select * from county_turnout order by turnout_2016pe asc limit 3;
select * from county_turnout order by turnout_2014pe asc limit 3;
select * from county_turnout order by turnout_2012pe asc limit 3;
select * from county_turnout order by turnout_2010pe asc limit 3;
select * from county_turnout order by turnout_2008pe asc limit 3;

How did statewide turnout (numbers of votes cast compard to number of registered voters) vary by party?
*******************************************************************************************************

use elections;
drop table party_turnout;
create table party_turnout as 
select partycode, 
round(sum(case when 2016ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2016ge,
round(sum(case when 2014ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2014ge,
round(sum(case when 2012ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2012ge,
round(sum(case when 2010ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2010ge,
round(sum(case when 2008ge_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2008ge,
round(sum(case when 2016pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2016pe,
round(sum(case when 2014pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2014pe,
round(sum(case when 2012pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2012pe,
round(sum(case when 2010pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2010pe,
round(sum(case when 2008pe_method IS NOT NULL then 1 else 0 end)/count(*),4) as turnout_2008pe
from voter_grand_royale
group by partycode;

select * from party_turnout order by turnout_2016ge desc limit 3;
select * from party_turnout order by turnout_2014ge desc limit 3;
select * from party_turnout order by turnout_2012ge desc limit 3;
select * from party_turnout order by turnout_2010ge desc limit 3;
select * from party_turnout order by turnout_2008ge desc limit 3;
select * from party_turnout order by turnout_2016pe desc limit 3;
select * from party_turnout order by turnout_2014pe desc limit 3;
select * from party_turnout order by turnout_2012pe desc limit 3;
select * from party_turnout order by turnout_2010pe desc limit 3;
select * from party_turnout order by turnout_2008pe desc limit 3;

select * from party_turnout order by turnout_2016ge asc limit 3;
select * from party_turnout order by turnout_2014ge asc limit 3;
select * from party_turnout order by turnout_2012ge asc limit 3;
select * from party_turnout order by turnout_2010ge asc limit 3;
select * from party_turnout order by turnout_2008ge asc limit 3;
select * from party_turnout order by turnout_2016pe asc limit 3;
select * from party_turnout order by turnout_2014pe asc limit 3;
select * from party_turnout order by turnout_2012pe asc limit 3;
select * from party_turnout order by turnout_2010pe asc limit 3;
select * from party_turnout order by turnout_2008pe asc limit 3;

What is the breakdown by party affiliation of "first-time voters" in 2016 presidential election?
************************************************************************************************

select partycode, count(registrantid) as regid_count
from voter_grand_royale
where year(to_date(registrationdate)) > '2014'
group by partycode
order by regid_count desc;


# Looking at number of registration trends by year
use elections;
drop table registration_trends;
create table registration_trends as 
select year(to_date(registrationdate)) as reg_year,partycode,count(registrantid) as regid_count
from voter_grand_royale
where partycode in ("REP","DEM","LIB","GRN") and year(to_date(registrationdate)) > '2007'
group by year(to_date(registrationdate)) ,partycode
order by reg_year,regid_count desc


What is the gender breakdown of registrants by party?
*****************************************************
use elections;
drop table party_gender_count;
create table party_gender_count as 
select partycode,
sum(case when gender='M' then 1 else 0 end) as male_count,
sum(case when gender='F' then 1 else 0 end) as female_count, 
sum(case when gender='M' then 1 else 0 end)/ sum(case when gender in ('M','F') then 1 else 0 end) as male_proportion,
sum(case when gender='F' then 1 else 0 end)/ sum(case when gender in ('M','F') then 1 else 0 end) as female_proportion,
sum(case when gender NOT IN ("M","F") then 1 else 0 end) as gender_unknown_count,
count(registrantid) as total_registrants
from voter_grand_royale
group by partycode;

# Looking at number of registration trends by year and gender
*************************************************************
use elections;
drop table registration_trends_gender;
create table registration_trends_gender as 
select year(to_date(registrationdate)) as reg_year,partycode,count(registrantid) as regid_count,
sum(case when gender='M' then 1 else 0 end) as male_count,
sum(case when gender='F' then 1 else 0 end) as female_count, 
sum(case when gender='M' then 1 else 0 end)/ sum(case when gender in ('M','F') then 1 else 0 end) as male_proportion,
sum(case when gender='F' then 1 else 0 end)/ sum(case when gender in ('M','F') then 1 else 0 end) as female_proportion,
sum(case when gender NOT IN ("M","F") then 1 else 0 end) as gender_unknown_count,
count(registrantid) as total_registrants
from voter_grand_royale
where partycode in ("REP","DEM","LIB","GRN") and year(to_date(registrationdate)) > '2007'
group by year(to_date(registrationdate)) ,partycode
order by reg_year,regid_count desc
