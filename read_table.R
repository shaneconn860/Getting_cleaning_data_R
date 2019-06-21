library(dplyr)
library(data.table)

#Download files

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./Directory/gdp.csv")
gdp <- fread("./Directory/gdp.csv",
                skip=8, nrows = 191, select = c(1, 2, 4, 5),
                col.names=c("CountryCode", "Rank", "Economy", "Total"))

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./Directory/edu.csv")
edu <- fread("./Directory/edu.csv")

#Merge 2 files together by countrycode
mergedDT <- merge(gdp, edu, by = 'CountryCode')

#Find number of rows
nrow(mergedDT)

#Sort the data frame in descending order by GDP rank (so United States is last). 
#What is the 13th country in the resulting data frame?

order <- mergedDT[order(-Rank)][13,.(Economy)]

#What is the average GDP ranking for the "High income: OECD" 
#and "High income: nonOECD" group?


nonoecd <- filter(mergedDT, `Income Group` == "High income: nonOECD")
mean(nonoecd$Rank)

oecd <- filter(mergedDT, `Income Group` == "High income: OECD")
mean(oecd$Rank)


              
#Load Hmisc library to use cut2 function
library(Hmisc)

## Cut Ranks into 5 groups and store as factor variable
mergedDT$Rank.Groups = cut2(mergedDT$Rank, g = 5)

## Build a table of Income Groups across Rank Groups
table(mergedDT$Income.Group, mergedDT$Rank.Groups)