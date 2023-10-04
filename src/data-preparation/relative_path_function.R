library(tidyverse)

# Define a function to process Airbnb data for cities
process_airbnb_data <- function(citys) {
  # Create an empty list to store the summary data for each city
  summary_list <- list()
  
  # Loop through the city names
  for (city_name in names(citys)) {
    url <- citys[[city_name]]
    
    # Read the CSV data from the URL and store it in a data frame with the city name
    assign(city_name, read.csv(url))
    
    # Print a message to indicate completion
    cat("Downloaded data for", city_name, "\n")
    
    # Access the combined data frame for the current city
    combined_df <- get(city_name)
    
    # Add the 'is_expensive' column based on row number
    combined_df <- combined_df %>%
      mutate(is_expensive = ifelse(row_number() <= 100, 0, 1))
    
    # Calculate the average reviews per is_expensive variable
    summary_data <- combined_df %>%
      group_by(is_expensive) %>%
      summarise(
        Average_Reviews = mean(number_of_reviews, na.rm = TRUE)
      )
    
    # Store the summary data in the list
    summary_list[[city_name]] <- summary_data
    
    # Print a message to indicate completion
    cat("Processed data for", city_name, "\n")
  }
  
  # Return the summary data
  return(summary_list)
}

# Define the list of city URLs
citys <- list(
  amsterdam = "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2023-09-03/visualisations/listings.csv",
  berlin = "http://data.insideairbnb.com/germany/be/berlin/2023-06-22/visualisations/listings.csv",
  brussels = "http://data.insideairbnb.com/belgium/bru/brussels/2023-06-24/visualisations/listings.csv",
  london = "http://data.insideairbnb.com/united-kingdom/england/london/2023-06-08/visualisations/listings.csv",
  paris = "http://data.insideairbnb.com/france/ile-de-france/paris/2023-06-06/visualisations/listings.csv"
)

# Call the function with the city URLs to process the data and get the summary
summary_data <- process_airbnb_data(citys)

# Print the summary for each city
for (city_name in names(summary_data)) {
  cat("Summary for", city_name, ":\n")
  print(summary_data[[city_name]])
}

