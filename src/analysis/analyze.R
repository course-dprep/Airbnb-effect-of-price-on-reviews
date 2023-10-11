# Create an empty list to store the summary data for each city
summary_list <- list()

# Loop through the city names
for (city_name in city_names) {
  # Access the combined data frame for the current city
  combined_df <- get(paste(city_name, "_combined", sep = ""))
  
  # Add the 'is_expensive' column based on row number
  combined_df <- combined_df %>%
    mutate(is_expensive = ifelse(row_number() <= 100, 0, 1))
  
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

