# see how the data looks like
head(mtcars)
head(mtcars, n=4)
tail(mtcars, n=3)

# see random observations
library(dplyr)
sample_n(mtcars, 6)
sample_frac(mtcars, size=0.1)

# see the class of each variable and its contents
str(mtcars)

# see a better version of the structure
glimpse(mtcars)

library(MASS)
# see how large the data set is
dim(cats)

# see the variables in the dataset
colnames(cats)

# five numbers
fivenum(cats$Bwt)

# see the five numbers for all variables
summary(cats)

# see the statistics in visualization
hist(cats$Hwt)
hist(cats$Hwt, breaks=30)
abline(v=mean(cats$Hwt), col = "blue", lwd=3) # see the mean
abline(v=median(cats$Hwt), col = "red", lwd=3) # see the median
rug(cats$Hwt)

# see the statistics with boxplot
boxplot(cats$Bwt, cats$Hwt)
# how to read boxplot: http://flowingdata.com/2008/02/15/how-to-read-and-use-a-box-and-whisker-plot/

# BASE PLOTTING SYSTEM ------
plot(x=mtcars$hp, y=mtcars$mpg)
reg1 <- lm(mpg~hp, data = mtcars)
abline(reg1)
text(x=200, y= 30, "Örnek", col="blue")
title("başlık")

# Some arguments of plot function
x <-1:100
p <- x^2
plot(p,
     main = "Bir örnek",
     xlab = "Yatay Eksen",
     ylab = "Dikey Eksen",
     col = rgb(0.1, 0.3, 0.7, alpha = 0.3),
     pch = 19,
     cex = abs(rnorm(100)))

# GGPLOT2 PLOTTING SYSTEM ------
p <- ggplot(mtcars, aes(x=hp, y=mpg))
p+geom_point()
p+geom_point()+geom_smooth()
p+geom_point()+geom_smooth()+facet_grid(.~cyl)

# adding color as a dimension
ggplot(mtcars, aes(x=hp, y=mpg))+
        geom_point(aes(col=factor(cyl)))

# also add size as a dimension
ggplot(mtcars, aes(x=hp, y=mpg))+
        geom_point(aes(col=factor(cyl), size=gear))

# also add shape and transparency
ggplot(mtcars, aes(x=hp, y=mpg))+
        geom_point(aes(col=factor(cyl), size=gear, alpha=wt))+
        geom_smooth(method="lm", linetype="dashed", se=FALSE)

ggplot(mtcars, aes(x=hp, y=mpg))+
        geom_point(aes(col=factor(cyl), size=gear, alpha=wt))+
        geom_smooth(method="lm", linetype="dashed", se=FALSE)

# what is aestetic mapping: https://bost.ocks.org/mike/nations/

# boxplot in ggplot2
ggplot(mtcars, aes(factor(cyl), wt))+
        geom_boxplot()

ggplot(mtcars, aes(factor(cyl), wt))+
        geom_boxplot(aes(color=factor(cyl)))

ggplot(mtcars, aes(factor(cyl), wt))+
        geom_boxplot(aes(color=factor(cyl)))+
        coord_flip()
