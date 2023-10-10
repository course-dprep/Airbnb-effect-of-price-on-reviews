# Set up
options(repos = "https://cloud.r-project.org")
library(tidyverse)
library(ggplot2)
library(dplyr)

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

# Create a directory to store the plots
dir.create("barcharts")

# Create a directory to store the summary data
dir.create("summary_data")

# Create an empty list to store the summary data for each city
summary_list <- list()

# Loop through the city URLs and create data frames
for (city_name in names(city_year)) {
  url <- city_year[[city_name]]
  
  # Read the CSV data from the URL and store it in a data frame with the city name
  assign(city_name, read.csv(url))
}

# Code for private rooms segmentation
city_names <- names(city_year)

# Loop through the city names and filter the corresponding data frames
for (city_name in city_names) {
  # Filter the data frame for "Private room" listings
  assign(paste(city_name, "_private_rooms", sep = ""), 
         get(city_name) %>%  
           filter(room_type == "Private room"))
  
  # Print a message to indicate completion
  cat("Filtered data for Private rooms in", city_name, "\n")
}

# Loop through the city names
for (city_name in city_names) {
  # Access the data frame for private rooms in the current city
  city_df <- get(paste(city_name, "_private_rooms", sep = ""))
  
  # Sort the data frame by the "price" column in ascending order
  sorted_df <- city_df %>% arrange(price)
  
  # Create data frame for the combined 100 cheapest and 100 most expensive listings
  combined_df <- bind_rows(
    head(sorted_df, 100),  
    tail(sorted_df, 100)   
  )
  
  # Assign the combined data frame a unique name for each city
  assign(paste(city_name, "_combined", sep = ""), combined_df)
  
  # Print a message to indicate completion
  cat("Sorted data by price and sliced top and bottom 100 listings in", city_name, "by price\n")
}

# Loop through the city names
for (city_name in city_names) {
  # Access the combined data frame for the current city
  combined_df <- get(paste(city_name, "_combined", sep = ""))
  
  # Add the 'is_expensive' column based on row number
  combined_df <- combined_df %>%
    mutate(is_expensive = ifelse(row_number() <= 100, 0, 1))
  
  # Assign the modified data frame back to its original name
  assign(paste(city_name, "_combined", sep = ""), combined_df)
  
  # Print a message to indicate completion
  cat("Created 'is_expensive' variable in", city_name, "combined data frame\n")
  
  # Save cleaned data
  write_csv(combined_df, file = paste("summary_data/", city_name, "_summary.csv", sep = ""))
  
  # Print a message to indicate completion
  cat("Created summary CSV file for", city_name, "and saved as", paste("summary_data/", city_name, "_summary.csv", sep = ""), "\n")
}
