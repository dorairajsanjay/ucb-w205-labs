#title        : new_measures
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Creates the transformed table from the original table
#
#Prerequisites: Original table must be created and accessible in HDFS

from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import DateType

sc=SparkContext()

rdd = HiveContext(sc).sql('select * from measures')

#rdd = rdd.withColumn("measure_start_date",rdd["measure_start_date"].cast(DateType()))
#rdd = rdd.withColumn("measure_end_date",rdd["measure_end_date"].cast(DateType()))

rdd.write.mode('overwrite').saveAsTable("new_measures")
