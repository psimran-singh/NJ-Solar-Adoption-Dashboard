library(tidyverse)
library(sf)
library(RColorBrewer)
library(leaflet)


# Load Data

setwd("~/GitHub/Data-Visualization-Final-Project/Data Files for Analysis")
load("Solar_All_County.Rda")
load("Solar_Res_County.Rda")

Solar_All_County <- st_as_sf(Solar_All_County)
Solar_Res_County <- st_as_sf(Solar_Res_County)


pal <- colorBin(palette = "Reds", domain = Solar_All_County$capacity_mw) # split colors from white to red into 9 even bins

leaflet() %>%
  addPolygons(data = Solar_All_County,
              label = ~County, # when you hover over the polygon, it will label the svi
              color = "gray", # the color of the border
              fillColor = ~pal(Solar_All_County$capacity_mw), # the colors inside the polygons
              weight = 1.0, # the thickness of the border lines
              opacity = 1.0, # the transparency of the border lines
              fillOpacity = 0.8) %>%
  addLegend(data = Solar_All_County, # the dataset
            "bottomright", # where to put the legend
            pal = pal, values = ~capacity_mw, # specify the color palette and the range of values 
            title = "Capacity (MW)", # legend title
            opacity = 1.0) # the transparency of the legend


# Tab 2 map of residential capacity by county
pal2 <- colorBin(palette = "Reds", domain = res_county_data$CAPACITY) # split colors from white to red into 9 even bins

leaflet() %>%
  addPolygons(data = res_county_data,
              label = ~COUNTY, # when you hover over the polygon, it will label the svi
              color = "gray", # the color of the border
              fillColor = ~pal2(res_county_data$CAPACITY), # the colors inside the polygons
              weight = 1.0, # the thickness of the border lines
              opacity = 1.0, # the transparency of the border lines
              fillOpacity = 0.8) %>%
  addLegend(data = res_county_data, # the dataset
            "bottomright", # where to put the legend
            pal = pal2, values = ~CAPACITY, # specify the color palette and the range of values 
            title = "Capacity", # legend title
            opacity = 1.0) # the transparency of the legend


# Tab 2 map of residential adoption rate by county
pal3 <- colorBin(palette = "Blues", domain = res_county_data$Adoption_Rate) # split colors from white to red into 9 even bins

leaflet() %>%
  addPolygons(data = res_county_data,
              label = ~COUNTY, # when you hover over the polygon, it will label the svi
              color = "gray", # the color of the border
              fillColor = ~pal3(res_county_data$Adoption_Rate), # the colors inside the polygons
              weight = 1.0, # the thickness of the border lines
              opacity = 1.0, # the transparency of the border lines
              fillOpacity = 0.8) %>%
  addLegend(data = res_county_data, # the dataset
            "bottomright", # where to put the legend
            pal = pal3, values = ~Adoption_Rate, # specify the color palette and the range of values 
            title="Adoption Rates", # legend title
            opacity = 1.0) # the transparency of the legend


