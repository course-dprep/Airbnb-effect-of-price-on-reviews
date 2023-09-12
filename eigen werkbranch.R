
R version 4.2.2 (2022-10-31 ucrt) -- "Innocent and Trusting"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> library(readxl)
> listings_1_ <- read_excel("~/Max/Universiteit/Master Marketing Analytics/Data Preparation & Workflow Management/team-project-data-prep-team-10/listings (1).csv")
Error: Can't establish that the input is either xls or xlsx.
> library(readxl)
> listings_1_ <- read_excel("~/Max/Universiteit/Master Marketing Analytics/Data Preparation & Workflow Management/team-project-data-prep-team-10/listings (1).xlsx")
New names:
• `` -> `...2`
Warning messages:
1: Expecting logical in B4373 / R4373C2: got 'Mayra,,Oud-Oost,52.36286,4.91999,Private room,260,3,0,,,1,52,0,0363 EB9B 52EA B671 2DF5' 
2: Expecting logical in B4376 / R4376C2: got 'Fleur,,Oud-Oost,52.36052,4.90946,Private room,141,2,13,2023-03-03,0.60,2,350,4,0363 14D4 DF79 9868 F4F0' 
3: Expecting logical in B4379 / R4379C2: got 'Fleur,,Centrum-Oost,52.3609,4.90943,Private room,141,2,36,2023-01-27,1.55,2,344,10,0363 14D4 DF79 9868 F4F0' 
> View(listings_1_)
> setwd("C:/Users/jurge/Documents/Max/Universiteit/Master Marketing Analytics/Data Preparation & Workflow Management/team-project-data-prep-team-10")
> library(readr)
> listings_1_ <- read_csv("listings (1).csv")
Rows: 7608 Columns: 18                                                                                                
── Column specification ───────────────────────────────────────────────────────────
Delimiter: ","
chr   (6): id, name, host_name, neighbourhood, room_type, license;
dbl  (10): host_id, latitude, longitude, price, minimum_nights, number_of_revie...
lgl   (1): neighbourhood_group
date  (1): last_review

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Warning message:
One or more parsing issues, call `problems()` on your data frame for details,
e.g.:
  dat <- vroom(...)
  problems(dat) 
> View(listings_1_)
> Summary(Price)
Error in h(simpleError(msg, call)) : 
  error in evaluating the argument 'x' in selecting a method for function 'Summary': object 'Price' not found
> # Maak een subset van appartementen met 'room_type' gelijk aan 'Private Room'
> subset_van_appartementen <- subset(listings_1_, room_type == "Private Room")
> 
> View(subset_van_appartementen)
> # Maak een subset van appartementen met 'room_type' gelijk aan 'Private room'
> subset_van_appartementen <- subset(listings_1_, room_type == "Private room")
> 
> View(subset_van_appartementen)
> mean(listings_1_, price)
[1] NA
Warning message:
In mean.default(listings_1_, price) :
  argument is not numeric or logical: returning NA
> subset_van_appartementen <- na.omit(subset_van_appartementen)
> > # Maak een subset van appartementen met 'room_type' gelijk aan 'Private room'
Error: unexpected '>' in ">"
>  # Maak een subset van appartementen met 'room_type' gelijk aan 'Private room'
>  subset_van_appartementen <- subset(listings_1_, room_type == "Private room")
> subset_van_appartementen <- subset_van_appartementen[!is.na(subset_van_appartementen$price), ]
> 
> 
> mean(price)
Error in mean(price) : object 'price' not found
> mean(listings_1_, price)
[1] NA
Warning message:
In mean.default(listings_1_, price) :
  argument is not numeric or logical: returning NA
> gemiddelde_prijs <- mean(subset_van_appartementen$price)
> 
> View(subset_van_appartementen)
> # Splits de gegevens in twee groepen
> minder_reviews <- data %>% filter(subset_van_appartementen$number_of_reviews_ltm < 100)
Error in data %>% filter(subset_van_appartementen$number_of_reviews_ltm <  : 
  could not find function "%>%"
> # Splits de gegevens in twee groepen
> minder_reviews <- subset_van_appartementen %>% filter(number_of_reviews_ltm < 100)
Error in subset_van_appartementen %>% filter(number_of_reviews_ltm < 100) : 
  could not find function "%>%"
> install.packages("dplyr")
Error in install.packages : Updating loaded packages

Restarting R session...

> install.packages("dplyr")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into ‘C:/Users/jurge/AppData/Local/R/win-library/4.2’
(as ‘lib’ is unspecified)
also installing the dependency ‘pillar’

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/pillar_1.9.0.zip'
Content type 'application/zip' length 658597 bytes (643 KB)
downloaded 643 KB

trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.2/dplyr_1.1.3.zip'
Content type 'application/zip' length 1556597 bytes (1.5 MB)
downloaded 1.5 MB

package ‘pillar’ successfully unpacked and MD5 sums checked
package ‘dplyr’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\jurge\AppData\Local\Temp\Rtmpe4iaCy\downloaded_packages
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

Warning message:
package ‘dplyr’ was built under R version 4.2.3 
> # Splits de gegevens in twee groepen
> minder_reviews <- subset_van_appartementen %>% filter(number_of_reviews_ltm < 100)
> meer_reviews <- subset_van_appartementen %>% filter(number_of_reviews_ltm >= 100)
> View(meer_reviews)
> gemiddelde_prijs_min <- mean(meer_reviews$price)
> gemiddelde_prijs_mee <- mean(minder_reviews$price)
> gemiddelde_prijs_mee <- mean(meer_reviews$price)
> gemiddelde_prijs_min <- mean(minder_reviews$price) 