### STEP 0: DOWNLOAD DATA AND PLACE PROPERLY IN A LOCAL DIRECTORY
#MODIV Property List is available from NJGIN Open Data website as ArcGIS .gdb file
    #At this URL: https://www.arcgis.com/home/item.html?id=1029bf3c6da4ca3b9b31f831a1e9f72
#Zip Code GIS Polygons are available from NJGIN Open Data
    #At this URL: https://www.arcgis.com/home/item.html?id=8d2012a2016e484dafaac0451f9aea24
    #This file is a .lpk file which can be unpacked with 7zip
    #7zip is free software and available here: https://www.7-zip.org/download.html
    #Unpack the .lpk file using 7zip, use version 10.7 (titled "v107")
    #Place the .gdb folder called "zip_poly.gdb" into same folder as MODIV .gdb file
#NOTE: These are large files and are not included in github repository
#Place them in a local folder of your choosing then run this script

##NOTE: These are large files, and take a while to import and edit, be prepared!
##My computer took >20 minutes to run this script
##Just use the resulting files, they are included in the github repository if you need to save time
##This geoprocessing script is just to properly code the property zip codes for the parcel data
##The original issue is that MODIV parcel data uses owner zip code, which is often different then property zip code


### STEP 1: IMPORTING DATA AND CREATING A BASE DATASET ###

#Load necessary libraries
library(tidyverse)
library(sf)

#Set Working Directory to wherever MODIV .csv file is
#Change to appropriate location if running on your own
setwd("~/Rutgers Spring 2022/Data Viz/Final Project")

#Import the datasets
#MODIV Tax Parcel Data will be used to determine how many parcels are residential
MODIV_Data <- st_read("~/Rutgers Spring 2022/Data Viz/Final Project/Statewide_Parcels_MODIV.gdb",
                      layer="Cad_parcel_mod4")
Zip_Shapes <- st_read("~/Rutgers Spring 2022/Data Viz/Final Project/zip_poly.gdb",
                      layer="zip_poly")

### STEP 2: LIMIT TO RESIDENTIAL AND REMOVE COLUMNS WE DON'T NEED ###
#We will keep only relevant variables, so just the shape, county, and prop_class for now.
#We will also filter by PROP_CLASS in order to limit our dataset to residential properties
MODIV_Data <- MODIV_Data %>% filter(PROP_CLASS==2) %>% 
  select("PROP_CLASS","COUNTY","SHAPE_Length","SHAPE_Area","SHAPE")

### STEP 5: ADD ZIP CODES BY SPATIAL JOIN ###
#First let's makes sure the coordinate reference systems are the same between the two datasets
MODIV_Data <- MODIV_Data %>% st_transform(4326)
Zip_Shapes <- Zip_Shapes %>% st_transform(4326)

#Now, join the two spatially join the two datasets with largest overlay as true
#sf::sf_use_s2(FALSE)
MODIV_Data_Zip <- st_join(MODIV_Data,Zip_Shapes,join=st_intersects,largest=TRUE)

### STEP 4: AGGREGATE TO COUNTY, ZIP CODE LEVELS ###
MODIV_County <- MODIV_Data %>% group_by(COUNTY) %>% summarise(COUNT=length(PROP_CLASS))
MODIV_ZIP <- MODIV_Data %>% group_by(ZIP) %>% summarise(COUNT=length(PROP_CLASS))
