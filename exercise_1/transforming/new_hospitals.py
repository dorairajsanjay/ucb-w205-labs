#title        : new_hospitals
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Creates the transformed table from the original table
#
#Prerequisites: Original table must be created and accessible in HDFS

from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType

sc=SparkContext()

rdd = HiveContext(sc).sql('select * from hospitals')

rdd.write.mode('overwrite').saveAsTable("new_hospitals")
