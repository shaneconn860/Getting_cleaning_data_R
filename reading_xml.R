#Load XML package in to R
library(XML)


#Read the file in to R
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)


#Inspect nodes of the XML document
rootNode[[1]]
rootNode[[1]][[1]]
rootNode[[1]][[2]]


#Loop through and return each specific value of a node
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//policedistrict", xmlValue)
