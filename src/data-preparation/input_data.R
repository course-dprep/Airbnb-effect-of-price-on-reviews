## installing all necessary packages
options(repos = "https://cloud.r-project.org")
install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)

#download data
library(readr)
library(dplyr)
library(tidyverse)
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
  assign(city_name, read.csv(url))
  
  # Print a message to indicate completion
  cat("Downloaded data for", city_name, "\n")
} 
  
# Combine all the separate CSV files into one data frame
all_data <- bind_rows(
  amsterdam_2022, berlin_2022, brussels_2022, london_2022, paris_2022,
  amsterdam_2023, berlin_2023, brussels_2023, london_2023, paris_2023
)

# Specify the directory where you want to save the CSV file
output_directory <- "../../gen/data-preparation/temp/"

# Save the combined data frame as data_framed.csv
combined_csv_path <- file.path(output_directory, "data_framed.csv")
write.csv(all_data, file = combined_csv_path, row.names = FALSE)

cat("Combined data saved as CSV:", combined_csv_path, "\n")
  
