#install packages
install.packages("ggplot2", repos = "https://cran.r-project.org")
library(readr)
library(dplyr)
library(ggplot2)

#load data
cleaned_data_final<-read_csv("../../gen/data-preparation/output/cleaned_data_final.csv")


# Summary for the Cheapest Rooms to compute average reviews
summary_reviews <- cleaned_data_final %>%
  group_by(is_cheap_expensive) %>%
  summarise(
    Average_Reviews_Yearly = mean(number_of_reviews_ltm, na.rm = TRUE)
  )

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

#create output directories to save data
dir.create('../../gen/analysis/output')
dir.create('../../gen/paper')
dir.create('../../gen/paper/output')

# Define the file path where you want to save the PNG
output_directory <- "../../gen/analysis/output"
output_file <- file.path(output_directory, "bar_chart.png")

# Save the output as a PNG file
ggsave(output_file, plot = bar_chart, width = 14, height = 6, units = "in")



