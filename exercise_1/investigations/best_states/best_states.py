from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType
from pyspark.sql.types import FloatType
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

# Normalize scores to avoid any bias resulting in high value
hq_rdd = hq_rdd.map(lambda x: (x[0],int( float(x[1]+x[2])/float(max_hcahps_base_score + max_hcahps_consistency_score)*10),int(float(x[3])/float(max_effective_care_score)*10),int(float(x[4])/float(max_readmissions_score)*10)))
hq_rdd = hq_rdd.map(lambda x:(x[0],int(np.mean(x[1:3])))).toDF(['provider_id','quality_score'])

# Join the  quality RDD with the hospitals data to display the top hospitals
hos_hq_rdd = hos_rdd.join(hq_rdd,hos_rdd.provider_id == hq_rdd.provider_id).drop(hq_rdd['provider_id']).sort('quality_score',ascending=False)

# Listing top 10 hospitals based on their overall quality score
print "\n Displaying 10 hospitals based on their scores"
print "\n *********************************************"
hos_hq_rdd.select('provider_id','hospital_name','city','state','quality_score').show(10)

# Find the best hospitals by state
state_rdd = hos_hq_rdd.groupBy('state').mean().sort('avg(quality_score)',ascending=False)
state_rdd = state_rdd.withColumn("avg(quality_score)",state_rdd["avg(quality_score)"].cast(FloatType()))

# Listing top 10 hospitals based on their overall quality score
print "\n Displaying best hospitals by state"
print "\n **********************************"
state_rdd.show()
