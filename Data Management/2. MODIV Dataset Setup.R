### STEP 0: DOWNLOAD DATA AND TURN IT INTO .csv
#MODIV Property List is available from NJGIN Open Data website as ArcGIS .gdb file
#At this URL: https://www.arcgis.com/home/item.html?id=102a9bf3c6da4ca3b9b31f831a1e9f72
#After downloading, open in ArcMap or other Esri software and export as .csv
#Now we can work with this .csv and get the data we need.

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
