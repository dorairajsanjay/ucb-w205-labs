#!/bin/bash
#title        : README.txt
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Performs the following operations
#
#   Perform initialization and cleanup of HDFS and local folders
#     b) Fetch hospital data from the CMS site
#     c) Load CSV files into HDFS
#     d) Autogenerate DDL generation script from CSV files header
#     e) Execute DDL script to create tables in HDFS via Hive
#     f) Perform post processing cleanup
#Prerequisites: Existing HDFS installation and access to command line Hive

#set -x

# create folder in hdfs for data

# specify list of files to load
files=("hospitals effective_care readmissions measures surveys_responses")
ext=".csv"
outsqlfile="hive_base_ddl.sql"

init()
{
	echo ""
	echo "*******************************************************"
	echo "            Initialization and Cleanup"
	echo "*******************************************************"
	echo ""

	# local initialization
	echo "Initialization output DDL definition file"
	echo -n "" > $outsqlfile

	# clean up any existing folders with csv files and create a new folder
	echo "Cleaning existing folder for hospital csv files"
	rm -rf ./csvfiles
	mkdir -p ./csvfiles

	# remove existing instance of hospital_compare folder in HDFS
	echo "Removing existing HDFS folder instances for the hospital_compare project"
    for file in $files
    do
        #clear any existing files in hdfs
        hdfs dfs -rm /user/w205/hospital_compare/$file/$file$ext
        hdfs dfs -rmdir /user/w205/hospital_compare/$file
    done
	
	hdfs dfs -rmdir /user/w205/hospital_compare

	echo "******** Cleanup and Initialization complete  *******************"
	echo "hdfs dfs -ls /user/w205/hospital_compare"
	hdfs dfs -ls /user/w205/hospital_compare

	echo "ls -latr"
	ls -latr
	echo ""
	echo "ls -latr csvfiles"
	ls -latr csvfiles

	echo ""
	read -p  "Press any key to continue...."
	echo ""
}

fetch_hospital_files()
{
	echo ""
	echo "*******************************************************"
	echo "            Fetching Hospital data 					 "
	echo "*******************************************************"
	
	# fetch hospital files 
	wget -O Hospital_Revised_Flatfiles.zip "https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip" 

	# unzip to specified folder
	mkdir -p ./csvfiles
	unzip -d ./csvfiles ./Hospital_Revised_Flatfiles.zip

	# rename files
	mv ./csvfiles/"Hospital General Information.csv" ./csvfiles/hospitals.csv
	mv ./csvfiles/"Timely and Effective Care - Hospital.csv" ./csvfiles/effective_care.csv
	mv ./csvfiles/"Readmissions and Deaths - Hospital.csv" ./csvfiles/readmissions.csv
	mv ./csvfiles/"Measure Dates.csv" ./csvfiles/measures.csv
	mv ./csvfiles/"hvbp_hcahps_05_28_2015.csv" ./csvfiles/surveys_responses.csv

	echo "******** Done fetching hospital data *******************"
	echo ""
	echo "Hospital data moved to local folder"

	echo "ls csvfiles"
	ls csvfiles
	echo ""
	read -p  "Press any key to continue...."
	echo ""
}

populate_hdfs()
{
	echo ""
	echo "*******************************************************"
	echo "		Moving files into HDFS"
	echo "*******************************************************"
	echo ""

	# creating root folder for hospital compare files in HDFS
	echo "hdfs dfs -mkdir /user/w205/hospital_compare"
	hdfs dfs -mkdir /user/w205/hospital_compare

	# move files to hdfs
	for file in $files
	do
		# extract fields
		head -1 ./csvfiles/$file$ext > ./csvfiles/fields_$file.txt

		# strip out the column headers
		tail -n +2 ./csvfiles/$file$ext > ./csvfiles/temp.csv; mv ./csvfiles/temp.csv ./csvfiles/$file$ext
		
		# move to hdfs
		hdfs dfs -mkdir /user/w205/hospital_compare/$file

		echo "hdfs dfs -put ./csvfiles/$file$ext /user/w205/hospital_compare/$file"
		hdfs dfs -put ./csvfiles/$file$ext /user/w205/hospital_compare/$file
	
	done

	echo "******** Done moving files into HDFS *******************"
	echo "hdfs dfs -ls /user/w205/hospital_compare"
	hdfs dfs -ls /user/w205/hospital_compare
	echo ""
	read -p  "Press any key to continue...."
	echo ""
}

generate_ddl()
{
	echo ""
	echo "*******************************************************"
	echo "	   Automating generation of DDL from CSV files "
	echo "*******************************************************"
	echo ""
	echo ""

	# initialize out ddl file
	echo "" > $outfile
	echo "" > $outsqlfile

	# generate data definition / table declarationf or hive
	for file in $files 
	do
		# extract the files
   		cat ./csvfiles/fields_$file.txt | tr "\"" " "| tr ',' '\n' | tr "[:upper:]" "[:lower:]" > ./csvfiles/temp.csv; mv ./csvfiles/temp.csv ./csvfiles/fields_$file.txt
	
		outfile="./csvfiles/fields_$file.txt.tmp"

		# drop any existing table with the same name
		echo "DROP TABLE $file;" >> $outfile
		echo "" >> $outfile

		# build definition for table
		echo "CREATE EXTERNAL TABLE $file (" >> $outfile
	
		first_time=true
		cat ./csvfiles/fields_$file.txt | while read line
		do
			echo "$line*STRING"  | tr ' ' '_' | tr "\r\n" ',' | tr '*' ' ' >> $outfile
		done
	
		echo -e "\b \b"
		echo ""
		echo ")" >> $outfile
	
		echo "ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'" >> $outfile
		echo "WITH SERDEPROPERTIES("    >> $outfile
		echo "\"separatorChar\"=\",\"," >> $outfile
		echo "\"quoteChar\"='\"',"      >> $outfile
		echo "\"escapeChar\" = '\\\\'"  >> $outfile
		echo ")"                        >> $outfile
		echo "STORED AS TEXTFILE"       >> $outfile
		echo "LOCATION '/user/w205/hospital_compare/$file';" >> $outfile
	
		cat $outfile>>$outsqlfile
		echo "">>$outsqlfile

		# comment out creation of individual ddl files 
		mv $outfile ./csvfiles/fields_$file.txt

		# perform post processing clean-up on sql file and outfile
		sed -i "s/_ STRING/ STRING/g"    $outsqlfile
		sed -i "s/_ STRING/ STRING/g"    ./csvfiles/fields_$file.txt
		sed -i "s/, STRING,)/ STRING)/g" $outsqlfile
		sed -i "s/, STRING,)/ STRING)/g" ./csvfiles/fields_$file.txt
	done

    echo "******** Completed auto-generation of DDL for hospital data *******************"
    echo ""
	cat ./hive_base_ddl.sql
	echo ""
    read -p  "Press any key to continue...."

}

initialize_tables_in_hdfs()
{
	echo ""
	echo "*******************************************************"
	echo "	   Automating generation of DDL from CSV files "
	echo "*******************************************************"
	echo ""

	echo "hive -f ./hive_base_ddl.sql"
	hive -f ./hive_base_ddl.sql

    echo "******** Completed creating tables via Hive *******************"
    echo ""
    read -p  "Press any key to continue...."
}

cleanup()
{
	echo ""
	echo "*******************************************************"
	echo "	   Automating generation of DDL from CSV files "
	echo "*******************************************************"

	# clean temperorary files created
	echo "rm temp*"
	rm ./csvfiles/temp*

    echo "******** Completed creating tables via Hive *******************"
    echo ""
	echo "END SCRIPT RUN..."
	echo ""


}

#cleanup and initialization
init

#fetch hospital files
fetch_hospital_files

# populate into HDFS
populate_hdfs

# autoated DDL gneeration
generate_ddl

# initialize tables in HDFS
initialize_tables_in_hdfs

# run the DDL and move tables into HDFS via Hive
cleanup

