#title        : new_effective_care
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Creates the transformed table from the original table
#
#Prerequisites: Original table must be created and accessible in HDFS

from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType

sc=SparkContext()

rdd = HiveContext(sc).sql('select provider_id,measure_id,condition,score,sample,footnote from effective_care')
rdd = rdd.withColumn("score",rdd["score"].cast(IntegerType()))
rdd = rdd.withColumn("sample",rdd["sample"].cast(IntegerType()))

rdd.write.mode('overwrite').saveAsTable("new_effective_care")
