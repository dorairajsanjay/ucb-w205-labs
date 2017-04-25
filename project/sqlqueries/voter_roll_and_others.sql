Use elections;

CREATE EXTERNAL TABLE pvrdr_vrd (
CountyCode    STRING,
RegistrantID STRING,
ExtractDate STRING,
LastName STRING,
FirstName STRING,
MiddleName STRING,
Suffix STRING,
AddressNumber STRING,
HouseFractionNumber STRING,
AddressNumberSuffix STRING,
StreetDirPrefix    STRING,
StreetName STRING,
StreetType    STRING,
StreetDirSuffix    STRING,
UnitType STRING,
UnitNumber STRING,
City STRING,
State STRING,
Zip STRING,
Phone1Area STRING,
Phone1Exchange STRING,
Phone1NumberPart STRING,
Phone2Area STRING,
Phone2Exchange STRING,
Phone2NumberPart STRING,
Phone3Area STRING,
Phone3Exchange STRING,
Phone3NumberPart STRING,
Phone4Area STRING,
Phone4Exchange STRING,
Phone4NumberPart STRING,
Email STRING,
MailingAddressLine1 STRING,
MailingAddressLine2 STRING,
MailingAddressLine3 STRING,
MailingCity STRING,
MailingState STRING,
MailingZip5 STRING,
MailingCountry STRING,
Language STRING,
DOB    STRING,
Gender STRING,
PartyCode STRING,
Status STRING,
RegistrationDate STRING,
Precinct STRING,
PrecinctNumber STRING,
RegistrationMethodCode STRING,
PlaceOfBirth STRING,
NamePrefix STRING,
NonStandardAddress STRING,
VoterStatusReasonCodeDesc STRING,
AssistanceRequestFlag STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"="\t",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/pvrdr-vrd-nh';


CREATE EXTERNAL TABLE pvrdr_vph
(
CountyCode STRING,
RegistrantID STRING,
ExtractDate    STRING,
ElectionType STRING,
ElectionTypeDesc STRING,
ElectionDate STRING,
ElectionName STRING,
Method STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"="\t",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/pvrdr-vph-nh';

CREATE EXTERNAL TABLE pvrdr_pd
(
CountyCode STRING,
RegistrantID STRING,
ExtractDate STRING,
District STRING,
DistrictName STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"="\t",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/pvrdr-pd-nh';

# create first 1K rows tables for test
create table pvrdr_pd_1000 as select * from pvrdr_pd limit 1000;
create table pvrdr_vrd_1000 as select * from pvrdr_vrd limit 1000;
create table pvrdr_vph_1000 as select * from pvrdr_vph limit 1000;

# create random 10K row tables for test
create table pvrdr_pd_10000 as select * from pvrdr_pd where rand() <= 0.001 distribute by rand() sort by rand() limit 10000;
create table pvrdr_vph_10000 as select * from pvrdr_vph where rand() <= 0.001 distribute by rand() sort by rand() limit 10000;
create table pvrdr_vrd_10000 as select * from pvrdr_vrd where rand() <= 0.001 distribute by rand() sort by rand() limit 10000;

# create genderbook.csv
# NEED TO CONVERT COMMAS TO TABS BEFORE RUNNING THE BELOW QUERY
CREATE EXTERNAL TABLE genderbook
(
gender STRING,
percentage STRING,
firstname STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar"="\t",
"quoteChar"='"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/election_data/genderbook';

# create table LIKE existing table
create table pvrdr_vrd_10000_autog like pvrdr_vrd_10000;
create table pvrdr_vrd_autog like pvrdr_vrd;



