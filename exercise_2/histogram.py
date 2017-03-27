#Sample code snippets for working with psycopg


import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import sys
 
#Connecting to tcount
conn = psycopg2.connect(database="tcount", user="postgres", password="postgres", host="localhost", port="5432")
cur = conn.cursor()

# Get the total number of args passed to the demo.py
total = len(sys.argv)
 
# Get the arguments list 
cmdargs = str(sys.argv)

begincount = sys.argv[1]
endcount   = sys.argv[2]

cur.execute("SELECT word, count from tweetwordcount where count>=%s and count<=%s order by count asc",(begincount,endcount,))
records = cur.fetchall()
	
for rec in records:
	print "word = ", rec[0], " count = ", rec[1] 

conn.close()
