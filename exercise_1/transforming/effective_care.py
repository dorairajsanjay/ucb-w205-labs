from pyspark import HiveContext

rdd = HiveContext(sc).sql('select provider_id,measure_id,condition,score,sample,footnote from effective_care')
rdd = rdd.withColumn("score",rdd["score"].cast(IntegerType()))
rdd = rdd.withColumn("sample",rdd["sample"].cast(IntegerType())
