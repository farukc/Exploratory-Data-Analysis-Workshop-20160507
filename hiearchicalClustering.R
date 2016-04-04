# create a data frame with two variables
x <- rnorm(30, mean = c(20, 90, 80), sd = 5)
y <- rnorm(30, mean = c(10, 40, 50), sd = 7)

dat <- data.frame(x=x, y=y)

# plot data
plot(dat)
text(dat$x+1, dat$y+3,
     cex = 1,
     col = rgb(0.4, 0.1, 0.1, alpha=0.7))

# calculate the distance between points
dist(dat)

# create a dendogram
hc <- hclust(dist(dat))
plot(hc)

# since we have two variables, we can easily imagine the distance
# by recalling the euclidian geometry.

# let's try to visualize the distance between points in 3 dimensional space
z <- rnorm(30, mean = c(30, 60, 40), sd = 3)

dat2 <- data.frame(x = x, y = y, z = z)
library(rgl)
plot3d(dat2, col = "red")

# if we have more than 3 variable, we can no longer imagine,
# but we can make calculations.

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
names(cityDf) <- c("sıra", "il", "enlem", "boylam") 

# eliminate first row
rownames(cityDf) <- cityDf[ ,2]
library(dplyr)
cityDf <- select(cityDf, -sıra, -il)


# convert the class of latitute and altitute into numeric
cityDf$enlem <- sub(",", ".", cityDf$enlem)
class(cityDf$enlem) <- "numeric"
cityDf$boylam <- sub(",", ".", cityDf$boylam)
cityDf[4,2] <- 43.021596 # there is a typo error in the origial document. Check Ağrı.
class(cityDf$boylam) <- "numeric"

# now, the data is ready for clustering analysis
dim(cityDf)
cityDist <- dist(cityDf)
hc <- hclust(cityDist)
plot(hc, cex = 0.7)

# change the layout
# install.packages("ape")
library(ape)

# horizontal
plot(as.phylo(hc), cex = 0.7, label.offset = 0.1)

# fan
plot(as.phylo(hc), type = "fan")
