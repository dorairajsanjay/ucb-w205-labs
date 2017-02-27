from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType

sc=SparkContext()

rdd = HiveContext(sc).sql('select provider_id,measure_id,condition,score,sample,footnote from effective_care')
rdd = rdd.withColumn("score",rdd["score"].cast(IntegerType()))
rdd = rdd.withColumn("sample",rdd["sample"].cast(IntegerType()))

rdd.write.mode('overwrite').saveAsTable("new3_effective_care")
