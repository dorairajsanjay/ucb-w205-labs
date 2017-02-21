#!/bin/bash

set -x

# create folder in hdfs for data
#hdfs dfs -mkdir /user/w205/hospital_compare

# specify list of files to load
files=("hospitals effective_care readmissions measures surveys_responses")
ext=".csv"

# iterate through files and load into hdfs
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
		echo "$line STRING"  | tr ' ' '_' | tr "\r\n" ','>> $outfile
		if [ "$first_time" = false ]; then
			echo "," >> $outfile
		else
			$first_time = false
		fi
	done

    echo ""    >> $outfile
	echo ")\n" >> $outfile

	echo "ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'" >> $outfile
	echo "WITH SERDEPROPERTIES("    >> $outfile
	echo "\"separatorChar\"=\",\"," >> $outfile
	echo "\"quoteChar\"='\"',"      >> $outfile
	echo "\"escapeChar\" = '\\\\'"  >> $outfile
	echo ")"                        >> $outfile
	echo "STORED AS TEXTFILE"       >> $outfile
    echo "LOCATION /user/w205/hospital_compare/$file$ext;" >> $outfile

	mv $outfile fields_$file.txt

	# strip out the column headers
	#tail -n +2 $file > temp.csv; mv temp.csv $file
	
	# move to hdfs
	#hdfs dfs -put $file /user/w205/hospital_compare
done
