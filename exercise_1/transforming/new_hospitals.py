from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType

sc=SparkContext()

rdd = HiveContext(sc).sql('select * from hospitals')

rdd.write.mode('append').saveAsTable("new_hospitals")
