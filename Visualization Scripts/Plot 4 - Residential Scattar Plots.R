library(tidyverse)
library(plotly)


fig_income <- plot_ly(df, x = df$`Income`, y = df$`Adoption_Rate`, type = "scatter") %>% 
  layout(yaxis = list(title = "Solar Adoption Rate"),
         xaxis = list(title = "Income"))

fig_perc_male <- plot_ly(df, x = df$`Perc_Male`, y = df$`Adoption_Rate`, type = "scatter") %>% 
  layout(yaxis = list(title = "Solar Adoption Rate"),
         xaxis = list(title = "Perc Male"))

fig_perc_white <- plot_ly(df, x = df$`Perc_White`, y = df$`Adoption_Rate`, type = "scatter") %>% 
  layout(yaxis = list(title = "Solar Adoption Rate"),
         xaxis = list(title = "Perc White"))

fig_perc_house_owned <- plot_ly(df, x = df$`Perc_House_Owned`, y = df$`Adoption_Rate`, type = "scatter") %>% 
  layout(yaxis = list(title = "Solar Adoption Rate"),
         xaxis = list(title = "Perc House Owned"))







