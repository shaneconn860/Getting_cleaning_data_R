library(dplyr) #Load dplyr package

#Create directory first if it doesn't exist

if (!file.exists("./football_data")) {
        dir.create("./football_data")
}

#Download file and load in to R
fileUrl <- "http://www.football-data.co.uk/mmz4281/1819/E0.csv"
download.file(fileUrl, destfile = "./football_data/prem18_19.csv")
edu <- read.csv("./football_data/prem18_19.csv")

#Create data frame tbl
prem <- tbl_df(edu) 

#Remove original table
rm("edu") 

#Displays teams and full-time result
select(prem, HomeTeam, AwayTeam, FTR) 

#Displays list of columns from left to right in that sequence
select(prem, HomeTeam:HTR)  

#Omits 'Referee' column
select(prem, -Referee) 

#Omits range of columns containing betting info and Referee
select (prem, -Referee, -(B365H:PSCA)) 

#Create new variable to work with
tidy1 <- select (prem, -Div, -Referee, -(B365H:PSCA)) 

#Filters Arsenal as Home Team
filter(tidy1, HomeTeam == "Arsenal") 

#Create new variable for Arsenal at Home and previous edits
arse_home <- filter(tidy1, HomeTeam == "Arsenal") 

#Displays times Arsenal scored more than 1 goal at half-time
filter(arse_home, HomeTeam == "Arsenal", HTHG > 1) 

#Displays times Arsenal or the Oppositon scored more than 1 goal at half-time
filter(arse_home, HTHG > 1 | HTAG > 1) 

#Checks for NAs, not relevant in this example
filter(prem, !is.na(r_version)) 

#Create new variable to show Arsenal to Away shots on target column
arse_home2 <- select(arse_home, HomeTeam:AST)

#Arrange by Home shots on target
arrange(arse_home2, HST) 

#Arranges asc by default, so this changes to desc
arrange(arse_home2, desc(HST)) 

#Adds a new column for total shots on target (for both teams)
mutate(arse_home2, TST = HST + AST) 

#Create new variable for this function
arse_home3 <- mutate(arse_home2, TST = HST + AST)

#Arranges asc by default, so this changes to desc
arrange(arse_home3, desc(HST)) 

#Using the %>% operator to pipe output of function from left to right in one block

arse_home %>%
        select(HomeTeam:AST) %>%
        mutate(TST = HST + AST) %>%
        filter(HST <= 4) %>%
        arrange(desc(HST))

#Displays games where Away team had more shots than Home team
filter(arse_home3, AST > HST) 

#Use View function on any of the above for better display than using R console for output
View(arse_home3) 
