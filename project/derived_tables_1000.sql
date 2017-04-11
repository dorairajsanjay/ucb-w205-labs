use elections;

DROP TABLE voter_roll_1000;
CREATE TABLE voter_roll_1000 as
select
countycode, registrantid, lastName, firstname, city, zip, language, dob, gender, partycode, registrationdate, placeofbirth
FROM pvrdr_vrd_1000;

DROP TABLE 2016ge_1000;
CREATE TABLE 2016ge_1000 as
select
countycode, registrantid, method as 2016ge_method
FROM pvrdr_vph_1000
WHERE electiondate= '2016-11-08'
ORDER BY countycode, registrantid;

DROP TABLE 2016pe_1000;
CREATE TABLE 2016pe_1000 as
select
countycode, registrantid, method as 2016pe_method
FROM pvrdr_vph_1000
WHERE electiondate = '2016-06-07'
ORDER BY countycode, registrantid;

DROP TABLE 2014ge_1000;
CREATE TABLE 2014ge_1000 as
select
countycode, registrantid, method as 2014ge_method
FROM pvrdr_vph_1000
WHERE electiondate = '2014-11-04'
ORDER BY countycode, registrantid;

DROP TABLE 2014pe_1000;
CREATE TABLE 2014pe_1000 as
select
countycode, registrantid, method as 2014pe_method
FROM pvrdr_vph_1000
WHERE electiondate = '2014-06-03'
ORDER BY countycode, registrantid;
