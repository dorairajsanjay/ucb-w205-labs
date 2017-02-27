#title        : new_surveys_responses
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Creates the transformed table from the original table
#
#Prerequisites: Original table must be created and accessible in HDFS

from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType

sc=SparkContext()

rdd=HiveContext(sc).sql('select provider_number as provider_id,communication_with_nurses_achievement_points,communication_with_nurses_improvement_points,communication_with_nurses_dimension_score,communication_with_doctors_achievement_points,communication_with_doctors_improvement_points,communication_with_doctors_dimension_score,responsiveness_of_hospital_staff_achievement_points,responsiveness_of_hospital_staff_improvement_points,responsiveness_of_hospital_staff_dimension_score,pain_management_achievement_points,pain_management_improvement_points,pain_management_dimension_score,communication_about_medicines_achievement_points,communication_about_medicines_improvement_points,communication_about_medicines_dimension_score,cleanliness_and_quietness_of_hospital_environment_achievement_points,cleanliness_and_quietness_of_hospital_environment_improvement_points,cleanliness_and_quietness_of_hospital_environment_dimension_score,discharge_information_achievement_points,discharge_information_improvement_points,discharge_information_dimension_score,overall_rating_of_hospital_achievement_points,overall_rating_of_hospital_improvement_points,overall_rating_of_hospital_dimension_score,hcahps_base_score,hcahps_consistency_score from surveys_responses')
 
from pyspark.sql.functions import udf

normalize_response = udf(lambda response: int(float(response.split()[0])/float(response.split()[3])*10) if response != "Not Available" else int(-1), IntegerType())
integer_check = udf(lambda response: int(response) if response != "Not Available" else int(-1),IntegerType())

def normalize_response1(response):
	retval=0
	if response != "Not Available":
		retval = int(float(response.split()[0])/float(response.split()[3])*10)
	else:
		retval = int(-1)
	return retval

def integer_check1(response):
	retval=0
	if response != "Not Available":
		retval = int(response)
	else:
		retval = int(-1)
	return retval
	
rdd = rdd.map(lambda x: (x.provider_id,normalize_response1(x.communication_with_nurses_achievement_points),normalize_response1(x.communication_with_nurses_improvement_points),normalize_response1(x.communication_with_nurses_dimension_score),normalize_response1(x.communication_with_doctors_achievement_points),normalize_response1(x.communication_with_doctors_improvement_points),normalize_response1(x.communication_with_doctors_dimension_score),normalize_response1(x.responsiveness_of_hospital_staff_achievement_points),normalize_response1(x.responsiveness_of_hospital_staff_improvement_points),normalize_response1(x.responsiveness_of_hospital_staff_dimension_score),normalize_response1(x.pain_management_achievement_points),normalize_response1(x.pain_management_improvement_points),normalize_response1(x.pain_management_dimension_score),normalize_response1(x.communication_about_medicines_achievement_points),normalize_response1(x.communication_about_medicines_improvement_points),normalize_response1(x.communication_about_medicines_dimension_score),normalize_response1(x.cleanliness_and_quietness_of_hospital_environment_achievement_points),normalize_response1(x.cleanliness_and_quietness_of_hospital_environment_improvement_points),normalize_response1(x.cleanliness_and_quietness_of_hospital_environment_dimension_score),normalize_response1(x.discharge_information_achievement_points),normalize_response1(x.discharge_information_improvement_points),normalize_response1(x.discharge_information_dimension_score),normalize_response1(x.overall_rating_of_hospital_achievement_points),normalize_response1(x.overall_rating_of_hospital_improvement_points),normalize_response1(x.overall_rating_of_hospital_dimension_score),integer_check1(x.hcahps_base_score),integer_check1(x.hcahps_consistency_score))) 

#temprdd.take(5).show()
#rdd = sc.parallelize(rdd)


#rdd.toDF().registerTempTable("new_surveys_responses")
#HiveContext(sc).sql('create table new_surveys_responses as select * from new_surveys_responses')
rdd.toDF().write.mode('append').saveAsTable("new_surveys_responses")
