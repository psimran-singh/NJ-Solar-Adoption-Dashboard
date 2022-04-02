### STEP 1: IMPORTING DATA AND CREATING A BASE DATASET ###

#Load necessary libraries
library(tidyverse)
library(DataExplorer)

#Set Working Directory to Github folder
#Change to appropriate location if running on your own
setwd("~/GitHub/Data-Visualization-Final-Project")

#Import the datasets, one for each program
#Sourced from December'21 Monthly NJBPU Solar Registration Database
#At this URL: https://njcleanenergy.com/renewable-energy/project-activity-reports/solar-activity-report-archive
SRP_Data <- read.csv("~/GitHub/Data-Visualization-Final-Project/Original Data Files/NJBPU_SRP_Data.csv",na.string=c(NA,""," "))
TI_Data <- read.csv("~/GitHub/Data-Visualization-Final-Project/Original Data Files/NJBPU_TI_Data.csv",na.string=c(NA,""," "))
ADI_Data <- read.csv("~/GitHub/Data-Visualization-Final-Project/Original Data Files/NJPU_ADI_Data.csv",na.string=c(NA,""," "))

#Data Cleaning: Getting correct columns to join all datasets
#We need some key variables which are in all 3 program data, we will remove the others
col_names <- c("PROGRAM","CITY","ZIP","COUNTY_CODE","INTERCONNECTION_DATE","SYSTEM_SIZE",
               "CUSTOMER_TYPE","INTERCONNECTION_TYPE","THIRD_PARTY_OWNERSHIP")

SRP_Data <- SRP_Data %>% select(Program, Premise.City, Premise.........................Zip, 
                    County......................Code, PTO.Date..Interconnection.Date.,
                    Calculated.Total.System.Size, Customer.Type, Interconnection,
                    Third.Party.Ownership)
names(SRP_Data) <- col_names

TI_Data <- TI_Data %>% select(Program, Premise.City, Premise.........................Zip, 
                              County......................Code, PTO.Date..Interconnection.Date.,
                              Calculated.Total.System.Size, Customer.Type, Interconnection,
                              Third.Party.Ownership)
names(TI_Data) <- col_names

ADI_Data <- ADI_Data %>% select(Program, Premise.City, Premise.........................Zip, 
                               County......................Code, PTO.Date..Interconnection.Date.,
                               Calculated.Total.System.Size, Customer.Type, Interconnection,
                               Third.Party.Ownership)
names(ADI_Data) <- col_names

#Join all the datasets to create one with all entries across all programs
#We will now perform some data cleaning on this dataset
Solar_Data0 <- rbind(SRP_Data,TI_Data,ADI_Data)

remove(SRP_Data)
remove(TI_Data)
remove(ADI_Data)
remove(col_names)

### STEP 2: CLEANING DATASET ###

#First, lets create a DataExplorer report to explore missing data
create_report(Solar_Data0)
#From the report we see that our dataset is very complete
#We have 20 observations with missing town and zip codes, we will leave these in
#They still have county codes so we may roll them up or remove later

#We will now try and match up duplicate city names
solar_mun <- unique(Solar_Data0$CITY)
#5,223 unique city names, when there are only 564 municipalities in NJ
#Maybe that's too much to clean up, and we should just use zip codes


#Reformat Zip Codes, since they're missing 0's: Not elegant but works
Solar_Data0$ZIP <- paste("0",Solar_Data0$ZIP,sep="")
Solar_Data0$ZIP[Solar_Data0$ZIP=="0NA"] <- NA


#Aggregate by Zip Code and County


