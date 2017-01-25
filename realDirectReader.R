library(jsonlite)
library(ggplot2)
library(maps)

tweetData=fromJSON('RD_10.json', flatten=TRUE)

tweets <- list()
pattern <- "NYC|New York City|New York"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
nycDataFrame <- data.frame("new york", matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(nycDataFrame)[1] <- "State"
colnames(nycDataFrame)[2] <- "Tweets"


tweets <- list()
pattern <- "LA|Los Angeles|San Francisco|California"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
caliDataFrame <- data.frame("california", matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(caliDataFrame)[1] <- "State"
colnames(caliDataFrame)[2] <- "Tweets"

tweets <- list()
pattern <- "Chicago|Illinois"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
chicagoDataFrame <- data.frame("illinois",matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(chicagoDataFrame)[1] <- "State"
colnames(chicagoDataFrame)[2] <- "Tweets"

tweets <- list()
pattern <- "Austin|Texas"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
texasDataFrame <- data.frame("texas",matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(texasDataFrame)[1] <- "State"
colnames(texasDataFrame)[2] <- "Tweets"

tweets <- list()
pattern <- "Philadelphia|Pennsylvania"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
philyDataFrame <- data.frame("pennsylvania",matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(philyDataFrame)[1] <- "State"
colnames(philyDataFrame)[2] <- "Tweets"


tweets <- list()
pattern <- "Boston|Massachusetts"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
bostonDataFrame <- data.frame("massachusetts",matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(bostonDataFrame)[1] <- "State"
colnames(bostonDataFrame)[2] <- "Tweets"

tweets <- list()
pattern <- "Seattle|Washington"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
seattleDataFrame <- data.frame("washington",matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(seattleDataFrame)[1] <- "State"
colnames(seattleDataFrame)[2] <- "Tweets"

tweets <- list()
pattern <- "Newark|Jersey City|Hoboken|New Jersey"
tweetNumbers = data.frame(grep(pattern, tweetData$text))
tweets <- c(tweets,nrow(tweetNumbers))
jerseyDataFrame <- data.frame("new jersey",matrix(unlist(tweets), nrow=1, byrow=T),stringsAsFactors=FALSE)
colnames(jerseyDataFrame)[1] <- "State"
colnames(jerseyDataFrame)[2] <- "Tweets"

all_states <- map_data("state")
total <- rbind(bostonDataFrame, caliDataFrame, chicagoDataFrame, jerseyDataFrame,
               nycDataFrame, philyDataFrame, seattleDataFrame, texasDataFrame)
total$region <- total$State
total <- merge(all_states, total, by="region", all = TRUE)


ggplot(total, aes(map_id = region)) + 
    geom_map(aes(fill = total$Tweets), map = all_states) +
    scale_fill_continuous(low = "lightblue", high = "blue", guide="colorbar") + 
    expand_limits(x = all_states$long, y = all_states$lat)

