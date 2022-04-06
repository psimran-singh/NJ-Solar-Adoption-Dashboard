### STEP 0: DOWNLOAD DATA AND PREPARE FOR R IN ARCGIS
#MODIV Property List is available from NJGIN Open Data website as ArcGIS .gdb file
    #At this URL: https://www.arcgis.com/home/item.html?id=1029bf3c6da4ca3b9b31f831a1e9f72
#Zip Code GIS Polygons are available from NJGIN Open Data.
    #At this URL: https://www.arcgis.com/home/item.html?id=8d2012a2016e484dafaac0451f9aea24
#After downloading, open both sets of data in ArcGIS or other Esri software
#Merge the parcel data with the zip code data:
    #Spatial Join tool and use the "Largest Overlap" option for 'Match Option' in the tool.
#Now export the .csv out of ArcGIS, and now it is ready to import into R

### STEP 1: IMPORTING DATA AND CREATING A BASE DATASET ###

#Load necessary libraries
library(tidyverse)

#Set Working Directory to wherever MODIV .csv file is
#Change to appropriate location if running on your own
setwd("~/Rutgers Spring 2022/Data Viz/Final Project")

#Import the datasets, one for each program
#Sourced from December'21 Monthly NJBPU Solar Registration Database
MODIV_Data <- read.csv("~/Rutgers Spring 2022/Data Viz/Final Project/MODIV Database.csv")

### STEP 2: LIMIT TO RESIDENTIAL AND REMOVE COLUMNS WE DON'T NEED ###
#Since we will aggregate at zip code and county levels, we will keep those variables 
#We will also filter by PROP_CLASS in order to limit our dataset to residential properties
MODIV_Data_Res <- MODIV_Data %>% filter(PROP_CLASS==2)
  
MODIV_Data_Res <- MODIV_Data_Res %>% select(PROP_CLASS,COUNTY,CD_CODE)
names(MODIV_Data) <- c("PROP_CLASS","COUNTY","ZIP")

### STEP 3: AGGREGATE TO COUNTY, ZIP CODE LEVELS
MODIV_County <- MODIV_Data %>% group_by(COUNTY) %>% summarise(COUNT=length(PROP_CLASS))
MODIV_ZIP <- MODIV_Data %>% group_by(ZIP) %>% summarise(COUNT=length(PROP_CLASS))
