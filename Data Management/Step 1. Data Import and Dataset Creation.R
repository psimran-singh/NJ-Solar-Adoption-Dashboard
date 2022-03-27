### STEP 1: IMPORTING DATA AND CREATING A BASE DATASET ###

#Load necessary libraries
library(tidyverse)

#Set Working Directory to Github folder
#Change to appropriate location if running on your own
setwd("~/GitHub/Data-Visualization-Final-Project")

#Import the datasets, one for each program
#Sourced from December'21 Monthly NJBPU Solar Registration Database
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
