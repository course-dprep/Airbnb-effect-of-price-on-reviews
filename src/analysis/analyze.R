#analysis
library(readr)
cleaned_data_final<-read_csv("../../gen/data-preparation/temp/cleaned_data_final.csv")

library(dplyr)
# Summary for the Cheapest Rooms
summary_reviews <- cleaned_data_final %>%
  group_by(is_cheap_expensive) %>%
  summarise(
    Average_Reviews_Yearly = mean(number_of_reviews_ltm, na.rm = TRUE)
  )


# Load the ggplot2 library if not already loaded
library(ggplot2)

# Define a custom color palette for every two city codes
city_colors <- c("AMS_cheap" = "skyblue","AMS_expensive" = "skyblue", "BER_cheap" = "salmon","BER_expensive" = "salmon", "BRU_cheap" = "lightgreen",
                 "BRU_expensive" = "lightgreen","LON_cheap" = "coral", "LON_expensive" = "coral","PAR_cheap" = "lightblue","PAR_expensive" = "lightblue")

# Create a bar chart for Average Reviews Yearly with custom colors
bar_chart <- ggplot(summary_reviews, aes(x = is_cheap_expensive, y = Average_Reviews_Yearly, fill = is_cheap_expensive)) +
  geom_bar(stat = "identity", position = position_dodge(width = 14)) +
  labs(title = "Average Reviews Yearly by City",
       x = "City Code",
       y = "Average Reviews Yearly") +
  scale_fill_manual(values = city_colors) +  # Assign custom colors
  theme_minimal()

# Print the bar chart
print(bar_chart)

dir.create('../../gen/analysis/output')

# Define the file path where you want to save the PNG
output_directory <- "../../gen/analysis/output"
output_file <- file.path(output_directory, "bar_chart.png")

# Save the bar chart as a PNG file
ggsave(output_file, plot = bar_chart, width = 14, height = 6, units = "in")



