
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
dir.create('../../gen')
dir.create('../../gen/data-preparation')
dir.create('../../gen/data-preparation/temp')
write.csv(all_data, file = "../../gen/data-preparation/temp/data_framed.csv", fileEncoding = "UTF-8",row.names=FALSE )

cat("Combined data saved as CSV:\n")
# Set up
library(tidyverse)

# Load the combined data frame
df_framed<-read_csv("data_framed.csv")
df_framed <- read_csv(file.path("gen" , "data-preparation", "temp", "data_framed.csv"))


df_framed<- df_framed%>% filter(room_type == "Private room")
filtered_df_cheap <- df_framed %>%
  group_by(city_code) %>%
  slice_min(order_by = price, n = 100)

filtered_df_expensive <- df_framed %>%
  group_by(city_code) %>%
  slice_max(order_by = price, n = 100)

cleaned_data_final <- bind_rows(filtered_df_cheap, filtered_df_expensive)
write.csv(cleaned_data_final, file = "../../gen/data-preparation/temp/data_framed.csv", fileEncoding = "UTF-8",row.names=FALSE )







#analysis







# Define the list of city names
city_names <- c("AMS", "BER", "BRU", "LON", "PAR")

# Create an empty list to store the summary data for each city
summary_list <- list()

# Loop through the city names
for (city_name in city_names) {
  # Filter the combined data frame for the current city
  city_df <- df_framed %>% filter(city == city_name)
  
  # Add the 'is_expensive' column based on row number
  city_df <- city_df %>%
    mutate(is_expensive = ifelse(row_number() <= 100, 0, 1))
  
  # Calculate the average reviews per is_expensive variable
  summary_data <- city_df %>%
    group_by(is_expensive) %>%
    summarise(
      Average_Reviews_yearly = mean(number_of_reviews_ltm, na.rm = TRUE)
    )
  
  # Store the summary data in the list
  summary_list[[city_name]] <- summary_data
  
  # Print the summary for the current city
  cat("Summary for", city_name, ":\n")
  print(summary_data)
}

# Create bar charts for each city comparing 2022 vs. 2023
for (city_name in city_names) {
  summary_data <- summary_list[[city_name]]
  
  ggplot(summary_data, aes(x = as.factor(is_expensive), y = Average_Reviews_yearly, fill = as.factor(is_expensive))) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = paste("Average Reviews Yearly Comparison in", city_name, "(2022 vs. 2023)"),
         x = "Is Expensive", y = "Average Reviews Yearly") +
    scale_fill_manual(values = c("0" = "blue", "1" = "red"), name = "Is Expensive") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability
  
  # Save the plot as an image file (e.g., PNG) in the relative directory
  ggsave(filename = file.path("data-preparation", "temp", paste(city_name, "_bar_chart.png", sep = "")), plot = last_plot(), width = 8, height = 6)
}
