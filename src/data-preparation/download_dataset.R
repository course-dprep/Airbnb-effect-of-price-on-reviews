library(tidyverse)




na.omit(listings_excel$price)
View(listings_excel)
mean(listings_excel$price)
write_csv(listings_excel, "datasetairbnb")
