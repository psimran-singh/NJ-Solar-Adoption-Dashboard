library(tidycensus)
library(tidyverse)
library(sf)
library(viridis)
library(units)
library(RColorBrewer)
library(leaflet)
library(esquisse)

income_capacity <- ggplot(Solar_Res_Zip) +
  aes(x = Income, y = CAPACITY, size = CAPACITY) +
  geom_point(shape = "circle", colour = "#440154") +
  geom_smooth(span = 1L) +
  labs(
    y = "Solar Capacity",
    title = "Relationship between Income and Capacity",
    subtitle = "Using zip code level data"
  ) +
  theme_light()

income_capacity



Solar_Res_Zip <- drop_na(Solar_Res_Zip)
esquisse::esquisser(Solar_Res_Zip, viewer = "browser")







