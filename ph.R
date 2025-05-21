data1 <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
data2=read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\selected_columns.csv")
spec1 <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
 bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
# View(bins)
# bins <- bins[,1:5] 
# head(bins)
# bins <- na.omit(bins[,1:5])
# uni_bins1<- unique(bins[,1:4]) 
# head(uni_bins)
# bins2 <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
# uni_bins<- unique(bins[,1:4]) 
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4]) 
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
uni_bins$PH = as.numeric(uni_bins$PH)
uni_bins$Elevation = as.numeric(uni_bins$Elevation)
uni_bins = na.omit(uni_bins)

head(uni_bins)
dim(uni_bins)
combo <- merge(spec1, uni_bins, by.x = "TypoCH2", by.y = "hab")
# View(combo)
## combo files
library(dplyr)
filtered_combo <- combo %>% filter( has_VALPAR_SDM==1)
filtered_combo$with_dot = gsub(" ","\\.",filtered_combo$VALPAR_SDM)
grep(filtered_combo$with_dot[1], raster_files, value = TRUE)
#Initialize an empty vector to store the matching files
# matching_files_vector <- character(length = nrow(filtered_combo))
# 
# # Loop through each row in filtered_data
# for (i in 1:nrow(filtered_combo)) {
#                value <- filtered_combo$with_dot[i] 
#                matching_files <- grep(value, raster_files, value = TRUE) 
#                matching_files_vector[i] <- paste(matching_files, collapse = ', ')  
# }
# filtered_combo$Matching_Files <- matching_files_vector


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




# # Find indices of cells in "Combined_Column" that don't have up to 3 digits at the beginning
# indices <- grep("^[0-9]{1,3}\\.", filtered_combo$Combined)
# result <- grepl("^[^0-9]", filtered_combo$Combined)
# 
# # Subset the dataframe based on the condition
# filtered_df <- filtered_combo[result, ]
# 
# # View the filtered dataframe
# print(filtered_df)

# write.csv(combo, file.path("C:\\Users\\ogundipe\\Documents\\data\\visua", "combo_.csv"))

# uni_bins<- unique(bins[,1:4])

# tst = rast(unlist(filtered_combo$Matching_Files[1:5]))
# Assuming you have a dataframe called 'filtered_combo'
# Filter rasters where 'typo' is equal to '2.1.1'
library(terra)
selected_rasters <- rast(unlist(filtered_combo$Matching_Files[filtered_combo$Combined == "1_2_1"]))
sm = sum(selected_rasters)


# Load the dplyr package if not already loaded
# install.packages("dplyr")
# library(dplyr)
# 
# # Group the data by the patterns in the Matching_Files column
# grouped_data <- filtered_combo %>%
#                group_by(Matching_Files) %>%
#                summarize(Total_Sum = sum(rast(Matching_Files)))
# 
# # View the grouped data
# print(grouped_data)
# 
# 
# 
# 
# 
# 
# # Load the raster package if not already loaded
# # install.packages("raster")
# library(terra)
# 
# # Create an empty list to store the sums
# sums_list <- list()
# 
# # Loop through unique combo values
# unique_combos <- unique(filtered_combo$Combined)
# for (combo_value in unique_combos) {
#                # Subset the dataframe for the current combo
#                subset_df <- filtered_combo[filtered_combo$Combined == combo_value, ]
# 
#                # Initialize the sum
#                total_sum <- rast()
# 
#                # Loop through Matching_Files in the subset and sum the rasters
#                for (matching_file in subset_df$Matching_Files) {
#                               total_sum <- total_sum + rast(matching_file)
#                }
# 
#                # Store the sum in the list
#                sums_list[[combo_value]] <- total_sum
#                
#                plot(total_sum, main = combo_value)
# }
# # Plot the summed raster
# 
# 
# # Now you can access sums_list to get the sum for each unique combo
# 
# 
