#Create directory first

if (!file.exists("./data")) {
  dir.create("./data")
}

#Set variables for download

downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./data/project.zip"
householdFile <- "./data/household_power_consumption.txt"

#Download and Unzip zip file 

if (!file.exists(householdFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = T, exdir = "./data")
}