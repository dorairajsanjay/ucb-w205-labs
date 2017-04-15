use elections;
drop table countyvoterpart;
create external table countyvoterpart 
(
County  STRING,
2016GE_Eligible  STRING,
2016_GE_Reg  STRING,
2016GE_Precinct  STRING,
2016GE_VBM  STRING,
2016GE_Total  STRING,
2016PE_Eligible  STRING,
2016_PE_Reg  STRING,
2016PE_Precinct  STRING,
2016PE_VBM  STRING,
2016PE_Total  STRING,
2014GE_Eligible  STRING,
2014GE_Reg  STRING,
2014GE_Precinct  STRING,
2014GE_VBM  STRING,
2014GE_Total  STRING,
2014PE_Eligible  STRING,
2014PE_Reg  STRING,
2014PE_Precinct  STRING,
2014PE_VBM  STRING,
2014PE_Total  STRING,
2012GE_Eligible  STRING,
2012GE_Reg  STRING,
2012GE_Precinct  STRING,
2012GE_VBM  STRING,
2012GE_Total  STRING,
2012PE_Eligible  STRING,
2012_PE_Reg  STRING,
2012PE_Precinct  STRING,
2012PE_VBM  STRING,
2012PE_Total  STRING,
2010GE_Eligible  STRING,
2010GE_Reg  STRING,
2010GE_Precinct  STRING,
2010GE_VBM  STRING,
2010GE_Total  STRING,
2010PE_Eligible  STRING,
2010_PE_Reg  STRING,
2010PE_Precinct  STRING,
2010PE_VBM  STRING,
2010PE_Total  STRING,
2008GE_Eligible  STRING,
2008GE_Reg  STRING,
2008GE_Precinct  STRING,
2008GE_VBM  STRING,
2008GE_Total  STRING,
2008STPE_Eligible  STRING,
2008ST_PE_Reg  STRING,
2008STPE_Precinct  STRING,
2008STPE_VBM  STRING,
2008STPE_Total  STRING,
2008PRPE_Eligible  STRING,
2008PR_PE_Reg  STRING,
2008PRPE_Precinct  STRING,
2008PRPE_VBM  STRING,
2008PRPE_Total  STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"="\t",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/countyvoterpart';

use elections;
drop table countytable;
create external table countytable
(
County  STRING,
countycode  STRING,
CountyJoined  STRING,
CountyUnderscore  STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"="\t",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/countytable';
