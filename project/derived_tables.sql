USE  elections;
DROP TABLE voter_roll;
CREATE TABLE voter_roll as
select
countycode, registrantid, lastName, firstname, city, zip, language, dob, gender, partycode, registrationdate, placeofbirth
FROM pvrdr_vrd;

DROP TABLE 2016ge;
CREATE TABLE 2016ge as
select
countycode, registrantid, method as 2016ge_method
FROM pvrdr_vph
WHERE electiondate= '2016-11-08'
ORDER BY countycode, registrantid;

DROP TABLE 2016pe;
CREATE TABLE 2016pe as
select
countycode, registrantid, method as 2016pe_method
FROM pvrdr_vph
WHERE electiondate = '2016-06-07'
ORDER BY countycode, registrantid;

DROP TABLE 2014ge;
CREATE TABLE 2014ge as
select
countycode, registrantid, method as 2014ge_method
FROM pvrdr_vph
WHERE electiondate = '2014-11-04'
ORDER BY countycode, registrantid;

DROP TABLE 2014pe;
CREATE TABLE 2014pe as
select
countycode, registrantid, method as 2014pe_method
FROM pvrdr_vph
WHERE electiondate = '2014-06-03'
ORDER BY countycode, registrantid;
