---
title: "Tidying Data with tidyr"
output: 
  html_document:
    keep_md: true
---

## Tidying Data with tidyr

tidyr was automatically installed (if necessary) and loaded when you started this lesson. Just to build the habit, (re)load the package with library(tidyr).


```r
library(tidyr)
```

The author of tidyr, Hadley Wickham, discusses his philosophy of tidy data in his 'Tidy Data' paper: http://vita.had.co.nz/papers/tidy-data.pdf

This paper should be required reading for anyone who works with data, but it's not required in order to complete this lesson.

Tidy data is formatted in a standard way that facilitates exploration and analysis and works seamlessly with other tidy data tools. Specifically, tidy data satisfies three conditions:
 
 1) Each variable forms a column
 
 2) Each observation forms a row
 
 3) Each type of observational unit forms a table

Any dataset that doesn't satisfy these conditions is considered 'messy' data. Therefore, all of the following are characteristics of messy data, EXCEPT...

1: Variables are stored in both rows and columns

2: Column headers are values, not variable names

3: Every column contains a different variable

4: Multiple variables are stored in one column

5: A single observational unit is stored in multiple tables

6: Multiple types of observational units are stored in the same table

**Selection: 3**

The incorrect answers to the previous question are the most common symptoms of messy data. Let's work through a simple example of each of these five cases, then tidy some real data.

The first problem is when you have column headers that are values, not variable names. I've created a simple dataset called 'students' that demonstrates this scenario. Type students to take a look.


```r
grade <- c('A','B','C', 'D', 'E')
male <- c(5, 4, 8, 4, 5)
female <- c(3, 1, 6, 5, 5)
students <- data.frame(grade, male, female)
```


```r
students
```

```
##   grade male female
## 1     A    5      3
## 2     B    4      1
## 3     C    8      6
## 4     D    4      5
## 5     E    5      5
```

The first column represents each of five possible grades that students could receive for a particular class. The second and third columns give the number of male and female students, respectively, that received each grade.

This dataset actually has three variables: grade, sex, and count. The first variable, grade, is already a column, so that should remain as it is. The second variable, sex, is captured by the second and third column headings. The third variable, count, is the number of students for each combination of grade and sex.

To tidy the students data, we need to have one column for each of these three variables. We'll use the gather() function from tidyr to accomplish this. Pull up the documentation for this function with ?gather.

Using the help file as a guide, call gather() with the following arguments (in order): students, sex, count, -grade. Note the minus sign before grade, which says we want to gather all columns EXCEPT grade.


```r
gather(students, sex, count, -grade)
```

```
##    grade    sex count
## 1      A   male     5
## 2      B   male     4
## 3      C   male     8
## 4      D   male     4
## 5      E   male     5
## 6      A female     3
## 7      B female     1
## 8      C female     6
## 9      D female     5
## 10     E female     5
```

Each row of the data now represents exactly one observation, characterized by a unique combination of the grade and sex variables. Each of our variables (grade, sex, and count) occupies exactly one column. That's tidy data!

It's important to understand what each argument to gather() means. The data argument, students, gives the name of the original dataset. The key and value arguments -- sex and count, respectively -- give the column names for our tidy dataset. The final argument, -grade, says that we want to gather all columns EXCEPT the grade column (since grade is already a proper column variable.)

The second messy data case we'll look at is when multiple variables are stored in one column. Type students2 to see an example of this.


```r
grade <- c('A','B','C', 'D', 'E')
male_1 <- c(7, 4, 7, 8, 8)
female_1 <- c(0, 0, 4, 2, 4)
male_2 <- c(5, 5, 5, 8, 1)
female_2 <- c(8, 8, 6, 1, 0)
students2 <- data.frame(grade, male_1, female_1, male_2, female_2)
```


```r
students2
```

```
##   grade male_1 female_1 male_2 female_2
## 1     A      7        0      5        8
## 2     B      4        0      5        8
## 3     C      7        4      5        6
## 4     D      8        2      8        1
## 5     E      8        4      1        0
```

This dataset is similar to the first, except now there are two separate classes, 1 and 2, and we have total counts for each sex within each class. students2 suffers from the same messy data problem of having column headers that are values (male_1, female_1, etc.) and not
 variable names (sex, class, and count).

However, it also has multiple variables stored in each column (sex and class), which is another common symptom of messy data. Tidying this dataset will be a two step process.

Let's start by using gather() to stack the columns of students2, like we just did with students. This time, name the 'key' column sex_class and the 'value' column count. Save the result to a new variable called res. Consult ?gather again if you need help.


```r
res <- gather(students2, sex_class, count, -grade)
```

Print res to the console to see what we accomplished.


```r
res
```

```
##    grade sex_class count
## 1      A    male_1     7
## 2      B    male_1     4
## 3      C    male_1     7
## 4      D    male_1     8
## 5      E    male_1     8
## 6      A  female_1     0
## 7      B  female_1     0
## 8      C  female_1     4
## 9      D  female_1     2
## 10     E  female_1     4
## 11     A    male_2     5
## 12     B    male_2     5
## 13     C    male_2     5
## 14     D    male_2     8
## 15     E    male_2     1
## 16     A  female_2     8
## 17     B  female_2     8
## 18     C  female_2     6
## 19     D  female_2     1
## 20     E  female_2     0
```

That got us half way to tidy data, but we still have two different variables, sex and class, stored together in the sex_class column. tidyr offers a convenient separate() function for the purpose of separating one column into multiple columns. Pull up the help file for separate() now.

Call separate() on res to split the sex_class column into sex and class. You only need to specify the first three arguments: data = res, col = sex_class, into = c("sex", "class"). You don't have to provide the argument names as long as they are in the correct order.


```r
separate(res, col=sex_class, into=c("sex", "class"))
```

```
##    grade    sex class count
## 1      A   male     1     7
## 2      B   male     1     4
## 3      C   male     1     7
## 4      D   male     1     8
## 5      E   male     1     8
## 6      A female     1     0
## 7      B female     1     0
## 8      C female     1     4
## 9      D female     1     2
## 10     E female     1     4
## 11     A   male     2     5
## 12     B   male     2     5
## 13     C   male     2     5
## 14     D   male     2     8
## 15     E   male     2     1
## 16     A female     2     8
## 17     B female     2     8
## 18     C female     2     6
## 19     D female     2     1
## 20     E female     2     0
```

Conveniently, separate() was able to figure out on its own how to separate the sex_class column. Unless you request otherwise with the 'sep' argument, it splits on non-alphanumeric values. In other words, it assumes that the values are separated by something other than a letter or number (in this case, an underscore.)

Tidying students2 required both gather() and separate(), causing us to save an intermediate result (res). However, just like with dplyr, you can use the %```{r}% operator to chain multiple function calls together.

I've opened an R script for you to give this a try. 


```r
students2 %>%
  gather(sex_class, count, -grade) %>%
  separate(col=sex_class, c("sex", "class")) %>%
  print
```

```
##    grade    sex class count
## 1      A   male     1     7
## 2      B   male     1     4
## 3      C   male     1     7
## 4      D   male     1     8
## 5      E   male     1     8
## 6      A female     1     0
## 7      B female     1     0
## 8      C female     1     4
## 9      D female     1     2
## 10     E female     1     4
## 11     A   male     2     5
## 12     B   male     2     5
## 13     C   male     2     5
## 14     D   male     2     8
## 15     E   male     2     1
## 16     A female     2     8
## 17     B female     2     8
## 18     C female     2     6
## 19     D female     2     1
## 20     E female     2     0
```

A third symptom of messy data is when variables are stored in both rows and columns. students3 provides an example of this. Print students3 to the console.


```r
name <- c('Sally','Sally','Jeff', 'Jeff', 'Roger', 'Roger', 'Karen', 'Karen', 'Brian', 'Brian')
test <- c('midterm', 'final', 'midterm', 'final', 'midterm', 'final', 'midterm', 'final', 'midterm', 'final')
class1 <- c('A', 'C', NA, NA, NA, NA, NA, NA, 'B', 'B')
class2 <- c(NA, NA, 'D', 'E', 'C', 'A', NA, NA, NA, NA)
class3 <- c('B', 'C', NA, NA, NA, NA, 'C', 'C', NA, NA)
class4 <- c(NA, NA, 'A', 'C', NA, NA, 'A', 'A', NA, NA)
class5 <- c(NA, NA, NA, NA, 'B', 'A', NA, NA, 'A', 'C')
students3 <- data.frame(name, test, class1, class2, class3, class4, class5)
```


```r
students3
```

```
##     name    test class1 class2 class3 class4 class5
## 1  Sally midterm      A   <NA>      B   <NA>   <NA>
## 2  Sally   final      C   <NA>      C   <NA>   <NA>
## 3   Jeff midterm   <NA>      D   <NA>      A   <NA>
## 4   Jeff   final   <NA>      E   <NA>      C   <NA>
## 5  Roger midterm   <NA>      C   <NA>   <NA>      B
## 6  Roger   final   <NA>      A   <NA>   <NA>      A
## 7  Karen midterm   <NA>   <NA>      C      A   <NA>
## 8  Karen   final   <NA>   <NA>      C      A   <NA>
## 9  Brian midterm      B   <NA>   <NA>   <NA>      A
## 10 Brian   final      B   <NA>   <NA>   <NA>      C
```

In students3, we have midterm and final exam grades for five students, each of whom were enrolled in exactly two of five possible classes.

The first variable, name, is already a column and should remain as it is. The headers of the last five columns, class1 through class5, are all different values of what should be a class variable. The values in the test column, midterm and final, should each be its own variable containing the respective grades for each student.

This will require multiple steps, which we will build up gradually using %```{r}%. Edit the R script, save it, then type submit() when you are ready. Type reset() to reset the script to its original state.  
  

```r
students3 %>%
  gather(class, grade, class1:class5 , na.rm = TRUE) %>%
  print
```

```
## Warning: attributes are not identical across measure variables;
## they will be dropped
```

```
##     name    test  class grade
## 1  Sally midterm class1     A
## 2  Sally   final class1     C
## 9  Brian midterm class1     B
## 10 Brian   final class1     B
## 13  Jeff midterm class2     D
## 14  Jeff   final class2     E
## 15 Roger midterm class2     C
## 16 Roger   final class2     A
## 21 Sally midterm class3     B
## 22 Sally   final class3     C
## 27 Karen midterm class3     C
## 28 Karen   final class3     C
## 33  Jeff midterm class4     A
## 34  Jeff   final class4     C
## 37 Karen midterm class4     A
## 38 Karen   final class4     A
## 45 Roger midterm class5     B
## 46 Roger   final class5     A
## 49 Brian midterm class5     A
## 50 Brian   final class5     C
```

A third symptom of messy data is when variables are stored in both rows and columns. students3 provides an example of this. Print students3 to the console.


```r
students3
```

```
##     name    test class1 class2 class3 class4 class5
## 1  Sally midterm      A   <NA>      B   <NA>   <NA>
## 2  Sally   final      C   <NA>      C   <NA>   <NA>
## 3   Jeff midterm   <NA>      D   <NA>      A   <NA>
## 4   Jeff   final   <NA>      E   <NA>      C   <NA>
## 5  Roger midterm   <NA>      C   <NA>   <NA>      B
## 6  Roger   final   <NA>      A   <NA>   <NA>      A
## 7  Karen midterm   <NA>   <NA>      C      A   <NA>
## 8  Karen   final   <NA>   <NA>      C      A   <NA>
## 9  Brian midterm      B   <NA>   <NA>   <NA>      A
## 10 Brian   final      B   <NA>   <NA>   <NA>      C
```

In students3, we have midterm and final exam grades for five students, each of whom were enrolled in exactly two of five possible classes.

The first variable, name, is already a column and should remain as it is. The headers of the last five columns, class1 through class5, are all different values of what should be a class variable. The values in the test column, midterm and final, should each be its own variable
 containing the respective grades for each student.

This will require multiple steps, which we will build up gradually using %```{r}%. Edit the R script, save it, then type submit() when you are
 ready. Type reset() to reset the script to its original state.

The next step will require the use of spread(). Pull up the documentation for spread() now.

Edit the R script, then save it and type submit() when you are ready. Type reset() to reset the script to its original state.

Read the directions in the script carefully. If R is giving you an error, try to understand what it is telling you. Save the script and
 type submit() at the prompt when you are ready, or type reset() to reset the script to its original state.

readr is required for certain data manipulations, such as `parse_number(), which will be used in the next question.  Let's, (re)load the
 package with library(readr).


```r
library(readr)
```

Lastly, we want the values in the class column to simply be 1, 2, ..., 5 and not class1, class2, ..., class5. We can use the parse_number() function from readr to accomplish this. To see how it works, try parse_number("class5").


```r
parse_number("class5")
```

```
## [1] 5
```

Now, the final step. Edit the R script, then save it and type submit() when you are ready. Type reset() to reset the script to its original state.


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        mutate(class = parse_number(class)) %>%
        print
```

```
## Warning: attributes are not identical across measure variables;
## they will be dropped
```

```
##     name class final midterm
## 1  Brian     1     B       B
## 2  Brian     5     C       A
## 3   Jeff     2     E       D
## 4   Jeff     4     C       A
## 5  Karen     3     C       C
## 6  Karen     4     A       A
## 7  Roger     2     A       C
## 8  Roger     5     A       B
## 9  Sally     1     C       A
## 10 Sally     3     C       B
```

The fourth messy data problem we'll look at occurs when multiple observational units are stored in the same table. students4 presents an example of this. Take a look at the data now.


```r
id <- c(168, 168, 588, 588, 710, 710, 731, 731, 908, 908)
name <- c('Brian', 'Brian', 'Sally','Sally','Jeff', 'Jeff', 'Roger', 'Roger', 'Karen', 'Karen')
sex <- c('F', 'F', 'M', 'M', 'M', 'M', 'F', 'F', 'M', 'M')
class <- c(1, 5, 1, 3, 2, 4, 2, 5, 3, 4)
midterm <- c('B', 'A', 'A', 'B', 'D', 'A', 'C', 'B', 'C', 'A')
final <- c('B', 'A', 'A', 'B', 'D', 'A', 'C', 'B', 'C', 'A')
students4 <- data.frame(id, name, sex, class, midterm, final)
```


```r
students4
```

```
##     id  name sex class midterm final
## 1  168 Brian   F     1       B     B
## 2  168 Brian   F     5       A     A
## 3  588 Sally   M     1       A     A
## 4  588 Sally   M     3       B     B
## 5  710  Jeff   M     2       D     D
## 6  710  Jeff   M     4       A     A
## 7  731 Roger   F     2       C     C
## 8  731 Roger   F     5       B     B
## 9  908 Karen   M     3       C     C
## 10 908 Karen   M     4       A     A
```

students4 is almost the same as our tidy version of students3. The only difference is that students4 provides a unique id for each student, as well as his or her sex (M = male; F = female).

At first glance, there doesn't seem to be much of a problem with students4. All columns are variables and all rows are observations. However, notice that each id, name, and sex is repeated twice, which seems quite redundant. This is a hint that our data contains multiple observational units in a single table.

Our solution will be to break students4 into two separate tables -- one containing basic student information (id, name, and sex) and the other containing grades (id, class, midterm, final).
 
Edit the R script, save it, then type submit() when you are ready. Type reset() to reset the script to its original state.


```r
student_info <- students4 %>%
        select(id, name, sex) %>%
        unique %>%
        print
```

```
##    id  name sex
## 1 168 Brian   F
## 3 588 Sally   M
## 5 710  Jeff   M
## 7 731 Roger   F
## 9 908 Karen   M
```

```r
#Without unique, rows will be repeated
```

Notice anything strange about student_info? It contains five duplicate rows! See the script for directions on how to fix this. Save the script and type submit() when you are ready, or type reset() to reset the script to its original state.

Now, using the script I just opened for you, create a second table called gradebook using the id, class, midterm, and final columns (in that order).


```r
gradebook <- students4 %>%
        select("id", "class", "midterm", "final") %>%
        print
```

```
##     id class midterm final
## 1  168     1       B     B
## 2  168     5       A     A
## 3  588     1       A     A
## 4  588     3       B     B
## 5  710     2       D     D
## 6  710     4       A     A
## 7  731     2       C     C
## 8  731     5       B     B
## 9  908     3       C     C
## 10 908     4       A     A
```
 
It's important to note that we left the id column in both tables. In the world of relational databases, 'id' is called our 'primary key' since it allows us to connect each student listed in student_info with their grades listed in gradebook. Without a unique identifier, we might not know how the tables are related. (In this case, we could have also used the name variable, since each student happens to have a unique name.)

The fifth and final messy data scenario that we'll address is when a single observational unit is stored in multiple tables. It's the opposite of the fourth problem.

To illustrate this, we've created two datasets, passed and failed. Take a look at passed now.


```r
name <- c("Brian", "Roger", "Roger", "Karen")
class <- c(1, 2, 5, 4)
final <- c("B", "A", "A", "A")
passed <- data.frame(name, class, final)
print(passed)
```

```
##    name class final
## 1 Brian     1     B
## 2 Roger     2     A
## 3 Roger     5     A
## 4 Karen     4     A
```



```r
name <- c("Brian", "Sally", "Sally", "Jeff", "Jeff", "Karen")
class <- c(5, 1, 3, 2, 4, 3)
final <- c("C", "C", "C", "E", "C", "C")
failed <- data.frame(name, class, final)
print(failed)
```

```
##    name class final
## 1 Brian     5     C
## 2 Sally     1     C
## 3 Sally     3     C
## 4  Jeff     2     E
## 5  Jeff     4     C
## 6 Karen     3     C
```

Teachers decided to only take into consideration final exam grades in determining whether students passed or failed each class. As you may have inferred from the data, students passed a class if they received a final exam grade of A or B and failed otherwise.

The name of each dataset actually represents the value of a new variable that we will call 'status'. Before joining the two tables together, we'll add a new column to each containing this information so that it's not lost when we put everything together.

Use dplyr's mutate() to add a new column to the passed table. The column should be called status and the value, "passed" (a character string), should be the same for all students. 'Overwrite' the current version of passed with the new one.


```r
passed <- passed %>% mutate(status = "passed")
```

Now, do the same for the failed table, except the status column should have the value "failed" for all students.


```r
failed <- failed %>% mutate(status = "failed")
```

Now, pass as arguments the passed and failed tables (in order) to the dplyr function bind_rows(), which will join them together into a single unit. Check ?bind_rows if you need help.


```r
bind_rows(passed, failed)
```

```
## Warning in bind_rows_(x, .id): Unequal factor levels: coercing to character
```

```
## Warning in bind_rows_(x, .id): binding character and factor vector, coercing
## into character vector

## Warning in bind_rows_(x, .id): binding character and factor vector, coercing
## into character vector
```

```
## Warning in bind_rows_(x, .id): Unequal factor levels: coercing to character
```

```
## Warning in bind_rows_(x, .id): binding character and factor vector, coercing
## into character vector

## Warning in bind_rows_(x, .id): binding character and factor vector, coercing
## into character vector
```

```
##     name class final status
## 1  Brian     1     B passed
## 2  Roger     2     A passed
## 3  Roger     5     A passed
## 4  Karen     4     A passed
## 5  Brian     5     C failed
## 6  Sally     1     C failed
## 7  Sally     3     C failed
## 8   Jeff     2     E failed
## 9   Jeff     4     C failed
## 10 Karen     3     C failed
```

Of course, we could arrange the rows however we wish at this point, but the important thing is that each row is an observation, each column is a variable, and the table contains a single observational unit. Thus, the data are tidy.

We've covered a lot in this lesson. Let's bring everything together and tidy a real dataset.

The SAT is a popular college-readiness exam in the United States that consists of three sections: critical reading, mathematics, and writing. Students can earn up to 800 points on each section. This dataset presents the total number of students, for each combination of exam section and sex, within each of six score ranges. It comes from the 'Total Group Report 2013', which can be found here:
 
http://research.collegeboard.org/programs/sat/data/cb-seniors-2013

I've created a variable called 'sat' in your workspace, which contains data on all college-bound seniors who took the SAT exam in 2013.
Print the dataset now.


```r
#sat
```
# A tibble: 6 x 10
  score_range read_male read_fem read_total math_male math_fem math_total write_male write_fem write_total
  <chr```{r}           <int```{r}    <int```{r}      <int```{r}     <int```{r}    <int```{r}      <int```{r}      <int```{r}     <int```{r}       <int```{r}
1 700-800         40151    38898      79049     74461    46040     120501      31574     39101       70675
2 600-690        121950   126084     248034    162564   133954     296518     100963    125368      226331
3 500-590        227141   259553     486694    233141   257678     490819     202326    247239      449565
4 400-490        242554   296793     539347    204670   288696     493366     262623    302933      565556
5 300-390        113568   133473     247041     82468   131025     213493     146106    144381      290487
6 200-290         30728    29154      59882     18788    26562      45350      32500     24933       57433

As we've done before, we'll build up a series of chained commands, using functions from both tidyr and dplyr. 


```r
#sat %```{r}%
#        select(-contains("total")) %```{r}%
#        gather(part_sex, count, -score_range) %```{r}%
#        separate(part_sex, c("part", "sex")) %```{r}%
#        group_by(part, sex) %```{r}%
#        mutate(total = sum(count),
#               prop = count / total
#        ) %```{r}% print
```

# A tibble: 36 x 6
# Groups:   part, sex [6]
   score_range part  sex    count  total   prop
   <chr```{r}       <chr```{r} <chr```{r}  <int```{r}  <int```{r}  <dbl```{r}
 1 700-800     read  male   40151 776092 0.0517
 2 600-690     read  male  121950 776092 0.157 
 3 500-590     read  male  227141 776092 0.293 
 4 400-490     read  male  242554 776092 0.313 
 5 300-390     read  male  113568 776092 0.146 
 6 200-290     read  male   30728 776092 0.0396
 7 700-800     read  fem    38898 883955 0.0440
 8 600-690     read  fem   126084 883955 0.143 
 9 500-590     read  fem   259553 883955 0.294 
10 400-490     read  fem   296793 883955 0.336 
# … with 26 more rows

In this lesson, you learned how to tidy data with tidyr and dplyr. These tools will help you spend less time and energy getting your data ready to analyze and more time actually analyzing it.  
