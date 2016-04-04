# GETTING DATA FROM TWITTER #####

# install.packages("twitteR")
library(twitteR)

consumer_key <- ""
consumer_secret <- ""
access_token <- "389497846-"
access_secret <- ""

# authentication
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# harvest tweets
simit <- searchTwitter("simit", n=500)
simitDf <- twListToDF(simit)

# locations
library(dplyr)
loc <- select(simitDf, text, latitude, longitude)
loc <- loc[complete.cases(loc),]
class(loc$latitude) <- "numeric"
class(loc$longitude) <- "numeric"

# visualize
qmplot(longitude, latitude, data = loc, colour = I("red"), size = I(3), darken = .3, maptype = "toner")


# GETTING DATA FROM GOOGLE ANALYTICS #####

# installation
# install.packages("RGA")
library(RGA)
authorize()
accountId <- 00000000
profiles <- list_profiles(accountId)
id <- 00000000 # your id here

# source report
sourceReport <- get_ga(id, start.date = "2015-01-01", end.date = "yesterday",
                       metrics = "ga:sessions",
                       dimensions = "ga:sourceMedium, ga:pageTitle")

library(googleVis)
sk1 <- gvisSankey(sourceReport, from="sourceMedium", to="pageTitle", weight="sessions")
plot(sk1)

# FINANCIAL DATA #####

library(quantmod)
getSymbols("TSLA") # Tesla Motors Stock
chartSeries(TSLA)

# WORLD DEVELOPMENT INDICATORS #####

library(WDI)
indicatorList <- WDIsearch()
gdpPerCapita2014 <- WDI(country = "all", indicator = "NY.GDP.PCAP.CD", start = 2014, end= 2014)

library(dplyr)
gdpPerCapita2014 <- arrange(gdpPerCapita2014, desc(NY.GDP.PCAP.CD))

library(plotly)
p <- plot_ly(
        x = gdpPerCapita2014$iso2c,
        y = gdpPerCapita2014$NY.GDP.PCAP.CD,,
        type = "bar"
)
p
