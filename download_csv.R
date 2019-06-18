download_csv <- function() {


#Create directory first

if (!file.exists("./data4")) {
        dir.create("./data4")
        }

#Download file
        
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data4/test.csv")
camdata <- read.csv("./data4/test.csv")
}
