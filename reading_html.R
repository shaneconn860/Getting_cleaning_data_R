
#Example1
#Use html parse instead of xml as it's a html file
fileUrl <- "https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE)

#Run command below if you get the error: XML content does not seem to be XML
library(RCurl)
doc <-htmlTreeParse(getURL(fileUrl))

#Look for list items of a particular class
teams <- xpathSApply(xmlRoot(doc), "//li[@class='team-name']",xmlValue)



#Example 2
#Read lines from html page
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

