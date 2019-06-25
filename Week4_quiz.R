library(data.table)

#Question 2

#Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

#Create directory if it doesn't exist

if (!file.exists("./data")) {
        dir.create("./data")
}

#Download file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/gdp.csv", method = "curl")
gdp <- fread("./data/gdp.csv",
             skip=5, nrows = 190, select = c(1, 2, 4, 5),
             stringsAsFactors = F, header = F,
             col.names=c("CountryCode", "Rank", "Economy", "Total"))


#Remove the commas from the GDP numbers in millions of dollars and average them. 
#What is the average?

remove_comma <- gsub(",", "", gdp$Total)
mean(as.numeric(remove_comma))

#Alternative way
mean(as.numeric (gsub(",", "", gdp$Total)))


#Question 3

#In the data set from Question 2 what is a regular expression that would allow you 
#to count the number of countries whose name begins with "United"? 
#Assume that the variable with the country names in it is named countryNames. 
#How many countries begin with United?

grep("United", gdp$Economy, value=TRUE)
grep("^United",gdp$Economy,value=TRUE)


#Question 4

#Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

#Load the educational data from this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv


#Second dataset, first already loaded above
edu  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
eduFile <- "./data/EDU.csv"
download.file(edu, eduFile, method = "curl")

edu <- read.csv(eduFile, stringsAsFactors = F)
edu <- edu[, c("CountryCode", "Special.Notes")]

#Match the data based on the country shortcode. 
mergedData <- merge(gdp, edu, as.x = "CountryCode", as.y = "CountryCode")

#Of the countries for which the end of the fiscal year is available, 
#how many end in June?
length(grep("[Ff]iscal year end(.*)+June", mergedData$Special.Notes))


#Question 5

#You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices 
#for publicly traded companies on the NASDAQ and NYSE. 
#Use the following code to download data on Amazon's stock price and get the times the data was sampled.


library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)


#How many values were collected in 2012? 
#How many values were collected on Mondays in 2012?

library(lubridate)

## Subset observations made in 2012
Y2012 <- subset(sampleTimes, year(sampleTimes) == 2012)
length(Y2012) 

## Find out number of Mondays in this subset
length(which(wday(Y2012, label = T) == "Mon"))

