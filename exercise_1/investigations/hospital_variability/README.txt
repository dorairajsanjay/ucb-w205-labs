Investigation
-------------

Pre-requisite:
1. hive_base_ddl.sql creates a new table to include aggregated hospital
statistics. This table will be the input to determine the set of best
hospitals and best states. This file is present in the
investigations/best_hospitals folder and must be executed at least once to
ensure that the base table is created

Please run the below command to create this aggregate table

hive -f hive_base_ddl.sql

2. The file hospital_variability.py lists out the variability in hospital
scores across all the hospitals

Please run the below command to generate this table

pyspark hospital_variability.py


