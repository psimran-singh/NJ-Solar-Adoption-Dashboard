# This plot is a trend for total capacity 
# across residential, non-residential, and grid supply
# We will show capacity and quantity both

library(plotly)
library(tidyverse)

setwd("~/GitHub/Data-Visualization-Final-Project/Data Files for Analysis")
capacity <- read_csv("Capacity Trend.csv")
quantity <- read_csv("Quantity Trend.csv")


fig <- plot_ly(capacity, x = ~Date, y = ~residential_cum, type = 'bar', name = 'Residential') %>% 
  add_trace(y = ~non_residential_cum, name = 'Non-Residential') %>%
  add_trace(y = ~grid_supply_cum, name = 'Grid Supply') %>%
  layout(yaxis = list(title = "Capacity (kW)"), 
         xaxis = list(title = "Year", tickangle = -45),
         barmode='stack')

fig
