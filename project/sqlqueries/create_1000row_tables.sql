use  elections;
create table pvrdr_vrd_1000 as select * from pvrdr_vrd limit 1000;
create table pvrdr_pd_1000 as select * from pvrdr_pd limit 1000;
create table pvrdr_vph_1000 as select * from pvrdr_vph limit 1000;
