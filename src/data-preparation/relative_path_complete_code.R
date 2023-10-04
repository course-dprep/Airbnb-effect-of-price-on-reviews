```{r}
## installing all necessary packages
install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)


#download data
library(readr)

# Define the list of city URLs
citys <- list(
  amsterdam = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2023-09-03/visualisations/listings.csv",
  berlin = "http://data.insideairbnb.com/germany/be/berlin/2023-06-22/visualisations/listings.csv",
  brussels = "http://data.insideairbnb.com/belgium/bru/brussels/2023-06-24/visualisations/listings.csv",
  london = "http://data.insideairbnb.com/united-kingdom/england/london/2023-06-08/visualisations/listings.csv",
  paris = "http://data.insideairbnb.com/france/ile-de-france/paris/2023-06-06/visualisations/listings.csv"
)

# Loop through the city URLs and create data frames
for (city_name in names(citys)) {
  url <- citys[[city_name]]
  
  # Read the CSV data from the URL and store it in a data frame with the city name
  assign(city_name, read.csv(url))
  
  # Print a message to indicate completion
  cat("Downloaded data for", city_name, "\n")
}

# Now, you should have separate data frames named amsterdam, berlin, brussels, london, and paris.

#code for private rooms segmentation
city_names <- c("amsterdam", "berlin", "brussels", "paris", "london")


# Loop through the city names and filter the corresponding data frames
for (city_name in city_names) {
  # Filter the data frame for "Private room" listings
  assign(paste(city_name, "_private_rooms", sep = ""), 
         get(city_name) %>%  # Access the original data frame by name
           filter(room_type == "Private room"))
  
  # Print a message to indicate completion
  cat("Filtered data for Private rooms in", city_name, "\n")
}

#sort private rooms by price in each city
for (city_name in city_names) {
  # Access the data frame for private rooms in the current city
  city_df <- get(paste(city_name, "_private_rooms", sep = ""))
  
  # Sort the data frame by the "price" column in ascending order
  sorted_df <- city_df %>% arrange(price)
  
  # Assign the sorted data frame back to the original variable
  assign(paste(city_name, "_private_rooms", sep = ""), sorted_df)
  
  # Print a message to indicate completion
  cat("Sorted data for Private rooms in", city_name, "by price\n")
}



















```
