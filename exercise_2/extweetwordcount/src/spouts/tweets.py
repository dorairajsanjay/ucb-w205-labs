from __future__ import absolute_import, print_function, unicode_literals

import itertools, time
import tweepy, copy
import Queue, threading
import simplejson
from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
import simplejson

from streamparse.spout import Spout

################################################################################
# Twitter credentials
################################################################################
twitter_credentials = {
	"consumer_key"		:  "your consumer key",
	"consumer_secret"	 : "your consumer secret",
	"access_token"		:  "your access token",
	"access_token_secret" :  "your access token secret"
}

def auth_get(auth_key):
	if auth_key in twitter_credentials:
		return twitter_credentials[auth_key]
	return None

################################################################################
# Class to listen and act on the incoming tweets
################################################################################
class TweetStreamListener(tweepy.StreamListener):

	def __init__(self,listener):
		self.listener = listener;
		super(self.__class__,self).__init__(listener.tweepy_api())

#	def on_status(self,status):
#		self.listener.queue().put(status.text, timeout = 0.01)
#
#		# Log the count - just to see the topology running
#		#self.log('in-spout-tweet-on_status: %s' % (status.text))
##
#		return True

	def on_data(self, data):
		try:
			self.dataJson =simplejson.loads(data[:-1])
			self.dataJsonText = self.dataJson["text"].lower()
			self.listener.queue().put(self.dataJsonText,timeout = 0.01)

		except KeyError:
			pass

		# Log the count - just to see the topology running
		#self.log('in-spout-tweet-on_data: %s' % (self.dataJsonText))

		return True

	def on_error(self, status):
		return True # keep stream alive

	def on_limit(self,track):
		return True # keep stream alive

class Tweets(Spout):

	def initialize(self, stormconf, context):
		self._queue = Queue.Queue(maxsize = 100)

		consumer_key = auth_get("consumer_key")
		consumer_secret = auth_get("consumer_secret")
		auth = tweepy.OAuthHandler(consumer_key, consumer_secret)

		if auth_get("access_token") and auth_get("access_token_secret"):
			access_token = auth_get("access_token")
			access_token_secret = auth_get("access_token_secret")
			auth.set_access_token(access_token, access_token_secret)

		self._tweepy_api = tweepy.API(auth)

		# Create the listener for twitter stream
		listener = TweetStreamListener(self)

		# Create the stream and listen for english tweets
		stream = tweepy.Stream(auth, listener, timeout=None)
		stream.filter(languages=["en"], track=["a", "the", "i", "you", "u"],async=True)
		#stream.filter(async=True)

	def queue(self):
		return self._queue

	def tweepy_api(self):
		return self._tweepy_api

	def next_tuple(self):
		try:
			tweet = self.queue().get(timeout = 1)
			if tweet:
				self.queue().task_done()
				self.emit([tweet])

		except Queue.Empty:
			self.log("Empty queue exception ")
			time.sleep(0.1)

	def ack(self, tup_id):
		pass  # if a tuple is processed properly, do nothing

	def fail(self, tup_id):
		pass  # if a tuple fails to process, do nothing
