#!/bin/bash
#title        : clean_transforming.sh
#author       : Sanjay Dorairaj
#date         : Feb 23rd 2017
#Description  : Performs the following operations
# Cleans any temporary files/artifacts from the transformation process
#

rm -rf csvfiles/
rm  hive_base_ddl.sql
rm -rf tmp/
rm hs_err_pid*
