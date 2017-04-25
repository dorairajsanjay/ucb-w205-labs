from pyspark import SparkContext
from pyspark import HiveContext
from gender_detector import GenderDetector

# initialize the gender detector
detector_us = GenderDetector('us') # It can also be ar, uk, uy.
detector_uk = GenderDetector('uk') # It can also be ar, uk, uy.
detector_ar = GenderDetector('ar') # It can also be ar, uk, uy.

def isBlank (myString):
    if myString and myString.strip():
        #myString is not None AND myString is not empty or blank
        return False
    #myString is None OR myString is empty or blank
    return True

def get_gender(name,gender):
	global detector

	if isBlank(name) or not name.isalpha():
		return gender

	newgender=gender
	if isBlank(newgender):
		newgender=detector_us.guess(name)
		if newgender=="unknown":
			newgender=detector_uk.guess(name)
			if newgender=="unknown":
				newgender=detector_ar.guess(name)

	if newgender=="female":
		newgender="F"
	elif newgender=="male":
		newgender="M"
	elif newgender=="unknown":
		newgender=""

	return newgender

sc=SparkContext()
sqlContext = HiveContext(sc)

from pyspark.sql.functions import udf, col
from pyspark.sql.types import StringType

udf_get_gender=udf(get_gender,StringType())

df = sqlContext.sql('select * from elections.pvrdr_vrd')
df_new = df.withColumn('gender',udf_get_gender(col('firstname'),col('gender')))

#df_new['firstname','gender'].show()

df_new.select("CountyCode","RegistrantID","ExtractDate","LastName","FirstName","MiddleName","Suffix","AddressNumber","HouseFractionNumber","AddressNumberSuffix","StreetDirPrefix","StreetName","StreetType","StreetDirSuffix","UnitType","UnitNumber","City","State","Zip","Phone1Area","Phone1Exchange","Phone1NumberPart","Phone2Area","Phone2Exchange","Phone2NumberPart","Phone3Area","Phone3Exchange","Phone3NumberPart","Phone4Area","Phone4Exchange","Phone4NumberPart","Email","MailingAddressLine1","MailingAddressLine2","MailingAddressLine3","MailingCity","MailingState","MailingZip5","MailingCountry","Language","DOB","Gender","PartyCode","Status","RegistrationDate","Precinct","PrecinctNumber","RegistrationMethodCode","PlaceOfBirth","NamePrefix","NonStandardAddress","VoterStatusReasonCodeDesc","AssistanceRequestFlag").write.format("orc").mode("overwrite").saveAsTable("elections.pvrdr_vrd_autog")

