#Set working directory and add file to variable

setwd("/Users/shaneconnaughton/Documents/RProjects/4.Exploratory Data/data")
file <- "./household_power_consumption.txt"

#Load data in to R and remove missing values
data <- read.table(file, na.strings = "?", header = T, sep=";")

#Subset method 1 - only subset dates Feb 1st - 2nd in 2007
febdata1 <- subset(data, data$Date == "1/2/2007" | 
                                data$Date == "2/2/2007")


#Subset method 2 - only subset dates Feb 3rd - 4th in 2007
febdata2 <- data[data$Date %in% c("3/2/2007", "4/2/2007"),]