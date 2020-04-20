---
title: "Manipulating, Grouping and Chaining Data with dplyr"
output: 
  html_document:
    keep_md: true
---

## Manipulating Data with dplyr

### Specifically, dplyr supplies five ‘verbs’ that cover most fundamental data manipulation tasks: select(), filter(), arrange(), mutate(), and summarize().

In this lesson, you'll learn how to manipulate data using dplyr. dplyr is a fast and powerful R package written by Hadley Wickham and Romain Francois that provides a consistent and concise grammar for manipulating tabular data.

One unique aspect of dplyr is that the same set of tools allow you to work with tabular data from a variety of sources, including data frames, data tables, databases and multidimensional arrays. In this lesson, we'll focus on data frames, but everything you learn will apply equally to other formats.

I've created a variable called path2csv, which contains the full file path to the dataset. Call read.csv() with two arguments, path2csv and stringsAsFactors = FALSE, and save the result in a new variable called mydf. Check ?read.csv if you need help.


```r
#path2csv <- read.csv("./2014-07-08.csv", header = TRUE, sep = ",")
```


```r
mydf <- read.csv("./2014-07-08.csv", stringsAsFactors = FALSE, header = TRUE, sep =",")
```

Use dim() to look at the dimensions of mydf.


```r
dim(mydf)
```

```
## [1] 225468     11
```

Now use head() to preview the data.


```r
head(mydf)
```

```
##   X       date     time   size r_version r_arch      r_os      package version
## 1 1 2014-07-08 00:54:41  80589     3.1.0 x86_64   mingw32    htmltools   0.2.4
## 2 2 2014-07-08 00:59:53 321767     3.1.0 x86_64   mingw32      tseries 0.10-32
## 3 3 2014-07-08 00:47:13 748063     3.1.0 x86_64 linux-gnu        party  1.0-15
## 4 4 2014-07-08 00:48:05 606104     3.1.0 x86_64 linux-gnu        Hmisc  3.14-4
## 5 5 2014-07-08 00:46:50  79825     3.0.2 x86_64 linux-gnu       digest   0.6.4
## 6 6 2014-07-08 00:48:04  77681     3.1.0 x86_64 linux-gnu randomForest   4.6-7
##   country ip_id
## 1      US     1
## 2      US     2
## 3      US     3
## 4      US     3
## 5      CA     4
## 6      US     3
```

The dplyr package was automatically installed (if necessary) and loaded at the beginning of this lesson. Normally, this is something you would have to do on your own. Just to build the habit, type library(dplyr) now to load the package again.


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

It's important that you have dplyr version 0.4.0 or later. To confirm this, type packageVersion("dplyr").


```r
packageVersion("dplyr")
```

```
## [1] '0.8.3'
```

If your dplyr version is not at least 0.4.0, then you should hit the Esc key now, reinstall dplyr, then resume this lesson where you left off.

The first step of working with data in dplyr is to load the data into what the package authors call a 'data frame tbl' or 'tbl_df'. Use the following code to create a new tbl_df called cran:
 
 cran <- tbl_df(mydf).


```r
cran <- tbl_df(mydf)
```

To avoid confusion and keep things running smoothly, let's remove the original data frame from your workspace with rm("mydf").


```r
rm("mydf")
```

From ?tbl_df, "The main advantage to using a tbl_df over a regular data frame is the printing." Let's see what is meant by this. Type cran to print our tbl_df to the console.


```r
cran
```

```
## # A tibble: 225,468 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US          1
##  2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US          2
##  3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
##  4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
##  5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA          4
##  6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US          3
##  7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
##  8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US          5
##  9     9 2014… 00:5… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN          6
## 10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
## # … with 225,458 more rows
```

This output is much more informative and compact than what we would get if we printed the original data frame (mydf) to the console.

First, we are shown the class and dimensions of the dataset. Just below that, we get a preview of the data. Instead of attempting to print the entire dataset, dplyr just shows us the first 10 rows of data and only as many columns as fit neatly in our console. At the bottom, we see the names and classes for any variables that didn't fit on our screen.

According to the "Introduction to dplyr" vignette written by the package authors, "The dplyr philosophy is to have small functions that each do one thing well." Specifically, dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: select(), filter(), arrange(), mutate(), and summarize().

As may often be the case, particularly with larger datasets, we are only interested in some of the variables. Use select(cran, ip_id, package, country) to select only the ip_id, package, and country variables from the cran dataset.


```r
select(cran, ip_id, package, country)
```

```
## # A tibble: 225,468 x 3
##    ip_id package      country
##    <int> <chr>        <chr>  
##  1     1 htmltools    US     
##  2     2 tseries      US     
##  3     3 party        US     
##  4     3 Hmisc        US     
##  5     4 digest       CA     
##  6     3 randomForest US     
##  7     3 plyr         US     
##  8     5 whisker      US     
##  9     6 Rcpp         CN     
## 10     7 hflights     US     
## # … with 225,458 more rows
```

The first thing to notice is that we don't have to type cran$ip_id, cran$package, and cran$country, as we normally would when referring to columns of a data frame. The select() function knows we are referring to columns of the cran dataset.

Also, note that the columns are returned to us in the order we specified, even though ip_id is the rightmost column in the original dataset.

Recall that in R, the `:` operator provides a compact notation for creating a sequence of numbers. For example, try 5:20.


```r
5:20
```

```
##  [1]  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

Normally, this notation is reserved for numbers, but select() allows you to specify a sequence of columns this way, which can save a bunch of typing. Use select(cran, r_arch:country) to select all columns starting from r_arch and ending with country.


```r
select(cran, r_arch:country)
```

```
## # A tibble: 225,468 x 5
##    r_arch r_os      package      version country
##    <chr>  <chr>     <chr>        <chr>   <chr>  
##  1 x86_64 mingw32   htmltools    0.2.4   US     
##  2 x86_64 mingw32   tseries      0.10-32 US     
##  3 x86_64 linux-gnu party        1.0-15  US     
##  4 x86_64 linux-gnu Hmisc        3.14-4  US     
##  5 x86_64 linux-gnu digest       0.6.4   CA     
##  6 x86_64 linux-gnu randomForest 4.6-7   US     
##  7 x86_64 linux-gnu plyr         1.8.1   US     
##  8 x86_64 linux-gnu whisker      0.3-2   US     
##  9 <NA>   <NA>      Rcpp         0.10.4  CN     
## 10 x86_64 linux-gnu hflights     0.1     US     
## # … with 225,458 more rows
```

We can also select the same columns in reverse order. Give it a try.


```r
select(cran, country:r_arch)
```

```
## # A tibble: 225,468 x 5
##    country version package      r_os      r_arch
##    <chr>   <chr>   <chr>        <chr>     <chr> 
##  1 US      0.2.4   htmltools    mingw32   x86_64
##  2 US      0.10-32 tseries      mingw32   x86_64
##  3 US      1.0-15  party        linux-gnu x86_64
##  4 US      3.14-4  Hmisc        linux-gnu x86_64
##  5 CA      0.6.4   digest       linux-gnu x86_64
##  6 US      4.6-7   randomForest linux-gnu x86_64
##  7 US      1.8.1   plyr         linux-gnu x86_64
##  8 US      0.3-2   whisker      linux-gnu x86_64
##  9 CN      0.10.4  Rcpp         <NA>      <NA>  
## 10 US      0.1     hflights     linux-gnu x86_64
## # … with 225,458 more rows
```

Print the entire dataset again, just to remind yourself of what it looks like. You can do this at anytime during the lesson.


```r
cran
```

```
## # A tibble: 225,468 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US          1
##  2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US          2
##  3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
##  4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
##  5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA          4
##  6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US          3
##  7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
##  8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US          5
##  9     9 2014… 00:5… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN          6
## 10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
## # … with 225,458 more rows
```

Instead of specifying the columns we want to keep, we can also specify the columns we want to throw away. To see how this works, do select(cran, -time) to omit the time column.


```r
select(cran, -time)
```

```
## # A tibble: 225,468 x 10
##        X date       size r_version r_arch r_os   package   version country ip_id
##    <int> <chr>     <int> <chr>     <chr>  <chr>  <chr>     <chr>   <chr>   <int>
##  1     1 2014-0…   80589 3.1.0     x86_64 mingw… htmltools 0.2.4   US          1
##  2     2 2014-0…  321767 3.1.0     x86_64 mingw… tseries   0.10-32 US          2
##  3     3 2014-0…  748063 3.1.0     x86_64 linux… party     1.0-15  US          3
##  4     4 2014-0…  606104 3.1.0     x86_64 linux… Hmisc     3.14-4  US          3
##  5     5 2014-0…   79825 3.0.2     x86_64 linux… digest    0.6.4   CA          4
##  6     6 2014-0…   77681 3.1.0     x86_64 linux… randomFo… 4.6-7   US          3
##  7     7 2014-0…  393754 3.1.0     x86_64 linux… plyr      1.8.1   US          3
##  8     8 2014-0…   28216 3.0.2     x86_64 linux… whisker   0.3-2   US          5
##  9     9 2014-0…    5928 <NA>      <NA>   <NA>   Rcpp      0.10.4  CN          6
## 10    10 2014-0… 2206029 3.0.2     x86_64 linux… hflights  0.1     US          7
## # … with 225,458 more rows
```

The negative sign in front of time tells select() that we DON'T want the time column. Now, let's combine strategies to omit all columns from X through size (X:size). To see how this might work, let's look at a numerical example with -5:20.


```r
-5:20
```

```
##  [1] -5 -4 -3 -2 -1  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19
## [26] 20
```

That gaves us a vector of numbers from -5 through 20, which is not what we want. Instead, we want to negate the entire sequence of numbers from 5 through 20, so that we get -5, -6, -7, ... , -18, -19, -20. Try the same thing, except surround 5:20 with parentheses so that R knows we want it to first come up with the sequence of numbers, then apply the negative sign to the whole thing.


```r
-(5:20)
```

```
##  [1]  -5  -6  -7  -8  -9 -10 -11 -12 -13 -14 -15 -16 -17 -18 -19 -20
```

Use this knowledge to omit all columns X:size using select().


```r
select(cran, -(X:size))
```

```
## # A tibble: 225,468 x 7
##    r_version r_arch r_os      package      version country ip_id
##    <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
##  1 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
##  2 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
##  3 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
##  4 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
##  5 3.0.2     x86_64 linux-gnu digest       0.6.4   CA          4
##  6 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
##  7 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
##  8 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
##  9 <NA>      <NA>   <NA>      Rcpp         0.10.4  CN          6
## 10 3.0.2     x86_64 linux-gnu hflights     0.1     US          7
## # … with 225,458 more rows
```

Now that you know how to select a subset of columns using select(), a natural next question is "How do I select a subset of rows?" That's where the filter() function comes in.

Use filter(cran, package == "swirl") to select all rows for which the package variable is equal to "swirl". Be sure to use two equals signs side-by-side!


```r
filter(cran, package == "swirl")
```

```
## # A tibble: 820 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1    27 2014… 00:1… 105350 3.0.2     x86_64 ming… swirl   2.2.9   US         20
##  2   156 2014… 00:2…  41261 3.1.0     x86_64 linu… swirl   2.2.9   US         66
##  3   358 2014… 00:1… 105335 2.15.2    x86_64 ming… swirl   2.2.9   CA        115
##  4   593 2014… 00:5… 105465 3.1.0     x86_64 darw… swirl   2.2.9   MX        162
##  5   831 2014… 00:5… 105335 3.0.3     x86_64 ming… swirl   2.2.9   US         57
##  6   997 2014… 00:3…  41261 3.1.0     x86_64 ming… swirl   2.2.9   US         70
##  7  1023 2014… 00:3… 106393 3.1.0     x86_64 ming… swirl   2.2.9   BR        248
##  8  1144 2014… 00:0… 106534 3.0.2     x86_64 linu… swirl   2.2.9   US        261
##  9  1402 2014… 00:4…  41261 3.1.0     i386   ming… swirl   2.2.9   US        234
## 10  1424 2014… 00:4… 106393 3.1.0     x86_64 linu… swirl   2.2.9   US        301
## # … with 810 more rows
```

Again, note that filter() recognizes 'package' as a column of cran, without you having to explicitly specify cran$package.

The == operator asks whether the thing on the left is equal to the thing on the right. If yes, then it returns TRUE. If no, then FALSE. In this case, package is an entire vector (column) of values, so package == "swirl" returns a vector of TRUEs and FALSEs. filter() then returns only the rows of cran corresponding to the TRUEs.

You can specify as many conditions as you want, separated by commas. For example filter(cran, r_version == "3.1.1", country == "US") will return all rows of cran corresponding to downloads from users in the US running R version 3.1.1. Try it out.


```r
filter(cran, r_version == "3.1.1", country == "US")
```

```
## # A tibble: 1,588 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1  2216 2014… 00:4… 3.85e5 3.1.1     x86_64 darw… colors… 1.2-4   US        191
##  2 17332 2014… 03:3… 1.97e5 3.1.1     x86_64 darw… httr    0.3     US       1704
##  3 17465 2014… 03:2… 2.33e4 3.1.1     x86_64 darw… snow    0.3-13  US         62
##  4 18844 2014… 03:5… 1.91e5 3.1.1     x86_64 darw… maxLik  1.2-0   US       1533
##  5 30182 2014… 04:1… 7.77e4 3.1.1     i386   ming… random… 4.6-7   US        646
##  6 30193 2014… 04:0… 2.35e6 3.1.1     i386   ming… ggplot2 1.0.0   US          8
##  7 30195 2014… 04:0… 2.99e5 3.1.1     i386   ming… fExtre… 3010.81 US       2010
##  8 30217 2014… 04:3… 5.68e5 3.1.1     i386   ming… rJava   0.9-6   US         98
##  9 30245 2014… 04:1… 5.27e5 3.1.1     i386   ming… LPCM    0.44-8  US          8
## 10 30354 2014… 04:3… 1.76e6 3.1.1     i386   ming… mgcv    1.8-1   US       2122
## # … with 1,578 more rows
```

The conditions passed to filter() can make use of any of the standard comparison operators. Pull up the relevant documentation with ?Comparison (that's an uppercase C).

Edit your previous call to filter() to instead return rows corresponding to users in "IN" (India) running an R version that is less than or equal to "3.0.2". The up arrow on your keyboard may come in handy here. Don't forget your double quotes!


```r
filter(cran, r_version <= "3.0.2", country == "IN")
```

```
## # A tibble: 4,139 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1   348 2014… 00:4… 1.02e7 3.0.0     x86_64 ming… BH      1.54.0… IN        112
##  2  9990 2014… 02:1… 3.97e5 3.0.2     x86_64 linu… equate… 1.1     IN       1054
##  3  9991 2014… 02:1… 1.19e5 3.0.2     x86_64 linu… ggdend… 0.1-14  IN       1054
##  4  9992 2014… 02:1… 8.18e4 3.0.2     x86_64 linu… dfcrm   0.2-2   IN       1054
##  5 10022 2014… 02:1… 1.56e6 2.15.0    x86_64 ming… RcppAr… 0.4.32… IN       1060
##  6 10023 2014… 02:1… 1.18e6 2.15.1    i686   linu… foreca… 5.4     IN       1060
##  7 10189 2014… 02:3… 9.09e5 3.0.2     x86_64 linu… editru… 2.7.2   IN       1054
##  8 10199 2014… 02:3… 1.78e5 3.0.2     x86_64 linu… energy  1.6.1   IN       1054
##  9 10200 2014… 02:3… 5.18e4 3.0.2     x86_64 linu… ENmisc  1.2-7   IN       1054
## 10 10201 2014… 02:3… 6.52e4 3.0.2     x86_64 linu… entropy 1.2.0   IN       1054
## # … with 4,129 more rows
```

Our last two calls to filter() requested all rows for which some condition AND another condition were TRUE. We can also request rows for which EITHER one condition OR another condition are TRUE. For example, filter(cran, country == "US" | country == "IN") will gives us all rows for which the country variable equals either "US" or "IN". Give it a go.


```r
filter(cran, country == "US" | country == "IN")
```

```
## # A tibble: 95,283 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US          1
##  2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US          2
##  3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
##  4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
##  5     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US          3
##  6     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
##  7     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US          5
##  8    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
##  9    11 2014… 00:1… 5.27e5 3.0.2     x86_64 linu… LPCM    0.44-8  US          8
## 10    12 2014… 00:1… 2.35e6 2.14.1    x86_64 linu… ggplot2 1.0.0   US          8
## # … with 95,273 more rows
```

Now, use filter() to fetch all rows for which size is strictly greater than (>) 100500 (no quotes, since size is numeric) AND r_os equals "linux-gnu". Hint: You are passing three arguments to filter(): the name of the dataset, the first condition, and the second condition.


```r
filter(cran, size > 100500, r_os == "linux-gnu")
```

```
## # A tibble: 33,683 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
##  2     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
##  3     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
##  4    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
##  5    11 2014… 00:1… 5.27e5 3.0.2     x86_64 linu… LPCM    0.44-8  US          8
##  6    12 2014… 00:1… 2.35e6 2.14.1    x86_64 linu… ggplot2 1.0.0   US          8
##  7    14 2014… 00:1… 3.10e6 3.0.2     x86_64 linu… Rcpp    0.9.7   VE         10
##  8    15 2014… 00:1… 5.68e5 3.1.0     x86_64 linu… rJava   0.9-6   US         11
##  9    16 2014… 00:1… 1.60e6 3.1.0     x86_64 linu… RSQLite 0.11.4  US          7
## 10    18 2014… 00:2… 1.87e5 3.1.0     x86_64 linu… ipred   0.9-3   DE         13
## # … with 33,673 more rows
```

Finally, we want to get only the rows for which the r_version is not missing. R represents missing values with NA and these missing values can be detected using the is.na() function.

To see how this works, try is.na(c(3, 5, NA, 10)).


```r
is.na(c(3, 5, NA, 10))
```

```
## [1] FALSE FALSE  TRUE FALSE
```

Now, put an exclamation point (!) before is.na() to change all of the TRUEs to FALSEs and all of the FALSEs to TRUEs, thus telling us what is NOT NA: !is.na(c(3, 5, NA, 10)).


```r
!is.na(c(3, 5, NA, 10))
```

```
## [1]  TRUE  TRUE FALSE  TRUE
```

Okay, ready to put all of this together? Use filter() to return all rows of cran for which r_version is NOT NA. Hint: You will need to use !is.na() as part of your second argument to filter().


```r
filter(cran, !is.na(r_version))
```

```
## # A tibble: 207,205 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US          1
##  2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US          2
##  3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
##  4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
##  5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA          4
##  6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US          3
##  7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
##  8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US          5
##  9    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
## 10    11 2014… 00:1… 5.27e5 3.0.2     x86_64 linu… LPCM    0.44-8  US          8
## # … with 207,195 more rows
```

We've seen how to select a subset of columns and rows from our dataset using select() and filter(), respectively. Inherent in select() was also the ability to arrange our selected columns in any order we please.

Sometimes we want to order the rows of a dataset according to the values of a particular variable. This is the job of arrange().

To see how arrange() works, let's first take a subset of cran. select() all columns from size through ip_id and store the result in cran2.


```r
cran2 <- select(cran, size:ip_id)
```

Now, to order the ROWS of cran2 so that ip_id is in ascending order (from small to large), type arrange(cran2, ip_id). You may want to make your console wide enough so that you can see ip_id, which is the last column.


```r
arrange(cran2, ip_id)
```

```
## # A tibble: 225,468 x 8
##      size r_version r_arch r_os         package     version country ip_id
##     <int> <chr>     <chr>  <chr>        <chr>       <chr>   <chr>   <int>
##  1  80589 3.1.0     x86_64 mingw32      htmltools   0.2.4   US          1
##  2 180562 3.0.2     x86_64 mingw32      yaml        2.1.13  US          1
##  3 190120 3.1.0     i386   mingw32      babel       0.2-6   US          1
##  4 321767 3.1.0     x86_64 mingw32      tseries     0.10-32 US          2
##  5  52281 3.0.3     x86_64 darwin10.8.0 quadprog    1.5-5   US          2
##  6 876702 3.1.0     x86_64 linux-gnu    zoo         1.7-11  US          2
##  7 321764 3.0.2     x86_64 linux-gnu    tseries     0.10-32 US          2
##  8 876702 3.1.0     x86_64 linux-gnu    zoo         1.7-11  US          2
##  9 321768 3.1.0     x86_64 mingw32      tseries     0.10-32 US          2
## 10 784093 3.1.0     x86_64 linux-gnu    strucchange 1.5-0   US          2
## # … with 225,458 more rows
```

To do the same, but in descending order, change the second argument to desc(ip_id), where desc() stands for 'descending'. Go ahead.


```r
arrange(cran2, desc(ip_id))
```

```
## # A tibble: 225,468 x 8
##       size r_version r_arch r_os         package      version country ip_id
##      <int> <chr>     <chr>  <chr>        <chr>        <chr>   <chr>   <int>
##  1    5933 <NA>      <NA>   <NA>         CPE          1.4.2   CN      13859
##  2  569241 3.1.0     x86_64 mingw32      multcompView 0.1-5   US      13858
##  3  228444 3.1.0     x86_64 mingw32      tourr        0.5.3   NZ      13857
##  4  308962 3.1.0     x86_64 darwin13.1.0 ctv          0.7-9   CN      13856
##  5  950964 3.0.3     i386   mingw32      knitr        1.6     CA      13855
##  6   80185 3.0.3     i386   mingw32      htmltools    0.2.4   CA      13855
##  7 1431750 3.0.3     i386   mingw32      shiny        0.10.0  CA      13855
##  8 2189695 3.1.0     x86_64 mingw32      RMySQL       0.9-3   US      13854
##  9 4818024 3.1.0     i386   mingw32      igraph       0.7.1   US      13853
## 10  197495 3.1.0     x86_64 mingw32      coda         0.16-1  US      13852
## # … with 225,458 more rows
```

We can also arrange the data according to the values of multiple variables. For example, arrange(cran2, package, ip_id) will first arrange by package names (ascending alphabetically), then by ip_id. This means that if there are multiple rows with the same value for package, they will be sorted by ip_id (ascending numerically). Try arrange(cran2, package, ip_id) now.


```r
arrange(cran2, package, ip_id)
```

```
## # A tibble: 225,468 x 8
##     size r_version r_arch r_os         package version country ip_id
##    <int> <chr>     <chr>  <chr>        <chr>   <chr>   <chr>   <int>
##  1 71677 3.0.3     x86_64 darwin10.8.0 A3      0.9.2   CN       1003
##  2 71672 3.1.0     x86_64 linux-gnu    A3      0.9.2   US       1015
##  3 71677 3.1.0     x86_64 mingw32      A3      0.9.2   IN       1054
##  4 70438 3.0.1     x86_64 darwin10.8.0 A3      0.9.2   CN       1513
##  5 71677 <NA>      <NA>   <NA>         A3      0.9.2   BR       1526
##  6 71892 3.0.2     x86_64 linux-gnu    A3      0.9.2   IN       1542
##  7 71677 3.1.0     x86_64 linux-gnu    A3      0.9.2   ZA       2925
##  8 71672 3.1.0     x86_64 mingw32      A3      0.9.2   IL       3889
##  9 71677 3.0.3     x86_64 mingw32      A3      0.9.2   DE       3917
## 10 71672 3.1.0     x86_64 mingw32      A3      0.9.2   US       4219
## # … with 225,458 more rows
```

Arrange cran2 by the following three variables, in this order: country (ascending), r_version (descending), and ip_id (ascending).


```r
arrange(cran2, country, desc(r_version), ip_id)
```

```
## # A tibble: 225,468 x 8
##       size r_version r_arch r_os      package       version   country ip_id
##      <int> <chr>     <chr>  <chr>     <chr>         <chr>     <chr>   <int>
##  1 1556858 3.1.1     i386   mingw32   RcppArmadillo 0.4.320.0 A1       2843
##  2 1823512 3.1.0     x86_64 linux-gnu mgcv          1.8-1     A1       2843
##  3   15732 3.1.0     i686   linux-gnu grnn          0.1.0     A1       3146
##  4 3014840 3.1.0     x86_64 mingw32   Rcpp          0.11.2    A1       3146
##  5  660087 3.1.0     i386   mingw32   xts           0.9-7     A1       3146
##  6  522261 3.1.0     i386   mingw32   FNN           1.1       A1       3146
##  7  522263 3.1.0     i386   mingw32   FNN           1.1       A1       3146
##  8 1676627 3.1.0     x86_64 linux-gnu rgeos         0.3-5     A1       3146
##  9 2118530 3.1.0     x86_64 linux-gnu spacetime     1.1-0     A1       3146
## 10 2217180 3.1.0     x86_64 mingw32   gstat         1.0-19    A1       3146
## # … with 225,458 more rows
```

To illustrate the next major function in dplyr, let's take another subset of our original data. Use select() to grab 3 columns from cran -- ip_id, package, and size (in that order) -- and store the result in a new variable called cran3.


```r
cran3 <- select(cran, ip_id, package, size)
```


```r
cran3
```

```
## # A tibble: 225,468 x 3
##    ip_id package         size
##    <int> <chr>          <int>
##  1     1 htmltools      80589
##  2     2 tseries       321767
##  3     3 party         748063
##  4     3 Hmisc         606104
##  5     4 digest         79825
##  6     3 randomForest   77681
##  7     3 plyr          393754
##  8     5 whisker        28216
##  9     6 Rcpp            5928
## 10     7 hflights     2206029
## # … with 225,458 more rows
```

It's common to create a new variable based on the value of one or more variables already in a dataset. The mutate() function does exactly this.

The size variable represents the download size in bytes, which are units of computer memory. These days, megabytes (MB) are a more common unit of measurement. One megabyte is equal to 2^20 bytes. That's 2 to the power of 20, which is approximately one million bytes!

We want to add a column called size_mb that contains the download size in megabytes. Here's the code to do it: mutate(cran3, size_mb = size / 2^20)


```r
mutate(cran3, size_mb = size / 2^20)
```

```
## # A tibble: 225,468 x 4
##    ip_id package         size size_mb
##    <int> <chr>          <int>   <dbl>
##  1     1 htmltools      80589 0.0769 
##  2     2 tseries       321767 0.307  
##  3     3 party         748063 0.713  
##  4     3 Hmisc         606104 0.578  
##  5     4 digest         79825 0.0761 
##  6     3 randomForest   77681 0.0741 
##  7     3 plyr          393754 0.376  
##  8     5 whisker        28216 0.0269 
##  9     6 Rcpp            5928 0.00565
## 10     7 hflights     2206029 2.10   
## # … with 225,458 more rows
```

An even larger unit of memory is a gigabyte (GB), which equals 2^10 megabytes. We might as well add another column for download size in gigabytes!

One very nice feature of mutate() is that you can use the value computed for your second column (size_mb) to create a third column, all in the same line of code. To see this in action, repeat the exact same command as above, except add a third argument creating a column that is named size_gb and equal to size_mb / 2^10.


```r
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
```

```
## # A tibble: 225,468 x 5
##    ip_id package         size size_mb    size_gb
##    <int> <chr>          <int>   <dbl>      <dbl>
##  1     1 htmltools      80589 0.0769  0.0000751 
##  2     2 tseries       321767 0.307   0.000300  
##  3     3 party         748063 0.713   0.000697  
##  4     3 Hmisc         606104 0.578   0.000564  
##  5     4 digest         79825 0.0761  0.0000743 
##  6     3 randomForest   77681 0.0741  0.0000723 
##  7     3 plyr          393754 0.376   0.000367  
##  8     5 whisker        28216 0.0269  0.0000263 
##  9     6 Rcpp            5928 0.00565 0.00000552
## 10     7 hflights     2206029 2.10    0.00205   
## # … with 225,458 more rows
```

Let's try one more for practice. Pretend we discovered a glitch in the system that provided the original values for the size variable. All of the values in cran3 are 1000 bytes less than they should be. Using cran3, create just one new column called correct_size that contains the correct size.


```r
mutate(cran3, correct_size = size + 1000)
```

```
## # A tibble: 225,468 x 4
##    ip_id package         size correct_size
##    <int> <chr>          <int>        <dbl>
##  1     1 htmltools      80589        81589
##  2     2 tseries       321767       322767
##  3     3 party         748063       749063
##  4     3 Hmisc         606104       607104
##  5     4 digest         79825        80825
##  6     3 randomForest   77681        78681
##  7     3 plyr          393754       394754
##  8     5 whisker        28216        29216
##  9     6 Rcpp            5928         6928
## 10     7 hflights     2206029      2207029
## # … with 225,458 more rows
```

The last of the five core dplyr verbs, summarize(), collapses the dataset to a single row. Let's say we're interested in knowing the average download size. summarize(cran, avg_bytes = mean(size)) will yield the mean value of the size variable. Here we've chosen to label the result 'avg_bytes', but we could have named it anything. Give it a try.


```r
summarize(cran, avg_bytes = mean(size))
```

```
## # A tibble: 1 x 1
##   avg_bytes
##       <dbl>
## 1   844086.
```

That's not particularly interesting. summarize() is most useful when working with data that has been grouped by the values of a particular variable.

We'll look at grouped data in the next lesson, but the idea is that summarize() can give you the requested value FOR EACH group in your dataset.

In this lesson, you learned how to manipulate data using dplyr's five main functions. In the next lesson, we'll look at how to take advantage of some other useful features of dplyr to make your life as a data analyst much easier.

## Grouping and Chaining with dplyr

In the last lesson, you learned about the five main data manipulation 'verbs' in dplyr: select(), filter(), arrange(), mutate(), and summarize(). The last of these, summarize(), is most powerful when applied to grouped data.

The main idea behind grouping data is that you want to break up your dataset into groups of rows based on the values of one or more variables. The group_by() function is reponsible for doing this.

We'll continue where we left off with RStudio's CRAN download log from July 8, 2014, which contains information on roughly 225,000 R package downloads (http://cran-logs.rstudio.com/).

I've made the dataset available to you in a data frame called mydf. Put it in a 'data frame tbl' using the tbl_df() function and store the result in a object called cran. If you're not sure what I'm talking about, you should start with the previous lesson. Otherwise, practice
| makes perfect!


```r
#cran <- tbl_df(mydf)
```

To avoid confusion and keep things running smoothly, let's remove the original dataframe from your workspace with rm("mydf").


```r
#rm("mydf")
```

Print cran to the console.


```r
cran
```

```
## # A tibble: 225,468 x 11
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US          1
##  2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US          2
##  3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
##  4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
##  5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA          4
##  6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US          3
##  7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
##  8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US          5
##  9     9 2014… 00:5… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN          6
## 10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
## # … with 225,458 more rows
```

Our first goal is to group the data by package name. Bring up the help file for group_by().

Group cran by the package variable and store the result in a new object called by_package.


```r
by_package <- group_by(cran, package)
```

Let's take a look at by_package. Print it to the console.


```r
by_package
```

```
## # A tibble: 225,468 x 11
## # Groups:   package [6,023]
##        X date  time    size r_version r_arch r_os  package version country ip_id
##    <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
##  1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US          1
##  2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US          2
##  3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
##  4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
##  5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA          4
##  6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US          3
##  7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
##  8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US          5
##  9     9 2014… 00:5… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN          6
## 10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
## # … with 225,458 more rows
```

At the top of the output above, you'll see 'Groups: package', which tells us that this tbl has been grouped by the package variable. Everything else looks the same, but now any operation we apply to the grouped data will take place on a per package basis.

Recall that when we applied mean(size) to the original tbl_df via summarize(), it returned a single number -- the mean of all values in the size column. We may care about what that number is, but wouldn't it be so much more interesting to look at the mean download size for each unique package?

That's exactly what you'll get if you use summarize() to apply mean(size) to the grouped data in by_package. Give it a shot.


```r
summarize(by_package, mean(size))
```

```
## # A tibble: 6,023 x 2
##    package     `mean(size)`
##    <chr>              <dbl>
##  1 A3                62195.
##  2 abc             4826665 
##  3 abcdeFBA         455980.
##  4 ABCExtremes       22904.
##  5 ABCoptim          17807.
##  6 ABCp2             30473.
##  7 abctools        2589394 
##  8 abd              453631.
##  9 abf2              35693.
## 10 abind             32939.
## # … with 6,013 more rows
```

Instead of returning a single value, summarize() now returns the mean size for EACH package in our dataset.

Let's take it a step further. I just opened an R script for you that contains a partially constructed call to summarize(). Follow the instructions in the script comments.


```r
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
```

Print the resulting tbl, pack_sum, to the console to examine its contents.


```r
pack_sum
```

```
## # A tibble: 6,023 x 5
##    package     count unique countries avg_bytes
##    <chr>       <int>  <int>     <int>     <dbl>
##  1 A3             25     24        10    62195.
##  2 abc            29     25        16  4826665 
##  3 abcdeFBA       15     15         9   455980.
##  4 ABCExtremes    18     17         9    22904.
##  5 ABCoptim       16     15         9    17807.
##  6 ABCp2          18     17        10    30473.
##  7 abctools       19     19        11  2589394 
##  8 abd            17     16        10   453631.
##  9 abf2           13     13         9    35693.
## 10 abind         396    365        50    32939.
## # … with 6,013 more rows
```

The 'count' column, created with n(), contains the total number of rows (i.e. downloads) for each package. The 'unique' column, created with n_distinct(ip_id), gives the total number of unique downloads for each package, as measured by the number of distinct ip_id's. The 'countries' column, created with n_distinct(country), provides the number of countries in which each package was downloaded. And finally, the 'avg_bytes' column, created with mean(size), contains the mean download size (in bytes) for each package.

It's important that you understand how each column of pack_sum was created and what it means. Now that we've summarized the data by individual packages, let's play around with it some more to see what we can learn.

Naturally, we'd like to know which packages were most popular on the day these data were collected (July 8, 2014). Let's start by isolating the top 1% of packages, based on the total number of downloads as measured by the 'count' column.

We need to know the value of 'count' that splits the data into the top 1% and bottom 99% of packages based on total downloads. In statistics, this is called the 0.99, or 99%, sample quantile. Use quantile(pack_sum$count, probs = 0.99) to determine this number.


```r
quantile(pack_sum$count, probs = 0.99)
```

```
##    99% 
## 679.56
```

Now we can isolate only those packages which had more than 679 total downloads. Use filter() to select all rows from pack_sum for which 'count' is strictly greater (>) than 679. Store the result in a new object called top_counts.


```r
top_counts <- filter(pack_sum, count > 679)
```

Let's take a look at top_counts. Print it to the console.


```r
top_counts
```

```
## # A tibble: 61 x 5
##    package    count unique countries avg_bytes
##    <chr>      <int>  <int>     <int>     <dbl>
##  1 bitops      1549   1408        76    28715.
##  2 car         1008    837        64  1229122.
##  3 caTools      812    699        64   176589.
##  4 colorspace  1683   1433        80   357411.
##  5 data.table   680    564        59  1252721.
##  6 DBI         2599    492        48   206933.
##  7 devtools     769    560        55   212933.
##  8 dichromat   1486   1257        74   134732.
##  9 digest      2210   1894        83   120549.
## 10 doSNOW       740     75        24     8364.
## # … with 51 more rows
```

There are only 61 packages in our top 1%, so we'd like to see all of them. Since dplyr only shows us the first 10 rows, we can use the View() function to see more.  
  

```r
#View(top_counts)
```

arrange() the rows of top_counts based on the 'count' column and assign the result to a new object called top_counts_sorted. We want the packages with the highest number of downloads at the top, which means we want 'count' to be in descending order. If you need help, check out ?arrange and/or ?desc.


```r
top_counts_sorted <- arrange(top_counts, desc(count))
```

Now use View() again to see all 61 rows of top_counts_sorted.


```r
#View(top_counts_sorted)
```

If we use total number of downloads as our metric for popularity, then the above output shows us the most popular packages downloaded from the RStudio CRAN mirror on July 8, 2014. Not surprisingly, ggplot2 leads the pack with 4602 downloads, followed by Rcpp, plyr, rJava, ....

And if you keep on going, you'll see swirl at number 43, with 820 total downloads. Sweet!

Perhaps we're more interested in the number of *unique* downloads on this particular day. In other words, if a package is downloaded ten times in one day from the same computer, we may wish to count that as only one download. That's what the 'unique' column will tell us.

Like we did with 'count', let's find the 0.99, or 99%, quantile for the 'unique' variable with quantile(pack_sum$unique, probs = 0.99).


```r
quantile(pack_sum$unique, probs = 0.99)
```

```
## 99% 
## 465
```

Apply filter() to pack_sum to select all rows corresponding to values of 'unique' that are strictly greater than 465. Assign the result to a object called top_unique.


```r
top_unique <- filter(pack_sum, unique > 465)
```

Let's View() our top contenders!


```r
#View(top_unique)
```

Now arrange() top_unique by the 'unique' column, in descending order, to see which packages were downloaded from the greatest number of unique IP addresses. Assign the result to top_unique_sorted.


```r
top_unique_sorted <- arrange(top_unique, desc(unique))
```

View() the sorted data.


```r
#View(top_unique_sorted)
```

Now Rcpp is in the lead, followed by stringr, digest, plyr, and ggplot2. swirl moved up a few spaces to number 40, with 698 unique downloads. Nice!

Our final metric of popularity is the number of distinct countries from which each package was downloaded. We'll approach this one a little differently to introduce you to a method called 'chaining' (or 'piping').

Chaining allows you to string together multiple function calls in a way that is compact and readable, while still accomplishing the desired result. To make it more concrete, let's compute our last popularity metric from scratch, starting with our original data.

I've opened up a script that contains code similar to what you've seen so far. Don't change anything. Just study it for a minute, make sure you understand everything that's there, then submit() when you are ready to move on.


```r
        by_package <- group_by(cran, package)
        pack_sum <- summarize(by_package,
                              count = n(),
                              unique = n_distinct(ip_id),
                              countries = n_distinct(country),
                              avg_bytes = mean(size))
```

It's worth noting that we sorted primarily by country, but used avg_bytes (in ascending order) as a tie breaker. This means that if two packages were downloaded from the same number of countries, the package with a smaller average download size received a higher ranking.

We'd like to accomplish the same result as the last script, but avoid saving our intermediate results. This requires embedding function calls within one another.


```r
        top_countries <- filter(pack_sum, countries > 60)
        result1 <- arrange(top_countries, desc(countries), avg_bytes)
        
        # Print the results to the console.
        print(result1)
```

```
## # A tibble: 46 x 5
##    package      count unique countries avg_bytes
##    <chr>        <int>  <int>     <int>     <dbl>
##  1 Rcpp          3195   2044        84  2512100.
##  2 digest        2210   1894        83   120549.
##  3 stringr       2267   1948        82    65277.
##  4 plyr          2908   1754        81   799123.
##  5 ggplot2       4602   1680        81  2427716.
##  6 colorspace    1683   1433        80   357411.
##  7 RColorBrewer  1890   1584        79    22764.
##  8 scales        1726   1408        77   126819.
##  9 bitops        1549   1408        76    28715.
## 10 reshape2      2032   1652        76   330128.
## # … with 36 more rows
```

That's exactly what we've done in this script. The result is equivalent, but the code is much less readable and some of the arguments are far away from the function to which they belong. Again, just try to understand what is going on here, then submit() when you are ready to see a better solution.

In this script, we've used a special chaining operator, %>%, which was originally introduced in the magrittr R package and has now become a key component of dplyr. You can pull up the related documentation with ?chain. The benefit of %>% is that it allows us to chain the function calls in a linear fashion. The code to the right of %>% operates on the result from the code to the left of %>%.


```r
                result2 <-
                arrange(
                        filter(
                                summarize(
                                        group_by(cran,
                                                 package
                                        ),
                                        count = n(),
                                        unique = n_distinct(ip_id),
                                        countries = n_distinct(country),
                                        avg_bytes = mean(size)
                                ),
                                countries > 60
                        ),
                        desc(countries),
                        avg_bytes
                )
        
        print(result2)
```

```
## # A tibble: 46 x 5
##    package      count unique countries avg_bytes
##    <chr>        <int>  <int>     <int>     <dbl>
##  1 Rcpp          3195   2044        84  2512100.
##  2 digest        2210   1894        83   120549.
##  3 stringr       2267   1948        82    65277.
##  4 plyr          2908   1754        81   799123.
##  5 ggplot2       4602   1680        81  2427716.
##  6 colorspace    1683   1433        80   357411.
##  7 RColorBrewer  1890   1584        79    22764.
##  8 scales        1726   1408        77   126819.
##  9 bitops        1549   1408        76    28715.
## 10 reshape2      2032   1652        76   330128.
## # … with 36 more rows
```

So, the results of the last three scripts are all identical. But, the third script provides a convenient and concise alternative to the more traditional method that we've taken previously, which involves saving results as we go along.


```r
                result3 <-
                cran %>%
                group_by(package) %>%
                summarize(count = n(),
                          unique = n_distinct(ip_id),
                          countries = n_distinct(country),
                          avg_bytes = mean(size)
                ) %>%
                filter(countries > 60) %>%
                arrange(desc(countries), avg_bytes)
        
        # Print result to console
        print(result3)
```

```
## # A tibble: 46 x 5
##    package      count unique countries avg_bytes
##    <chr>        <int>  <int>     <int>     <dbl>
##  1 Rcpp          3195   2044        84  2512100.
##  2 digest        2210   1894        83   120549.
##  3 stringr       2267   1948        82    65277.
##  4 plyr          2908   1754        81   799123.
##  5 ggplot2       4602   1680        81  2427716.
##  6 colorspace    1683   1433        80   357411.
##  7 RColorBrewer  1890   1584        79    22764.
##  8 scales        1726   1408        77   126819.
##  9 bitops        1549   1408        76    28715.
## 10 reshape2      2032   1652        76   330128.
## # … with 36 more rows
```

Once again, let's View() the full data, which has been stored in result3.


```r
#View(result3)
```

It looks like Rcpp is on top with downloads from 84 different countries, followed by digest, stringr, plyr, and ggplot2. swirl jumped up the rankings again, this time to 27th.

To help drive the point home, let's work through a few more examples of chaining.

Let's build a chain of dplyr commands one step at a time, starting with the script I just opened for you.


```r
                cran %>%
                select(ip_id, country, package, size) %>%
                mutate(size_mb = size / 2^20) %>%
                filter(size_mb <= 0.5) %>%
                arrange(desc(size_mb))
```

```
## # A tibble: 142,021 x 5
##    ip_id country package                 size size_mb
##    <int> <chr>   <chr>                  <int>   <dbl>
##  1 11034 DE      phia                  524232   0.500
##  2  9643 US      tis                   524152   0.500
##  3  1542 IN      RcppSMC               524060   0.500
##  4 12354 US      lessR                 523916   0.500
##  5 12072 US      colorspace            523880   0.500
##  6  2514 KR      depmixS4              523863   0.500
##  7  1111 US      depmixS4              523858   0.500
##  8  8865 CR      depmixS4              523858   0.500
##  9  5908 CN      RcmdrPlugin.KMggplot2 523852   0.500
## 10 12354 US      RcmdrPlugin.KMggplot2 523852   0.500
## # … with 142,011 more rows
```

In this lesson, you learned about grouping and chaining using dplyr. You combined some of the things you learned in the previous lesson with these more advanced ideas to produce concise, readable, and highly effective code. Welcome to the wonderful world of dplyr!
