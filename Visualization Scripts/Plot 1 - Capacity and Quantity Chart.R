# This plot is a trend for total capacity 
# across residential, non-residential, and grid supply
# We will show capacity and quantity both

library(plotly)
library(tidyverse)

setwd("~/GitHub/Data-Visualization-Final-Project/Data Files for Analysis")
capacity <- read_csv("Capacity Trend (MW).csv") 
quantity <- read_csv("Quantity Trend.csv")

colnames(capacity) <- c("Year",
                        "Residential Capacity",
                        "Non-Residential Capacity",
                        "Grid Supply Capacity",
                        "Residential Capacity (Cumulative)",
                        "Non-Residential Capacity (Cumulative)",
                        "Grid Supply Capacity (Cumulative)")
colnames(quantity) <- c("Year",
                        "Residential Quantity",
                        "Non-Residential Quantity",
                        "Grid Supply Quantity",
                        "Residential Quantity (Cumulative)",
                        "Non-Residential Quantity (Cumulative)",
                        "Grid Supply Quantity (Cumulative)")

data <- cbind(capacity, quantity[c(2:7)])
write_csv(data, file="Trend.csv")

fig <- plot_ly(data, x = ~Year, y = ~`Residential Capacity (Cumulative)`,
               type = 'bar', name = 'Residential') %>% 
  add_trace(y = ~`Non-Residential Capacity (Cumulative)`, name = 'Non-Residential') %>%
  add_trace(y = ~`Grid Supply Capacity (Cumulative)`, name = 'Grid Supply') %>%
  layout(yaxis = list(title = "Capacity (MW)"), 
         xaxis = list(title = "Year", tickangle = -45, tickmode = 'linear'),
         barmode='stack')
fig