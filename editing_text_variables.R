download_csv <- function() {


#Create directory first

if (!file.exists("./data")) {
        dir.create("./data")
        }

#Download file
        
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/idaho.csv")
idaho <- read.csv("./data/idaho.csv")
}

#Sets all column names (headers) to lowercase
tolower(names(idaho))

#Splits headers if they have a . in them
splitnames = strsplit(names(idaho), "\\.")
splitnames[6]

#Split so that only 1st element of 6th header remains, eg, Location
splitnames[[6]][1]

#Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
#What is the value of the 123 element of the resulting list?


strsplit(names(idaho), "\\wgtp")[123]

#sub and gsub perform replacement of the first and all matches respectively

#Removes the first T from the column headers (names)
sub("T", "", names(idaho),)

#Removes all instances of H found
gsub("H", "", names(idaho))

#Searches for a particular word/pattern in this columns
grep("Alameda", idaho$intersection, value=TRUE)

#Returns a logical table to show results (True/False)
table(grepl("Alameda", idaho$intersection))

#Check how many characters in a string
library(stringr)
nchar("Shane Connaughton")

#Subset string to return values 1-5, eg, Shane
substr("Shane Conn", 1, 5)

#Paste/Join 2 strings together
paste("Shane", "Conn")

#Paste/Join 2 strings together, without spaces
paste0("Shane", "Conn")
