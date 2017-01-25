library(twitteR)
library(RCurl)
library(stringr)
library(jsonlite)

# Declare Twitter API Credentials
api_key <- "a5Zo2dQQsGFlkqooxbnJkYvGS" 
api_secret <- "LuAtcckSOjzyanjAiujKF8asZuAvPydscSdzJeMpnUANOgB9Z2"
token <- "35434673-UHAn0yG1awxHlomxlE0AqrUPQrnOegydmEYRDkHfv" 
token_secret <- "ZKodOdUaNLyjvIfyZnm73n2nY3pGTgh2G4oJiaVNJ35cU"

# Create Twitter Connection
setup_twitter_oauth(api_key, api_secret, token, token_secret)

tweets <- searchTwitter("apartment rentals", n=1000, lang="en", since="2016-01-01")

tweets.df <- twListToDF(tweets)

x <- iconv(toJSON(tweets.df), to = "UTF8")
fileConn<-file("C:/Users/Abhijeet/Desktop/DIC/Code/RealDirect/RD_9.json")
writeLines(c(x), fileConn)
close(fileConn)