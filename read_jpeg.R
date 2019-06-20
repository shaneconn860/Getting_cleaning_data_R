#Install jpeg package
library(jpeg)

#Create directory if it doesn't already exist
if (!file.exists("./Directory")) {
        dir.create("./Directory")
}

#Download file
fileUrl <- ('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg')
download.file(fileUrl, destfile = "./Directory/jeff.jpg", mode='wb')

#Read the image in to R / 'native' determines the image representation
picture <- readJPEG("./Directory/jeff.jpg", native=TRUE)

#Find 30th and 80 quantiles of the image 
quantile(picture, probs = c(0.3, 0.8))
                         
            
            
            


        