#!/bin/bash

set -x

# create folder in hdfs for data
#hdfs dfs -mkdir /user/w205/hospital_compare

# specify list of files to load
files=("hospitals effective_care readmissions measures surveys_responses")
ext=".csv"
outsqlfile="hive_base_ddl.sql"

init()
{
	echo "Initialization..."

	# local initialization
	echo -n "" > $outsqlfile

}

populate_hdfs()
{
	echo "Moving files into HDFS..."
	echo "Note that existing files will be deleted"
	echo ""

	# move files to hdfs
	for file in $files
	do
		#clear any existing files in hdfs
		hdfs dfs -rm /user/w205/hospital_compare/$file/$file$ext	
		hdfs dfs -rmdir /user/w205/hospital_compare/$file

		# strip out the column headers
		tail -n +2 $file$ext > temp.csv; mv temp.csv $file
		
		# move to hdfs
		hdfs dfs -mkdir /user/w205/hospital_compare/$file
		hdfs dfs -put $file$ext /user/w205/hospital_compare/$file
	
	done
}

generate_ddl()
{
	echo "Generate data definition"
	echo "Individual table DDL are moved to corresponding txt files and consolidated DDL is moved into .sql file"
	echo ""

	# generate data definition / table declarationf or hive
	for file in $files 
	do
		# extract the files
		head -1 $file$ext > fields_$file.txt
   		cat fields_$file.txt | tr "\"" " "| tr ',' '\n' | tr "[:upper:]" "[:lower:]" > temp.csv; mv temp.csv fields_$file.txt
	
		outfile="fields_$file.txt.tmp"
		echo "CREATE EXTERNAL TABLE fields_$file (" > $outfile
	
		first_time=true
		cat fields_$file.txt | while read line
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

		mv $outfile fields_$file.txt

		# perform post processing clean-up on sql file and outfile
		sed -i "s/_ STRING/ STRING/g"    $outsqlfile
		sed -i "s/_ STRING/ STRING/g"    fields_$file.txt
		sed -i "s/, STRING,)/ STRING)/g" $outsqlfile
		sed -i "s/, STRING,)/ STRING)/g" fields_$file.txt
	done

}

init
#populate_hdfs
generate_ddl
