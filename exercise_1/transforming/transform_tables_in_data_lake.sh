#!/bin/bash
#title        : transform_tables_in_data_lake.sh
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Performs the following operations
#
#	Convert SQL CREATE TABLE SYNTAX to hive CREATE TABLE COMMANDS
#Prerequisites: Existing HDFS installation and access to command line Hive

#set -x

# specify list of files to load
files=("hospitals effective_care readmissions measures surveys_responses")
ext=".txt"
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

	echo ""
	read -p  "Press any key to continue...."
	echo ""
}

extract_headers_from_ERD()
{
    echo ""
    echo "*************************************************************"
    echo "  Extracting transformed table headers from ERD tool export"
    echo "*************************************************************"
    echo ""

	# command to extract field headers sql create table syntax
	cat ./transformed_table_syntax.txt |egrep -v '(CREATE|\);)' | tr '\"' ' ' | sed s/"(Primary Key)"//g | tr '\n' '%' | sed s/"%%"/"\n"/g | tr '%' ' ' | sed s/"    "//g |while read -r l; do echo $l > "text$((++i)).txt";done

	# move split files to corresponding metadata CSV files
	mkdir -p csvfiles
	mv text1.txt csvfiles/fields_surveys_responses.txt
	mv text2.txt csvfiles/fields_hospitals.txt
	mv text3.txt csvfiles/fields_readmissions.txt
	mv text4.txt csvfiles/fields_measures.txt
	mv text5.txt csvfiles/fields_effective_care.txt

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
	#echo "" > $outfile
	echo "" > $outsqlfile

	# generate data definition / table declarationf or hive
	for file in $files 
	do
		# extract the files
   		cat ./csvfiles/fields_$file.txt | tr "\"" " "| tr ',' '\n' | tr "[:upper:]" "[:lower:]" > ./csvfiles/temp.csv; mv ./csvfiles/temp.csv ./csvfiles/fields_$file.txt
	
		outfile="./csvfiles/fields_$file.txt.tmp"

		# drop any existing table with the same name
		echo "DROP TABLE new_$file;" >> $outfile
		echo "" >> $outfile

		# build definition for table
		echo "CREATE TABLE new_$file (" >> $outfile
	
		first_time=true
		cat ./csvfiles/fields_$file.txt | while read line
		do
			echo "$line"  |  tr "\r\n" ',' | tr '*' ' ' >> $outfile
		done
	
		echo -e "\b \b"
		echo ""
		echo ")" >> $outfile
	
		echo "ROW FORMAT DELIMITED" >> $outfile
		echo "FIELDS TERMINATED BY ','" >> $outfile
		echo "LINES TERMINATED BY '\n'" >> $outfile
		#echo "ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'" >> $outfile
		#echo "WITH SERDEPROPERTIES("    >> $outfile
		#echo "\"separatorChar\"=\",\"," >> $outfile
		#echo "\"quoteChar\"='\"',"      >> $outfile
		#echo "\"escapeChar\" = '\\\\'"  >> $outfile
		#echo ")"                        >> $outfile
		echo "STORED AS TEXTFILE;"       >> $outfile
		#echo "LOCATION '/user/w205/hospital_compare/$file';" >> $outfile
	
		cat $outfile>>$outsqlfile
		echo "">>$outsqlfile

		# comment out creation of individual ddl files 
		mv $outfile ./csvfiles/fields_$file.txt

		# perform post processing clean-up on sql file and outfile
		sed -i "s/,)/)/g" $outsqlfile
		sed -i "s/,)/)/g" ./csvfiles/fields_$file.txt
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
    echo "     Automating generation of DDL from CSV files "
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
	echo "	   Cleanup of temporary files and artifacts"
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

#extract transformed headers from ER diagram tool export
extract_headers_from_ERD

# autoated DDL gneeration
generate_ddl

# initialize tables in HDFS
initialize_tables_in_hdfs

# transform tables using pyspark
pyspark new_hospitals.py
pyspark new_effective_care.py
pyspark new_readmissions.py
pyspark new_measures.py
pyspark new_surveys_responses.py

# run the DDL and move tables into HDFS via Hive
cleanup

