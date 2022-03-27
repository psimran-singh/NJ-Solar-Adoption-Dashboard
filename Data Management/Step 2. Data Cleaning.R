### STEP 2: CLEANING DATASET ###

#Run Step 1 first in order to get correct data tables

#Load necessary libraries
library(tidyverse)
library(DataExplorer)

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

