### STEP 0. RUN PREVIOUS STEPS ###
#Make sure you've run step 1 and 2 of data management
#The tables we'll need:
  #Solar_Res_County
  #Solar_Res_ZIP
  #MODIV_County
  #MODIV_Zip

### STEP 1. JOIN DATASET AND CALCULATE RESIDENTIAL ADOPTION RATES

#Load necessary libraries
library(tidyverse)

#Join county tables
#Lets match the case between the datasets first
Solar_Res_County$COUNTY <- toupper(Solar_Res_County$COUNTY)
Solar_Rates_County <- left_join(Solar_Res_County,MODIV_County,by="COUNTY")

#Calculate county solar adoption rates
Solar_Rates_County <- Solar_Rates_County %>%
  rename(SOLAR_COUNT=COUNT.x,PARCEL_COUNT=COUNT.y) %>%
  mutate(ADOPTION_RATE=SOLAR_COUNT/PARCEL_COUNT)

#Join ZIP tables
Solar_Res_Zip <- Solar_Res_Zip %>% rename(ZIP_CODE=ZIP)
Solar_Rates_Zip <- left_join(Solar_Res_Zip,MODIV_ZIP,by="ZIP_CODE")

#Calculate county solar adoption rates
Solar_Rates_Zip <- Solar_Rates_Zip %>%
  rename(SOLAR_COUNT=COUNT.x,PARCEL_COUNT=COUNT.y) %>%
  mutate(ADOPTION_RATE=SOLAR_COUNT/PARCEL_COUNT)
