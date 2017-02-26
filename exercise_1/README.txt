#title        : README.txt
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Please read this file for instructions on verifying Exercise 1
#Prerequisites: Existing HDFS installation and access to command line Hive

GitHub Location of Exercise 1: https://github.com/dorairajsanjay/ucb-w205-labs/tree/master/exercise_1

Note that the load_and_modeling folder also contains a file called UcbW205Exercise1Erd.pdf which is the ERD diagram for 
this project

Part 1
******

1. cd to load_and_modeling folder
2. Run the below command
   sh load_data_lake.sh

This command will	
	a) Perform initialization and cleanup of HDFS and local folders
	b) Fetch hospital data from the CMS site
	c) Load CSV files into HDFS
	d) Autogenerate DDL generation script from CSV files header
	e) Execute DDL script to create tables in HDFS via Hive
	f) Perform post processing cleanup
