library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./quiz3/edu.csv")
edu <- read.csv("./quiz3/edu.csv")

cran <- tbl_df(edu) #create data frame tbl

rm("edu") #remove original

select(cran, CountryCode, Income.Group, Currency.Unit)

select(cran, r_arch:country)  #gives list of columns from left to right

select(cran, -time) #omits time column

select (cran, -(X:size)) #omits range of columns from X to size

filter(cran, package == "swirl")

filter(cran, r_version == "3.1.1", country == "US") #both need to be true

filter(cran, country == "US" | country == "IN") #Or statement

filter(cran, !is.na(r_version))

cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))


cran3 <- select(cran, ip_id, package, size)
mutate(cran3, size_mb = size / 2^20) #adds a new variable based on existing variable in dataset
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)