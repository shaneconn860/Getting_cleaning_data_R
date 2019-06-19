library(dplyr) #Load dplyr package

#Create directory first if it doesn't exist

if (!file.exists("./football_data")) {
        dir.create("./football_data")
}

#Download file and load in to R
fileUrl <- "http://www.football-data.co.uk/mmz4281/1819/E0.csv"
download.file(fileUrl, destfile = "./football_data/prem18_19.csv")
edu <- read.csv("./football_data/prem18_19.csv")

prem <- tbl_df(edu) #create data frame tbl

rm("edu") #remove original

select(prem, HomeTeam, AwayTeam, FTR) #displays teams and full-time result

select(prem, HomeTeam:HTR)  #gives list of columns from left to right in that sequence

select(prem, -Referee) #omits Referee column

select (prem, -Referee, -(B365H:PSCA)) #omits range of columns containing betting info and Referee

tidy1 <- select (prem, -Div, -Referee, -(B365H:PSCA)) #create new variable to work with

filter(tidy1, HomeTeam == "Arsenal") #filters Arsenal as Home Team, same as Excel

arse_home <- filter(tidy1, HomeTeam == "Arsenal") #create new variable for Arsenal at Home

filter(arse_home, HomeTeam == "Arsenal", HTHG > 1) #times Arsenal scored more than 1 goal at half-time

filter(arse_home, HTHG > 1 | HTAG > 1) #times Arsenal or the Oppositon scored more than 1 goal at half-time

filter(prem, !is.na(r_version)) #checks for NAs, not relevant in this example

arse_home2 <- select(arse_home, HomeTeam:AST)
arrange(arse_home2, HST) #arrange by Home shots on target
arrange(arse_home2, desc(HST)) #arranges asc by default, so this changes to desc


mutate(arse_home2, total_shots = HST + AST) #adds a new column for total shots (for both teams)
arse_home3 <- mutate(arse_home2, total_shots = HST + AST)

