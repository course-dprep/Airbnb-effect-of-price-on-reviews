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


