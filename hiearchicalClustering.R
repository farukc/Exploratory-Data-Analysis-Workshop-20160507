# create a data frame with two variables
x <- c(2, 4, 7, 8, 23, 27, 31, 32)
y <- c(21, 29, 25, 26, 12, 16, 19, 23)

dat <- data.frame(x=x, y=y)

# plot data
plot(dat)
text(dat$x, dat$y,
     cex = 2,
     col = rgb(0.4, 0.1, 0.1, alpha=0.3))

# calculate the distance between points
dist(dat)

# create a dendogram
hc <- hclust(dist(dat))
plot(hc)

# since we have two variables, we can easily imagine the distance
# by recalling the euclidian geometry.

# let's try to visualize the distance between points in 3 dimensional space
library(rgl)
plot3d(hp, disp, mpg, col="red", size=3)

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
koordinatList  <- readHTMLTable(url)
