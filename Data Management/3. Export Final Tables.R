### Set Working Directory to Export Tables To ###
setwd("~/GitHub/Data-Visualization-Final-Project/Data Files for Analysis")

#Residential Solar and Census Data Table for Zip Code Level Statistical Analysis
write.csv(Solar_Res_Zip,"Residential_Solar_ZIP.csv")

#Overall Solar TPO Data by County
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

remove(Solar_All_County,Solar_Res_County,Solar_Res_Zip,zip_housing, Solar_TPO_County)






