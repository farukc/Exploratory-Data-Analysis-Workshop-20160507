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
install.packages("quartz")

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


# d3.js
library(rjson)

#convert output from hclust into a nested JSON file

HCtoJSON<-function(hc){
        
        labels<-hc$labels
        merge<-data.frame(hc$merge)
        
        for (i in (1:nrow(merge))) {
                
                if (merge[i,1]<0 & merge[i,2]<0) {eval(parse(text=paste0("node", i, "<-list(name=\"node", i, "\", children=list(list(name=labels[-merge[i,1]]),list(name=labels[-merge[i,2]])))")))}
                else if (merge[i,1]>0 & merge[i,2]<0) {eval(parse(text=paste0("node", i, "<-list(name=\"node", i, "\", children=list(node", merge[i,1], ", list(name=labels[-merge[i,2]])))")))}
                else if (merge[i,1]<0 & merge[i,2]>0) {eval(parse(text=paste0("node", i, "<-list(name=\"node", i, "\", children=list(list(name=labels[-merge[i,1]]), node", merge[i,2],"))")))}
                else if (merge[i,1]>0 & merge[i,2]>0) {eval(parse(text=paste0("node", i, "<-list(name=\"node", i, "\", children=list(node",merge[i,1] , ", node" , merge[i,2]," ))")))}
        }
        
        eval(parse(text=paste0("JSON<-toJSON(node",nrow(merge), ")")))
        
        return(JSON)
}


# wrap nested JSON file into d3 html

D3Dendo<-function(JSON, text=8, height=800, width=700, file_out){
        
        header<-paste0("<!DOCTYPE html>
                 <meta charset=\"utf-8\">
                 <style>
                 
                 .node circle {
                 fill: #fff;
                 stroke: steelblue;
                 stroke-width: 1.5px;
                 }
                 
                 .node {
                 font: ",text , "px sans-serif;
                 }
                 
                 .link {
                 fill: none;
                 stroke: #ccc;
                 stroke-width: 1.5px;
                 }
                 
                 </style>
                 <body>
                 <script src=\"http://d3js.org/d3.v3.min.js\"></script>
                 
                 <script type=\"application/json\" id=\"data\">")
        
        
        footer<-paste0("</script>
  
  
  
  
  <script>
  
  var data = document.getElementById('data').innerHTML;
  root = JSON.parse(data);
  
  
  var width = ", width, ",
  height = ", height, ";
  
  var cluster = d3.layout.cluster()
  .size([height-50, width - 160]);
  
  var diagonal = d3.svg.diagonal()
  .projection(function(d) { return [d.y, d.x]; });
  
  var svg = d3.select(\"body\").append(\"svg\")
  .attr(\"width\", width)
  .attr(\"height\", height)
  .append(\"g\")
  .attr(\"transform\", \"translate(40,0)\");
  
  
  var nodes = cluster.nodes(root),
  links = cluster.links(nodes);
  
  var link = svg.selectAll(\".link\")
  .data(links)
  .enter().append(\"path\")
  .attr(\"class\", \"link\")
  .attr(\"d\", diagonal);
  
  var node = svg.selectAll(\".node\")
  .data(nodes)
  .enter().append(\"g\")
  .attr(\"class\", \"node\")
  .attr(\"transform\", function(d) { return \"translate(\" + d.y + \",\" + d.x + \")\"; })
  
  node.append(\"circle\")
  .attr(\"r\", 4.5);
  
  node.append(\"text\")
  .attr(\"dx\", function(d) { return d.children ? 8 : 8; })
  .attr(\"dy\", function(d) { return d.children ? 20 : 4; })
  .style(\"text-anchor\", function(d) { return d.children ? \"end\" : \"start\"; })
  .text(function(d) { return d.name; });
  
  
  d3.select(self.frameElement).style(\"height\", height + \"px\");
  
  </script>") 
        
        cityDf<-file(file_out)
        writeLines(paste0(header, JSON, footer), cityDf)
        close(cityDf)
        
}



hc <- hclust(dist(cityDf), "ave")
JSON<-HCtoJSON(hc)
D3Dendo(JSON, file_out="output.html")
