#title        : hospitals_and_patients
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Retrieves stats on patient quality vis-a-vis hospitals
#
#Prerequisites: Base tables must be created and accessible in HDFS

from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType
import numpy as np


sc=SparkContext()
hc=HiveContext(sc)

# Create 2 RDDs from tables - one involving aggregated results on hospital quality and other involving hospital data
hpq_rdd  =hc.sql('select * from new_surveys_responses where hcahps_base_score>=0 and hcahps_consistency_score>=0')
hos_rdd =hc.sql('select * from new_hospitals') 
 
print "\nHere, we show the top 10 hospitals in each category ordered by each of Patient Experience Scores"
print "\n************************************************************************************************"

# Join the  quality RDD with the hospitals data to display the top hospitals
hos_hpq_rdd = hos_rdd.join(hpq_rdd,hos_rdd.provider_id == hpq_rdd.provider_id).drop(hpq_rdd['provider_id'])

print "\n Top 10 - Communication with Nurses"
hos_hpq_rdd.sort('communication_with_nurses_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','communication_with_nurses_dimension_score').show(10)

print "\n Top 10 - Communication with Doctors"
hos_hpq_rdd.sort('communication_with_doctors_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','communication_with_doctors_dimension_score').show(10)

print "\n Top 10 - Responsiveness of Hospital Staff"
hos_hpq_rdd.sort('responsiveness_of_hospital_staff_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','responsiveness_of_hospital_staff_dimension_score').show(10)

print "\n Top 10 - Pain Management Achievement"
hos_hpq_rdd.sort('pain_management_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','pain_management_dimension_score').show(10)

print "\n Top 10 - Communication about medicines"
hos_hpq_rdd.sort('communication_about_medicines_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','communication_about_medicines_dimension_score').show(10)

print "\n Top 10 - Cleanliness and quietness of hospital environment"
hos_hpq_rdd.sort('cleanliness_and_quietness_of_hospital_environment_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','cleanliness_and_quietness_of_hospital_environment_dimension_score').show(10)

print "\n Top 10 - Discharge Information"
hos_hpq_rdd.sort('discharge_information_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','discharge_information_dimension_score').show(10)

print "\n Top 10 - Overall Rating of Hospital"
hos_hpq_rdd.sort('overall_rating_of_hospital_dimension_score',ascending=False).select('provider_id','hospital_name','city','state','overall_rating_of_hospital_dimension_score').show(10)

print "\n Top 10 - HCAHPS Base Score"
hos_hpq_rdd.sort('hcahps_base_score',ascending=False).select('provider_id','hospital_name','city','state','hcahps_base_score').show(10)

print "\n Top 10 - HCAHPS Consistency Score"
hos_hpq_rdd.sort('hcahps_consistency_score',ascending=False).select('provider_id','hospital_name','city','state','hcahps_consistency_score').show(10)
