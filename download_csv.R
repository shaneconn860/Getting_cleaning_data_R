download_csv <- function() {


#Create directory first

if (!file.exists("./data4")) {
        dir.create("./data4")
        }

#Download file
        
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data4/test.csv")
camdata <- read.csv("./data4/test.csv")
}

#summary(camdata)
#str(camdata)
#table(camdata$councilDistrict, camdata$zipCode)
#sum(is.na(camdata$councilDistrict))
#any(is.na(camdata$councilDistrict))
#all(camdata$zipCode > 0)
#colSums(is.na(camdata))
#all(colSums(is.na(camdata))==0)
#table(camdata$zipCode %in% c("21212", "21213"))
#camdata[camdata$zipCode %in% c("21212", "21213"),] - subset list of restaurants in Zipcodes