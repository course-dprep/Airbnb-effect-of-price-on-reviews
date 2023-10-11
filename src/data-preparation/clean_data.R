# Set up
library(tidyverse)

# Load the combined data frame
df_framed <- read_csv("../../gen/data-preparation/temp/data_framed.csv")

df_framed<- df_framed%>% filter(room_type == "Private room")
filtered_df_cheap <- df_framed %>%
  group_by(city_code) %>%
  slice_min(order_by = price, n = 100)

filtered_df_expensive <- df_framed %>%
  group_by(city_code) %>%
  slice_max(order_by = price, n = 100)

cleaned_data_final <- bind_rows(filtered_df_cheap, filtered_df_expensive)
write.csv(cleaned_data_final, file = "../../gen/data-preparation/temp/data_framed.csv", fileEncoding = "UTF-8",row.names=FALSE )
