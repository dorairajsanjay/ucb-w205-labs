SET hive.exec.dynamic.partition.mode=nonstrict;

use  elections;

create table if not exists pvrdr_vrd_1000_orc  like pvrdr_vrd
stored as ORC
tblproperties('transactional'='true');

insert into pvrdr_vrd_1000_orc
as select * from pvrdr_vrd_1000;

