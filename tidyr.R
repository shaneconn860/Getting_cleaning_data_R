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


