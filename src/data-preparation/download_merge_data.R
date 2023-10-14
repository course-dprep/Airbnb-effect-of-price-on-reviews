
## installing all necessary packages
library(tidyverse)
library(dplyr)
library(readr)

# Define the list of city URLs
city_year <- list(
  amsterdam_2022 = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-12-05/visualisations/listings.csv",
  berlin_2022 = "http://data.insideairbnb.com/germany/be/berlin/2022-12-21/visualisations/listings.csv",
  brussels_2022 = "http://data.insideairbnb.com/belgium/bru/brussels/2022-12-24/visualisations/listings.csv",
  london_2022 = "http://data.insideairbnb.com/united-kingdom/england/london/2022-12-10/visualisations/listings.csv",
  paris_2022 = "http://data.insideairbnb.com/france/ile-de-france/paris/2022-12-10/visualisations/listings.csv",
  amsterdam_2023 = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2023-06-05/visualisations/listings.csv",
  berlin_2023 = "http://data.insideairbnb.com/germany/be/berlin/2023-06-22/visualisations/listings.csv",
  brussels_2023 = "http://data.insideairbnb.com/belgium/bru/brussels/2023-06-24/visualisations/listings.csv",
  london_2023 = "http://data.insideairbnb.com/united-kingdom/england/london/2023-06-08/visualisations/listings.csv",
  paris_2023 = "http://data.insideairbnb.com/france/ile-de-france/paris/2023-06-06/visualisations/listings.csv"
)

# Loop through the city URLs and create data frames
for (city_name in names(city_year)) {
  url <- city_year[[city_name]]
  
  # Read the CSV data from the URL and store it in a data frame with the city name
  assign(city_name, read_csv(url))
  
  # Print a message to indicate completion
  cat("Downloaded data for", city_name, "\n")
} 

#include city code for each city to identify which city the data is from

city_names <- c("amsterdam_2022", "amsterdam_2023", "brussels_2022", "brussels_2023", "paris_2022", "paris_2023", "london_2022", "london_2023", "berlin_2022", "berlin_2023")

# Define a vector of city codes corresponding to the order of city names
city_codes <- c("AMS", "AMS", "BRU", "BRU", "PAR", "PAR", "LON", "LON", "BER", "BER")

for (i in 1:length(city_names)) {
  city_df <- get(city_names[i])
  city_df <- city_df %>%
    mutate(city_code = city_codes[i])
  
  # Assign the modified data frame back to its original name
  assign(city_names[i], city_df)
}


# Combine all the separate CSV files into one data frame
all_data <- bind_rows(
  amsterdam_2022, berlin_2022, brussels_2022, london_2022, paris_2022,
  amsterdam_2023, berlin_2023, brussels_2023, london_2023, paris_2023
)

# Create directories to save data
dir.create('../../gen')
dir.create('../../gen/data-preparation')
dir.create('../../gen/data-preparation/temp')
dir.create('../../gen/data-preparation/output')
write.csv(all_data, file = "../../gen/data-preparation/temp/data_framed.csv", fileEncoding = "UTF-8",row.names=FALSE )

cat("Combined data saved as CSV:\n")
