# Set up
library(tidyverse)

# Load the combined data frame
df_framed <- read_csv("../../gen/data-preparation/temp/data_framed.csv")

df_framed<- df_framed%>% filter(room_type == "Private room")


filtered_df_cheap_AMS <- df_framed %>%
  filter(city_code == "AMS") %>%
  arrange(price) %>%
  head(100)%>%
  mutate(is_cheap_expensive ="AMS_cheap")

filtered_df_expensive_AMS <- df_framed %>%
  filter(city_code == "AMS") %>%
  arrange(price) %>%
  tail(100)%>%
  mutate(is_cheap_expensive ="AMS_expensive")

amsterdam_top_bottom_100<-bind_rows(filtered_df_cheap_AMS, filtered_df_expensive_AMS)

filtered_df_cheap_BRU <- df_framed %>%
  filter(city_code == "BRU") %>%
  arrange(price) %>%
  head(100)%>%
  mutate(is_cheap_expensive ="BRU_cheap")

filtered_df_expensive_BRU <- df_framed %>%
  filter(city_code == "BRU") %>%
  arrange(price) %>%
  tail(100)%>%
  mutate(is_cheap_expensive ="BRU_expensive")

brussels_top_bottom_100<-bind_rows(filtered_df_cheap_BRU, filtered_df_expensive_BRU)


filtered_df_cheap_BER <- df_framed %>%
  filter(city_code == "BER") %>%
  arrange(price) %>%
  head(100)%>%
  mutate(is_cheap_expensive ="BER_cheap")

filtered_df_expensive_BER <- df_framed %>%
  filter(city_code == "BER") %>%
  arrange(price) %>%
  tail(100)%>%
  mutate(is_cheap_expensive ="BER_expensive")

berlin_top_bottom_100<-bind_rows(filtered_df_cheap_BER, filtered_df_expensive_BER)


filtered_df_cheap_LON <- df_framed %>%
  filter(city_code == "LON") %>%
  arrange(price) %>%
  head(100)%>%
  mutate(is_cheap_expensive ="LON_cheap")

filtered_df_expensive_LON <- df_framed %>%
  filter(city_code == "LON") %>%
  arrange(price) %>%
  tail(100)%>%
  mutate(is_cheap_expensive ="LON_expensive")

london_top_bottom_100<-bind_rows(filtered_df_cheap_LON, filtered_df_expensive_LON)

filtered_df_cheap_PAR <- df_framed %>%
  filter(city_code == "PAR") %>%
  arrange(price) %>%
  head(100)%>%
  mutate(is_cheap_expensive ="PAR_cheap")

filtered_df_expensive_PAR <- df_framed %>%
  filter(city_code == "PAR") %>%
  arrange(price) %>%
  tail(100)%>%
  mutate(is_cheap_expensive ="PAR_expensive")

paris_top_bottom_100<-bind_rows(filtered_df_cheap_PAR, filtered_df_expensive_PAR)

cleaned_data_final<- bind_rows(amsterdam_top_bottom_100, brussels_top_bottom_100, berlin_top_bottom_100, london_top_bottom_100, paris_top_bottom_100)

write.csv(cleaned_data_final, file = "../../gen/data-preparation/temp/cleaned_data_final.csv", fileEncoding = "UTF-8",row.names=FALSE )
