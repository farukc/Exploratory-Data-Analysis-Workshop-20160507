# 1. HIEARCHICAL CLUSTERING -----
# create a data frame with two variables
set.seed(1010)
x <- rnorm(20, mean = c(20, 90, 80), sd = 5)
y <- rnorm(20, mean = c(10, 40, 50), sd = 7)

dat <- data.frame(x=x, y=y)

# plot data
plot(dat, cex=3, col=rgb(0.1,0.2,0.3, alpha=0.4), pch=19)
text(dat$x, dat$y,
     cex = 0.6)

# calculate the distance between points
dist(dat)

# create a dendogram
hc <- hclust(dist(dat))
plot(hc)

# since we have two variables, we can easily imagine the distance
# by recalling the euclidian geometry.

# let's try to visualize the distance between points in 3 dimensional space
z <- rnorm(20, mean = c(30, 60, 40), sd = 3)

dat2 <- data.frame(x = x, y = y, z = z)
library(rgl)
plot3d(dat2, col = "red")

# if we have more than 3 variable, we can no longer imagine,
# but we can make calculations.

# Euclidian vs Manhattan Distance
# https://qph.is.quoracdn.net/main-qimg-e73d01f18d0b4a2f57ff2206a3863c10?convert_to_webp=true

# examine the mtcars data set
head(mtcars)
dim(mtcars)

# distance between points
distance <- dist(mtcars)
hc <- hclust(distance)
plot(hc)

# now, harvest some data from web
library(XML)
url <- "http://www.beycan.net/1057/illerin-enlem-ve-boylamlari.html"
cityList <- readHTMLTable(url, header = TRUE, colClasses = "character")

# convert the data into a data frame structure
cityDf <- as.data.frame(cityList, stringAsFactors = FALSE)
rownames(cityDf) <- cityDf[,2]
cityDf <- cityDf[,3:4]
names(cityDf) <- c("lat", "lon") 

# convert the class of latitute and altitute into numeric
cityDf$lat <- sub(",", ".", cityDf$lat)
class(cityDf$lat) <- "numeric"
cityDf$lon <- sub(",", ".", cityDf$lon)
class(cityDf$lon) <- "numeric"

# now, the data is ready for clustering analysis
dim(cityDf)
cityDist <- dist(cityDf)
hc <- hclust(cityDist)
plot(hc, cex = 0.7)

cityDf[4,2] <- 43.021596 # there is a typo error in the origial document. Check Ağrı.

# change the layout
# install.packages("ape")
library(ape)

# horizontal
plot(as.phylo(hc), cex = 0.7, label.offset = 0.1)

# fan
plot(as.phylo(hc), type = "fan")

# 1. K MEANS CLUSTERING -----

# Animation: https://www.youtube.com/watch?v=BVFG7fd1H30
ucBoyut <- kmeans(dat2, centers = 3)
plot3d(dat2, col = ucBoyut$cluster)

sehirKumeleri <- kmeans(cityDf, centers=7)

turkiye <- get_map(location = "turkey", source = 'stamen', maptype = 'toner', zoom=5)

ggmap(turkiye) +
        geom_point(size=5, alpha = 3/4, aes(lon,lat, color=factor(sehirKumeleri$cluster)), data=cityDf) 

# A good example of clustering with time series: http://www.hanselsolutions.com/blog/clustering-time-series.html
