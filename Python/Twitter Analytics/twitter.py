#!/usr/bin/python
import tweepy
from tweepy import Stream, OAuthHandler
from tweepy import StreamListener
from progressbar import ProgressBar, Percentage, Bar
import json
import sys

#Twitter app information
consumer_secret='XBbc3Boz0yuCt4KebIwWfWaQ5doxUqM4x5nRnUvLGaHKS0EbWr'
consumer_key='XNeL2PUUEnkwi7eWX6iI4MXtk'
access_token='847092515635376128-dcYTobRnguhx5FnkwTqpFjVyhsZcEoe'
access_token_secret='dmXiD4796QgLTOwVuyiXJD4vIwMI0i5su3DBxIazzdCjs'

#The number of tweets we want to get
max_tweets=10000

#Create the listener class that receives and saves tweets
class listener(StreamListener):
    #On init, set the counter to zero and create a progress bar
    def __init__(self, api=None):
        self.num_tweets = 0
        self.pbar = ProgressBar(widgets=[Percentage(), Bar()], maxval=max_tweets).start()

    #When data is received, do this
    def on_data(self, data):
        #Append the tweet to the 'tweets.txt' file
        with open('tweets.txt', 'a') as tweet_file:
            tweet_file.write(data)
            #Increment the number of tweets
            self.num_tweets += 1
            #Check to see if we have hit max_tweets and exit if so
            if self.num_tweets >= max_tweets:
                self.pbar.finish()
                sys.exit(0)
            else:
                #increment the progress bar
                self.pbar.update(self.num_tweets)
        return True

    #Handle any errors that may occur
    def on_error(self, status):
        print (status)

#Get the OAuth token
auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
#Use the listener class for stream processing
twitterStream = Stream(auth, listener())
#Filter for these topics
twitterStream.filter(track=["azure","cloud","hdinsight"])