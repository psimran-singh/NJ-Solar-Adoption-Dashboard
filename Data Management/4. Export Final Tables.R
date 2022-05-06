### Set Working Directory to Export Tables To ###
setwd("~/GitHub/Data-Visualization-Final-Project/Data Files for Analysis")

#Residential Solar and Census Data Table for Zip Code Level Statistical Analysis
write.csv(Solar_Res_Zip,"Residential_Solar_ZIP.csv")

#Overall Solar TPO Data by County
#Residential Trend lines
write.csv(income_trendline, "Trendline For Income.csv")
write.csv(own_trendline, "Trendline For House Ownership.csv")
write.csv(val_trendline, "Trendline For Housing Value.csv")
write.csv(white_trendline, "Trendline For White Population.csv")

#Residential Solar TPO Data by County
write.csv(Solar_TPO_County,"Solar_TPO_County.csv")

#Saving as R object will preserve geometry, we will use these tables to map
#Residential Solar by County
save(Solar_Res_County, file = 'Solar_Res_County.Rda')

#Overall Solar by County
#We use capacities directly from report
Solar_All_County <- read_csv("County_Totals.csv") %>% filter(County != "Overall")
Solar_All_County$geometry <- Solar_Res_County$geometry[
  match(Solar_All_County$County,Solar_Res_County$COUNTY)]
save(Solar_All_County, file = 'Solar_All_County.Rda')

remove(Solar_All_County,Solar_Res_County,Solar_Res_Zip, Solar_TPO_County, Solar_TPO_Zip, income_trendline, own_trendline, val_trendline, white_trendline)






