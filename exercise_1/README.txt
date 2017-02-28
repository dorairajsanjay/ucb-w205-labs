#title        : README.txt
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Please read this file for instructions on verifying Exercise 1
#Prerequisites: Existing HDFS installation and access to command line Hive

GitHub Location of Exercise 1: https://github.com/dorairajsanjay/ucb-w205-labs/tree/master/exercise_1

Note that the load_and_modeling folder also contains a file called UcbW205Exercise1Erd.pdf which is the ERD diagram for 
this project

General Notes and Comments
*************************

1. Each sub-folder typically contains clean-up bash script to ensure that binaries and temporary files can be cleaned out before being pushed out to git

Part 1
******

1. cd to load_and_modeling folder
2. Run the below command
   sh load_data_lake.sh

Note that this folder also contains the ERD diagram for this exercise

This command will	
	a) Perform initialization and cleanup of HDFS and local folders
	b) Fetch hospital data from the CMS site
	c) Load CSV files into HDFS
	d) Autogenerate DDL generation script from CSV files header
	e) Execute DDL script to create tables in HDFS via Hive
	f) Perform post processing cleanup

Part 2
******

1. cd to transforming folder
2. Run the below command
	sh transform_tables_in_data_lake.sh

This command will
	a) Perform initialization and cleanup
	b) Extract field definition from export from ERD tool (https://www.lucidchart.com/publicSegments/view/837aeab7-1f26-4024-be9d-a524ebd0d9c5/image.png)
	c) Automated DDL to generate newly transformed tables
	d) Create these tables in HDFS from the DDL
	e) Perform post processing cleanup


PART 3 - Investigations
***********************

1. cd to the inverstigations folder
2. There are four directories here
-> best_hospitals - contains the code needed to list the best hospitals based on their normalized quality score
-> best_states - contains the code needed to list the best states based on their hospital quality score
-> hospital_variability - contains the code needed to list the variability among hospital quality scores
-> hospitals_and_patients - contains the code needed to list the quality of hospitals across each dimension of the HCAHPS score

***Note***: Please ensure you run the hive_base_ddl.sql file in the best_hospitals folder since all subsequent investigation outputs depend on this

