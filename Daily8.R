# Name: Libby Prince
# Date: [Feb 24 2025]
# Purpose: Create a faceted plot of cumulative COVID-19 cases and deaths by USA region.

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

covid <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')

df <- data.frame(region = state.region,
                 abbr = state.abb,
                 state = state.name) 

inner_join(df, covid, by = "state") %>%
  group_by(region, date) %>%
  summarize(cases = sum(cases),
            deaths = sum(deaths)) %>%
  pivot_longer(cols = c(cases, deaths),
               names_to = "type",
               values_to = "count") %>%
  ggplot(aes(x = date, y = count)) +
  geom_line() +
  facet_grid(type ~ region, scales = "free_y") +
  theme_bw()

