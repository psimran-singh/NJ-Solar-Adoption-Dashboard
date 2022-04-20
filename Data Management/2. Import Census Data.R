# libraries
library(tidyverse)
library(tidycensus)

# set up census 
# census_api_key("", install = TRUE)

# county code dictionary
county_dict <- c("1" = "Sussex","2"	= "Warren","3" = "Morris","4" = "Hunterdon","5" = "Somerset","6" = "Passaic","7" = "Bergen","8" = "Hudson","9" = "Essex","10" = "Union","11" = "Middlesex","12" = "Mercer","13" = "Burlington","14" = "Camden","15" = "Gloucester","16" = "Salem","17" = "Monmouth","18" = "Ocean","19" = "Atlantic","20" = "Cumberland","21" = "Cape May")

# get county data from ACS
county_income <- get_acs(variables = "DP03_0051E", geography = "county", state = "NJ", survey = "acs5", year = 2019, geometry = TRUE)
county_perc_male <- get_acs(variables = "DP05_0002PE", geography = "county", state = "NJ", survey = "acs5", year = 2019)
county_perc_white <- get_acs(variables = "DP05_0037PE", geography = "county", state = "NJ", survey = "acs5", year = 2019)
county_total_house <- get_acs(variables = "DP04_0002E", geography = "county", state = "NJ", survey = "acs5", year = 2019)

# add county code to county datasets
county_dict <- county_dict[order(unlist(county_dict), decreasing=FALSE)] # sort dict by county name
county_income <- county_income[order(county_income$NAME),]
county_income["COUNTY_CODE"] = as.integer(names(county_dict))
county_perc_male["COUNTY_CODE"] = as.integer(names(county_dict))
county_perc_white["COUNTY_CODE"] = as.integer(names(county_dict))
county_total_house["COUNTY_CODE"] = as.integer(names(county_dict))
Solar_Res_County["COUNTY_CODE"] = as.integer(names(county_dict))

# get zip data from ACS
zip_income <- get_acs(variables = "DP03_0051E", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)
zip_perc_male <- get_acs(variables = "DP05_0002PE", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)
zip_perc_white <- get_acs(variables = "DP05_0037PE", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)
zip_total_house <- get_acs(variables = "DP04_0002E", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)
zip_owner_house <- get_acs(variables = "DP04_0046E", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)
zip_renter_house <- get_acs(variables = "DP04_0047E", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)

# combine the county demographics with solar data
Solar_Res_County$geometry <- county_income$geometry[match(Solar_Res_County$COUNTY_CODE, county_income$COUNTY_CODE)]
Solar_Res_County$Income <- county_income$estimate[match(Solar_Res_County$COUNTY_CODE,county_income$COUNTY_CODE)]
Solar_Res_County$Perc_White <- county_perc_white$estimate[match(Solar_Res_County$COUNTY_CODE,county_perc_white$COUNTY_CODE)]
Solar_Res_County$Perc_Male <- county_perc_male$estimate[match(Solar_Res_County$COUNTY_CODE,county_perc_male$COUNTY_CODE)]
Solar_Res_County$Total_Occ_House <- county_total_house$estimate[match(Solar_Res_County$COUNTY_CODE,county_total_house$COUNTY_CODE)]
Solar_Res_County$Adoption_Rate <- Solar_Res_County$COUNT/Solar_Res_County$Total_Occ_House

# combine the zip demographics with solar data
Solar_Res_Zip$Income <- zip_income$estimate[match(Solar_Res_Zip$ZIP,zip_income$GEOID)]
Solar_Res_Zip$Perc_White <- zip_perc_white$estimate[match(Solar_Res_Zip$ZIP,zip_perc_white$GEOID)]
Solar_Res_Zip$Perc_Male <- zip_perc_male$estimate[match(Solar_Res_Zip$ZIP,zip_perc_male$GEOID)]
Solar_Res_Zip$Total_Occ_House <- zip_total_house$estimate[match(Solar_Res_Zip$ZIP,zip_total_house$GEOID)]
Solar_Res_Zip$Adoption_Rate <- Solar_Res_Zip$COUNT/Solar_Res_Zip$Total_Occ_House

# combine zip housing data
zip_total_house$Owner_Occ_Houses <- zip_owner_house$estimate[match(zip_total_house$GEOID,zip_owner_house$GEOID)]
zip_total_house$Renter_Occ_Houses <- zip_renter_house$estimate[match(zip_total_house$GEOID,zip_renter_house$GEOID)]
zip_housing <- zip_total_house %>%
  rename(Total_Occ_Houses = estimate, ZIP = GEOID) %>%
  subset(select = -c(NAME, variable, moe))

# remove census datasets from global environment
remove(zip_income, zip_perc_male, zip_perc_white, zip_total_house, zip_owner_house, zip_renter_house, county_dict, county_income, county_perc_male, county_perc_white, county_total_house)

# final datasets
setwd("~/GitHub/Data-Visualization-Final-Project/Data Files for Analysis")

#Residential Solar + Census Data Table for Zip Code Level Statistical Analysis
write.csv(Solar_Res_Zip,"Residential_Solar_ZIP.csv")

#Saving as R object will preserve geometry
#Residential Solar by County
save(Solar_Res_County, file = 'Residential_Solar_County.Rda')

#Overall Solar by County
Solar_All_County$geometry <- Solar_Res_County$geometry[match(Solar_All_County$COUNTY,Solar_Res_County$COUNTY)]
save(Solar_All_County, file = 'Overall_Solar_County.Rda')







