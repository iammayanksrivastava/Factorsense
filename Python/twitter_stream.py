#Import Libraries
import time
import sys
import codecs
import json
from tweepy import Stream
from tweepy.streaming import StreamListener
from tweepy import OAuthHandler

#Credentials
consumer_key = ''
consumer_secret = ''
access_token = ''
access_secret = ''

#Prevent Encoding Errors
sys.stdout = codecs.getwriter('utf8')(sys.stdout)

#Input file for
filename = raw_input("\n Enter the name of output file:")


#Information for the user:
print "Please wait. Connecting and authenticating now..."
print "#########################################################################"
print "Please note that search keywords are hard-wired until further"
print "notice. If you want to change them, you will have to open the program"
print "file and change them there!"
print "#########################################################################\n"

class listener(StreamListener):

    def on_data(self, data):
        try:
            jsonData = json.loads(data)

            createdAt = jsonData['created_at']
            text = jsonData['text']
            saveThis = createdAt+'=>' +text

            print savethis

            saveFile = open(filename+' .csv', 'a')

            saveFile.write(saveThis.encode('utf8'))
            saveFile.write('\n')
            saveFile.close()
            return True

        except BaseException, e:
            print 'failed ondata,  ', str(e)
            time.sleep(5)

def on_error(self, status):
    print status

# The meat of the script, authentication first, then streaming
auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)

tweez = Stream(auth, listener())

tweez.filter(track=['atradius'])
