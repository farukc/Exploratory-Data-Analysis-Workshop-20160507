# GETTING DATA FROM SPREADSHEETS, TEXT FILES, AND WEB -----

# 1. Getting data from flat files -----

# file url to be downloaded
url <- "https://stats.oecd.org/sdmx-json/data/DP_LIVE/.PISAMATH.GIRL+BOY../OECD?contentType=csv&detail=code&separator=comma&csv-lang=en"

# download file
if(!file.exists("pisa.csv")) {
        download.file(url, destfile = "pisa.csv")
}

# load file
pisaData <- read.csv("pisa.csv", stringsAsFactors = FALSE)

# 1. Getting data from spreadsheet files -----

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
# install.packages("readxl")
library(readxl)
maleNames <- read_excel("male.xls", sheet=1)
femaleNames <- read_excel("female.xls", sheet = 1)

# Example 3: Getting Data from Web -----
library(XML)
locUrl <- "http://www.beycan.net/1057/illerin-enlem-ve-boylamlari.html"
cityList <- readHTMLTable(locUrl, header = TRUE, colClasses = "character")
cityDf <- as.data.frame(cityList, stringAsFactors = FALSE)
