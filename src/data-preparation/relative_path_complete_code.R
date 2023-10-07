```{r}
## installing all necessary packages
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

# Now, you should have separate data frames named amsterdam, berlin, brussels, london, and paris.

#code for private rooms segmentation
city_names <- names(city_year)

# Loop through the city names and filter the corresponding data frames
for (city_name in city_names) {
  # Filter the data frame for "Private room" listings
  assign(paste(city_name, "_private_rooms", sep = ""), 
         get(city_name) %>%  # Access the original data frame by name
           filter(room_type == "Private room"))
  
  # Print a message to indicate completion
  cat("Filtered data for Private rooms in", city_name, "\n")
}

#slice the top and bottom 100 listings by price for each city

# Loop through the city names
for (city_name in city_names) {
  # Access the data frame for private rooms in the current city
  city_df <- get(paste(city_name, "_private_rooms", sep = ""))
  
  # Sort the data frame by the "price" column in ascending order
  sorted_df <- city_df %>% arrange(price)
  
  # Create data frame for the combined 100 cheapest and 100 most expensive listings
  combined_df <- bind_rows(
    head(sorted_df, 100),  # Top 100 most expensive listings
    tail(sorted_df, 100)   # Bottom 100 cheapest listings
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
}

# Create an empty list to store the summary data for each city
summary_list <- list()

# Loop through the city names
for (city_name in city_names) {
  # Access the combined data frame for the current city
  combined_df <- get(paste(city_name, "_combined", sep = ""))
  
  # Calculate the average reviews per is_expensive variable
  summary_data <- combined_df %>%
    group_by(is_expensive) %>%
    summarise(
      Average_Reviews_yearly = mean(number_of_reviews_ltm, na.rm = TRUE)
    )
  
  # Store the summary data in the list
  summary_list[[city_name]] <- summary_data
  assign(paste(city_name, "_avg_reviews", sep = ""), summary_data)
  # Print the summary for the current city
  cat("Summary for", city_name, ":\n")
  print(summary_data)
}


# Load necessary libraries
library(ggplot2)
library(dplyr)

# Create a directory to store the plots
dir.create("barcharts")

# Loop through the city names
for (city_name in city_names) {
  # Access the summary data for the current city
  summary_data <- get(paste(city_name, "_avg_reviews", sep = ""))
  
  # Create a bar chart comparing 2022 vs. 2023 for the current city
  barchart <- ggplot(summary_data, aes(x = as.factor(is_expensive), y = Average_Reviews_yearly, fill = as.factor(is_expensive))) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = paste("Average Reviews Yearly Comparison in", city_name, "(2022 vs. 2023)"),
         x = "Is Expensive", y = "Average Reviews Yearly") +
    scale_fill_manual(values = c("0" = "blue", "1" = "red"), name = "Is Expensive") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability
  
  # Save the bar chart as a PNG file
  filename <- paste("barcharts/", city_name, "_barchart.png", sep = "")
  ggsave(filename, plot = barchart, width = 6, height = 4)
  
  # Print a message to indicate completion
  cat("Created bar chart for", city_name, "and saved as", filename, "\n")
}


 








```
