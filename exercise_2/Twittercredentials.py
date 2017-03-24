import tweepy

consumer_key = "c7S0iUHrXJS8HmCWY5v2XmjMj"
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "v5EgUc9hCWSJRo3xS3luDiu3qs8GvBulLYgQ7RVwF08wzIzhcc"
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "4201552152-YWrZnBLfiJbzodHy9hjl8o6TrZsPcfo8vaNRq1A";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "vM98VZkmBTaTK8pq9gLOTiCVFnTpoyHNwSYu46ZRCOPpk";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)
