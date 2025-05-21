
## data preparation on species and selected habitat bin
rm(list = ls(all = TRUE))
library(dplyr)
library(terra)
spec1 <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
                           pattern = "*.tif", full.names = TRUE)

bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4]) 
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
uni_bins$PH = as.numeric(uni_bins$PH)
uni_bins$Elevation = as.numeric(uni_bins$Elevation)
uni_bins = na.omit(uni_bins)
combo <- merge(spec1, uni_bins, by.x = "TypoCH2", by.y = "hab")
filtered_combo <- combo %>% filter( has_VALPAR_SDM==1)
filtered_combo$with_dot = gsub(" ","\\.",filtered_combo$VALPAR_SDM)
grep(filtered_combo$with_dot[1], raster_files, value = TRUE)

# Initialize an empty list to store matching files
matching_files_list <- vector("list", length = nrow(filtered_combo))

# Loop through each row of filtered_combo
for (i in 1:nrow(filtered_combo)) {
               value <- filtered_combo$with_dot[i]
               matching_files <- grep(value, raster_files, value = TRUE)
               matching_files_list[[i]] <- matching_files
}

filtered_combo$Matching_Files <- matching_files_list
# Merge the content of the three columns into one column
filtered_combo$Combined <- paste(filtered_combo$PH, "_",filtered_combo$Elevation, "_",
                                 filtered_combo$Humidity,sep = "")


 # write.csv(combo, file.path("C:\\Users\\ogundipe\\Documents\\data\\visua", "combo_.csv"))
# Filter rasters where 'typoCH2' is equal to '1_2_1'
selected_rasters <- rast(unlist(filtered_combo$Matching_Files[filtered_combo$Combined == "1_2_1"]))
sm = sum(selected_rasters)

# Save the raster to the specified file path
# output_path <- "C:\\Users\\ogundipe\\Documents\\data\\visua\\sm.tif"
# output_path2 <- "C:\\Users\\ogundipe\\Documents\\data\\visua\\selected_rasters.csv"
# writeRaster(sm, filename = output_path)
# write.csv(selected_rasters,file = output_path2 )
