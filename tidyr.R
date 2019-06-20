#Load tidyr package
library(tidyr)

#Create 'messy' data frame

grade <- c('A','B','C', 'D', 'E')
male_1 <- c(7, 4, 7, 8, 8)
female_1 <- c(0, 0, 4, 2, 4)
male_2 <- c(5, 5, 5, 8, 1)
female_2 <- c(8, 8, 6, 1, 0)
students <- data.frame(grade, male_1, female_1, male_2, female_2)

#Use gather to stack students, key=sex_class, value=count, -grade as that is fine as is
res <- gather(students, sex_class, count, -grade) 

#Separate sex and class, done using the _underscore
separate(res, sex_class, c("sex", "class")) 

#Achieve the same thing by chaining
students %>%
        gather(sex_class, count, -grade) %>%
        separate(sex_class, c("sex", "class")) %>%
        print

#Create 2nd 'messy' data frame
name <- c('Sally','Sally','Jeff', 'Jeff', 'Roger', 'Roger')
test <- c('midterm', 'final', 'midterm', 'final', 'midterm', 'final')
class_1 <- c('A', 'C', NA, NA, NA, NA)
class_2 <- c(NA, NA, 'D', 'E', 'C', 'A')
class_3 <- c('B', 'C', NA, NA, NA, NA)
class_4 <- c(NA, NA, 'A', 'C', NA, NA)
class_5 <- c(NA, NA, NA, NA, 'B', 'A')
students2 <- data.frame(name, test, class_1, class_2, class_3, class_4, class_5)

#Gather columns class1-5 in to a new class column, with a value of grade, removing NAs also
students2 %>%
        gather(class, grade, class_1:class_5, na.rm = TRUE) %>%
        print

#Use separate to turn the values of the test column, midterm and final, into column headers (i.e. variables)
students2 %>%
        gather(class, grade, class_1:class_5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        print

#Remove class just leaving the number of the class, overwriting using mutate function
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        mutate(class = parse_number(class)) %>%
        print

#Makes sure id, name and sex are unique, eg, not repeated (not included in above data frame)
student_info <- students4 %>%
        select(id, name, sex) %>%
        unique %>%
        print

#Creates new status column to the passed and failed tables
passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")

#Combines rows of the 2 tables
bind_rows(passed, failed)
