use elections;
drop table zipcensus_nodups;
create external table zipcensus_nodups
(
Zip  STRING,
Population  STRING,
Male  STRING,
M0  STRING,
M18  STRING,
M30  STRING,
M40  STRING,
M50  STRING,
M60  STRING,
M70  STRING,
M80  STRING,
MMedianAge  STRING,
M18+  STRING,
M65+  STRING,
Female  STRING,
F0  STRING,
F18  STRING,
F30  STRING,
40F  STRING,
F50  STRING,
F60  STRING,
F70  STRING,
F80  STRING,
FMedianAge  STRING,
F18+  STRING,
F65+  STRING,
White  STRING,
Black  STRING,
Namerican  STRING,
Asian  STRING,
Islander  STRING,
Other  STRING,
Multiracial  STRING,
WhiteNAmerican  STRING,
WhiteAsian  STRING,
WhiteBlack  STRING,
WhiteOther  STRING,
Latino  STRING,
LatinoWhite  STRING,
LatinoBlack  STRING,
LatinoNAmerican  STRING,
LatinoOther  STRING,
LatinoMulti  STRING,
Mprison  STRING,
Fprison  STRING,
AvgHouseholdSize  STRING,
AvgFamilySize  STRING,
Housing  STRING,
Vacancy  STRING,
OOVacancyRate  STRING,
RentalVacancyRate  STRING,
OccupiedUnits  STRING,
OOUnits  STRING,
OOPop  STRING,
RentedUnits  STRING,
RentingPop  STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/zipcensus_nodups';

use elections;
drop table cavotingresultsbyparty;
create external table cavotingresultsbyparty
(
County  STRING,
2016ge_dem  STRING,
2016ge_rep  STRING,
2016ge_grn  STRING,
2016ge_lib  STRING,
2016ge_pf  STRING,
2016ge_wi  STRING,
2016ge_total  STRING,
2016pe_dem  STRING,
2016pe_rep  STRING,
2016pe_ai  STRING,
2016pe_grn  STRING,
2016pe_lib  STRING,
2016pe_pf  STRING,
2016pe_wi  STRING,
2016pe_total  STRING,
2014ge_dem  STRING,
2014ge_rep  STRING,
2014ge_total  STRING,
2014pe_dem  STRING,
2014pe_rep  STRING,
2014pe_grn  STRING,
2014pe_pf  STRING,
2014pe_npp  STRING,
2014pe_wi  STRING,
2014pe_total  STRING,
2012ge_dem  STRING,
2012ge_rep  STRING,
2012ge_ai  STRING,
2012ge_grn  STRING,
2012ge_lib  STRING,
2012ge_pf  STRING,
2012ge_wi  STRING,
2012ge_total  STRING,
2012pe_dem  STRING,
2012pe_rep  STRING,
2012pe_ai  STRING,
2012pe_grn  STRING,
2012pe_lib  STRING,
2012pe_pf  STRING,
2012pe_wi  STRING,
2012pe_total  STRING,
2010ge_dem  STRING,
2010ge_rep  STRING,
2010ge_ai  STRING,
2010ge_grn  STRING,
2010ge_lib  STRING,
2010ge_pf  STRING,
2010ge_wi  STRING,
2010ge_total  STRING,
2010pe_dem  STRING,
2010pe_rep  STRING,
2010pe_ai  STRING,
2010pe_grn  STRING,
2010pe_lib  STRING,
2010pe_pf  STRING,
2010pe_wi  STRING,
2010pe_total  STRING,
2008ge_dem  STRING,
2008ge_rep  STRING,
2008ge_ai  STRING,
2008ge_grn  STRING,
2008ge_lib  STRING,
2008ge_pf  STRING,
2008ge_wi  STRING,
2008ge_total  STRING,
2008pe_dem  STRING,
2008pe_rep  STRING,
2008pe_ai  STRING,
2008pe_grn  STRING,
2008pe_lib  STRING,
2008pe_pf  STRING,
2008pe_wi  STRING,
2008pe_total  STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"=",",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/cavotingresultsbyparty';

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
"separatorChar"=",",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/countytable';


