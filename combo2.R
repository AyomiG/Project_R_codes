# Load the Excel file
library(dplyr)
library(raster)
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
data
# Extract specific columns by name
selected_columns <- data[, c("Group","Orig_Name","TypoCH2","VALPAR_SDM","has_VALPAR_SDM")]

# Write the extracted columns to a new Excel file
write.csv(selected_columns, "selected_columns.csv")
data1=read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\selected_columns.csv")
# data2 <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\comb1.csv")
# merged_data <- bind_cols(data1, data2)


 filtered_data <- data1 %>% filter( has_VALPAR_SDM==1)
 filtered_data2= filtered_data%>% filter( TypoCH2=="1.1.1")

 
 bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4]) 
uni_bins <- uni_bins[which(uni_bins$hab != ""),]

combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")

