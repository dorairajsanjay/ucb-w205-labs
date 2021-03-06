#title        : new_best_hospitals
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Retrieves the best hospitals
#
#Prerequisites: Base tables must be created and accessible in HDFS

from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType
import numpy as np


sc=SparkContext()
hc=HiveContext(sc)

# Create 2 RDDs from tables - one involving aggregated results on hospital quality and other involving hospital data
hq_rdd  =hc.sql('select * from hospital_quality_consolidated where hcahps_base_score>=0 and hcahps_consistency_score>=0 and eff_score>=0 and readm_score>=0')
hos_rdd =hc.sql('select * from new_hospitals') 
 
# Compute max values from the quality RDD
max_hcahps_base_score        = hq_rdd.agg({"hcahps_base_score" :"max"}).collect()[0][0]
max_hcahps_consistency_score = hq_rdd.agg({"hcahps_consistency_score" :"max"}).collect()[0][0]
max_effective_care_score     = hq_rdd.agg({"eff_score" :"max"}).collect()[0][0] 
max_readmissions_score       = hq_rdd.agg({"readm_score" :"max"}).collect()[0][0]

# show a sampling of the results
print "\nSample of results before normalization"
hq_rdd.show(10)

# Normalize scores to avoid any bias resulting in high value
hq_rdd = hq_rdd.map(lambda x: (x[0],int( float(x[1]+x[2])/float(max_hcahps_base_score + max_hcahps_consistency_score)*10),int(float(x[3])/float(max_effective_care_score)*10),int(float(x[4])/float(max_readmissions_score)*10)))
hq_rdd = hq_rdd.map(lambda x:(x[0], int(np.mean(x[1:3])),int(np.sum(x[1:3])))).toDF(['provider_id','avg_quality_score','agg_quality_score'])

# show a sampling of the results
print "\nSample of results in the normalized table"
print "\nNormalization involves mapping the score between 0 and 10 and for readmissions"
print "\nwhere lower scors are better subtracting from 10 to allow higher values to denote better quaity"
hq_rdd.show(10)

# Join the  quality RDD with the hospitals data to display the top hospitals
hos_hq_rdd = hos_rdd.join(hq_rdd,hos_rdd.provider_id == hq_rdd.provider_id).drop(hq_rdd['provider_id']).sort('avg_quality_score',ascending=False)

# Listing top 10 hospitals based on their overall quality score
print "\n Displaying 10 hospitals based on their scores, average and aggregate scores"
print "\n ***************************************************************************"
hos_hq_rdd.select('provider_id','hospital_name','city','state','avg_quality_score','agg_quality_score').show(10)

print "\n Displaying variability in hospital scores"
print "\n *****************************************"
hos_hq_rdd.describe().show()


