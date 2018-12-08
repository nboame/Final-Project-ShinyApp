# Setting up beer data for tables
complete_data <- readRDS("beer_data_loc_all.rds")

# Code for examining how many beers there are of each style
complete_data %>% 
  group_by(UT_sub_style) %>%
  count() %>%
  arrange(desc(n))

# Code for examining how many beers there are of each style, by country
complete_data %>% 
  group_by(UT_sub_style, country) %>%
  count() %>%
  arrange(desc(n))