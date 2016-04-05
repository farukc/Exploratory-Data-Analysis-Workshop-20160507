## GETTING DATA FROM SPREADSHEETS, TEXT FILES, AND WEB ######

# Example 1: Pisa Scores #####

# file url to be downloaded
url <- "https://stats.oecd.org/sdmx-json/data/DP_LIVE/.PISAMATH.GIRL+BOY../OECD?contentType=csv&detail=code&separator=comma&csv-lang=en"

# download file
if(!file.exists("pisa.csv")) {
        download.file(url, destfile = "pisa.csv")
}

# load file
pisaData <- read.csv("pisa.csv", stringsAsFactors = FALSE)
pisaData <- pisaData[ ,1:7]
names(pisaData) <- c("location", "indicator", "subject", "measure", "frequency", "time", "value")

# Example 2: Common Turkish Names #####

# getting the data from TUIK (Turkish Statistics Institute)
maleURL <- "http://tuik.gov.tr/PreIstatistikTablo.do?istab_id=1332"
femaleURL <- "http://tuik.gov.tr/PreIstatistikTablo.do?istab_id=1331"

# download files
if(!file.exists("male.xls")){
        download.file(maleURL, destfile = "male.xls") 
}

if(!file.exists("female.xls")){
        download.file(femaleURL, destfile = "female.xls") 
}

# load data into R
library(xlsx)
maleNames <- read.xlsx("male.xls", sheetIndex = 1, header = FALSE)
femaleNames <- read.xlsx("female.xls", sheetIndex = 1, header = FALSE)

# Example 3: Getting Data from Web #####
library(XML)
url <- "http://www.beycan.net/1057/illerin-enlem-ve-boylamlari.html"
cityList <- readHTMLTable(url, header = TRUE, colClasses = "character")
cityDf <- as.data.frame(cityList, stringAsFactors = FALSE)
names(cityDf) <- c("sıra", "il", "enlem", "boylam") 
