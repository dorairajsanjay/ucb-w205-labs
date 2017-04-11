use elections;
drop table 2014ge_10k;
create table 2014ge_10k as
select * from 2014ge
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

drop table 2014pe_10k;
create table 2014pe_10k as
select * from 2014pe
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

drop table 2016pe_10k;
create table 2016pe_10k as
select * from 2016pe
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

drop table pvrdr_pd_10k;
create table pvrdr_pd_10k as
select * from pvrdr_pd
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

drop table pvrdr_vph_10k;
create table pvrdr_vph_10k as
select * from pvrdr_vph
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

drop table pvrdr_vrd_10k;
create table pvrdr_vrd_10k as
select * from pvrdr_vrd
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

drop table voter_grand_10k;
create table voter_grand_10k as
select * from voter_grand
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

drop table voter_roll_10k;
create table voter_roll_10k as
select * from voter_roll
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

