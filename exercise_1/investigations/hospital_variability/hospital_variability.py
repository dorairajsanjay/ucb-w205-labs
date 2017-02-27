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

# show a sampling of the results
print "\nSummary Hospital Variability Statistics"
print "\n***************************************"

hq_rdd.toDF(['Provider Id','Overall HCAHPS Score','Effective Care Score','Readmissions Score']).describe().show()

print "ps: Note that these scores have been normalized on a 0-10 scale with increasing scores indicating better scores"
