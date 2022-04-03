# libraries
library(tidyverse)
library(tidycensus)

remove(census)
remove(county_gender)

# set up census
census_api_key("", install = TRUE)

# data
setwd("~/Data Viz in R/Data-Visualization-Final-Project-main/Data Management")
solar_data = read_csv("Solar Data v1.csv")

# county code dictionary
county_dict <- c("1" = "Sussex","2"	= "Warren","3" = "Morris","4" = "Hunterdon","5" = "Somerset","6" = "Passaic","7" = "Bergen","8" = "Hudson","9" = "Essex","10" = "Union","11" = "Middlesex","12" = "Mercer","13" = "Burlington","14" = "Camden","15" = "Gloucester","16" = "Salem","17" = "Monmouth","18" = "Ocean","19" = "Atlantic","20" = "Cumberland","21" = "Cape May")

# get county data from ACS
county_income <- get_acs(variables = "DP03_0051E", geography = "county", state = "NJ", survey = "acs5", year = 2019)
county_perc_male <- get_acs(variables = "DP05_0002PE", geography = "county", state = "NJ", survey = "acs5", year = 2019)
county_perc_white <- get_acs(variables = "DP05_0037PE", geography = "county", state = "NJ", survey = "acs5", year = 2019)

# add county code to county datasets
county_dict <- county_dict[order(unlist(county_dict), decreasing=FALSE)] # sort dict by county name
county_income["COUNTY_CODE"] = as.integer(names(county_dict))
county_perc_male["COUNTY_CODE"] = as.integer(names(county_dict))
county_perc_white["COUNTY_CODE"] = as.integer(names(county_dict))

# get zip data from ACS
zip_income <- get_acs(variables = "DP03_0051E", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)
zip_perc_male <- get_acs(variables = "DP05_0002PE", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)
zip_perc_white <- get_acs(variables = "DP05_0037PE", geography = "zip code tabulation area", state = "NJ", survey = "acs5", year = 2019)

# combine the county demographics with solar data
solar_data$County_Income <- county_income$estimate[match(solar_data$COUNTY_CODE,county_income$COUNTY_CODE)]
solar_data$County_Perc_White <- county_perc_white$estimate[match(solar_data$COUNTY_CODE,county_perc_white$COUNTY_CODE)]
solar_data$County_Perc_Male <- county_perc_male$estimate[match(solar_data$COUNTY_CODE,county_perc_male$COUNTY_CODE)]

#combine the zip demographics with solar data
solar_data$Zip_Income <- zip_income$estimate[match(solar_data$ZIP,zip_income$GEOID)]
solar_data$Zip_Perc_White <- zip_perc_white$estimate[match(solar_data$ZIP,zip_perc_white$GEOID)]
solar_data$Zip_Perc_Male <- zip_perc_male$estimate[match(solar_data$ZIP,zip_perc_male$GEOID)]

# final datasets
solar_data_zip <- subset(solar_data, select = -c(County_Income, County_Perc_White, County_Perc_Male))
write.csv(solar_data_zip,"Solar Data ZIP.csv", row.names = TRUE)

solar_data_county <- subset(solar_data, select = -c(Zip_Income, Zip_Perc_White, Zip_Perc_Male))
write.csv(solar_data_county,"Solar Data COUNTY.csv", row.names = TRUE)







