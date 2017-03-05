(ns tweetcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetcount [options]
   [
    ;; spout configuration
	{"tweet-spout" (python-spout-spec
          options
          "spouts.sentences.Sentences"
          ["sentence"]
          )
    }
	;; parse tweet bolt
	{"parse-tweet-bolt" (python-bolt-spec
          options
          {"tweet-spout" :shuffle}
          "bolts.parse.ParseTweet"
          ["valid_words"]
          :p 2
          )

	;; word count bolt
	"tweetcounter-bolt" (python-bolt-spec
          options
          {"parse-tweet-bolt" :shuffle}
          "bolts.tweetcounter.TweetCounter"
          ["word" "count"]
          :p 1
          )
	}
  ]
)
