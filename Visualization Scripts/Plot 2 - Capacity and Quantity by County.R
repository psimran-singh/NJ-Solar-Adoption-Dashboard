library(tidyverse)
library(plotly)

input <- data.frame("County")
colnames(input) <- "County"
input$County = "Middlesex"

county_level_sectors0 <- county_level_sectors %>% filter(County != "Overall") %>%
    mutate(selected = ifelse(County == input$County, TRUE, FALSE))
  
  colors <- county_level_sectors0 %>% select(County,selected) %>% 
    mutate(res_color = ifelse(selected == TRUE, "#6367CE", "#9FA3F2")) %>%
    mutate(nonres_color = ifelse(selected == TRUE, "#F1A73E", "#F7C57D")) %>%
    mutate(gs_color = ifelse(selected == TRUE, "#4DBA37", "#89EA76"))

  fig <- plot_ly(county_level_sectors0, 
                 x = county_level_sectors0$`County`, 
                 y = county_level_sectors0$`cap_res`,
                 type = "bar", 
                 name = "Residential",
                 marker = list(color = colors$res_color))  %>%
    add_trace(y = county_level_sectors0$`cap_nonres`,
              name = 'Non-Residential',
              marker = list(color = colors$nonres_color))  %>%
    add_trace(y = county_level_sectors0$`cap_gs`,
              name = 'Grid Supply',
              marker = list(color = colors$gs_color))  %>%
    layout(yaxis = list(title = "Capacity (MW)"), 
           xaxis = list(title = "Year",
                        tickangle = -45,
                        tickmode = 'linear', 
                        categoryorder = "total descending"),
           hovermode='x',
           barmode = "stack")
  fig
  