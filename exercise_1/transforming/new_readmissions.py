from pyspark import HiveContext
from pyspark import SparkContext
from pyspark.sql.types import IntegerType

sc=SparkContext()

rdd = HiveContext(sc).sql('select provider_id,measure_id,compared_to_national,denominator,score,lower_estimate,higher_estimate,footnote from readmissions')
rdd = rdd.withColumn("denominator",rdd["denominator"].cast(IntegerType()))
rdd = rdd.withColumn("score",rdd["score"].cast(IntegerType()))
rdd = rdd.withColumn("lower_estimate",rdd["lower_estimate"].cast(IntegerType()))
rdd = rdd.withColumn("higher_estimate",rdd["higher_estimate"].cast(IntegerType()))

rdd.write.mode('append').saveAsTable("new_readmissions")
