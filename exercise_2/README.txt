In order to run this program, please following the below steps

1. Ensure that you have AWS instance with the UCB-AMI-FULL AMI installed. Verify that postgres is running. If postgres is not running, please follow instructions in Lab2 to get it up and running.

2. Fetch exercise_2 from GitHub available at the following location

https://github.com/dorairajsanjay/ucb-w205-labs/tree/master/exercise_2

The repo can be cloned using the below command

git clone https://github.com/dorairajsanjay/ucb-w205-labs.git

3. Database and table are initialized in postgres using the below commnads from the exercise_2 directory

python initdb.py

4. To capture tweets and write to a database, please follow the below steps.

a). Enter your Twitter authentication credentials in the below files in the location provided

extweetwordcount/src/spout/tweets.py

################################################################################
# Twitter credentials
################################################################################
twitter_credentials = {
	"consumer_key"		:  "your consumer key",
	"consumer_secret"	 : "your consumer secret",
	"access_token"		:  "your access token",
	"access_token_secret" :  "your access token secret"
}

b) Got to the extweetwordcount directory and execute the below command

sparse run

5. To look at the count of words for a particular word, execute the below command from the exercise_2 directory

python finalresults.py <word>

6. To look at all word counts, execute the below command from the exercise_2 directory

python finalresults.py

7. To get an ordered list of all word counts (histogram) between two given counts, execute the below command from the exercise_2 directory

python histogram.py <lower count> <upper count>


