download_csv <- function() {


#Create directory first

if (!file.exists("./data")) {
        dir.create("./data")
        }

#Download file
        
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")
camdata <- read.csv("./data/cameras.csv")
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