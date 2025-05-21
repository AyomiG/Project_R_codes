rm(list = ls(all = TRUE))
library(sf)
library(terra)
library(raster)
#read the PA_shapefile(shp)

shp = st_read("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\oei_betrieb.gpkg")
# transform to spatVector in Terra
tshp = terra::vect(shp)
# writeVector(tshp, filename = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA.shp")
# filter out all PAs with no area of very low area
spatvector_sub <- tshp[tshp$ha >= 0.0025, ]
spatvector_sub$ID = NULL
spatvector_sub$IDproper = 1:nrow(spatvector_sub)
# # writeVector(spatvector_sub, filename = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA_.shp")
raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_dv", pattern = "*.tif")
max_values_75th <- list()
min_values_75th <- list()
range_values_75th <- list()

for (raster_file in raster_files) {
               sm <- rast(paste0("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_dv/", raster_file))
               crs(sm) <- crs(spatvector_sub)
               suitability_score <- terra::extract(sm, spatvector_sub)
               
               # Calculate the 75th quantile
               quantile_75th <- quantile(suitability_score$sum, 0.75, na.rm = TRUE)
               
               # Subset the suitability scores based on the 75th quantile
               suitability_score_75th <- suitability_score[suitability_score$sum > quantile_75th, ]
               
               # Calculate the maximum value after subsetting
               max_value_75th <- max(suitability_score_75th$sum, na.rm = TRUE)
               max_values_75th[[basename(raster_file)]] <- max_value_75th
               
               # Calculate the minimum value after subsetting
               min_value_75th <- min(suitability_score_75th$sum, na.rm = TRUE)
               min_values_75th[[basename(raster_file)]] <- min_value_75th
               
               # Calculate the range after subsetting
               range_value_75th <- max_value_75th - min_value_75th
               range_values_75th[[basename(raster_file)]] <- range_value_75th
}




# Create data frames for minimum, maximum, and range values
min_df <- data.frame(file = names(min_values_75th), min_value = unlist(min_values_75th))
max_df <- data.frame(file = names(max_values_75th), max_value = unlist(max_values_75th))
range_df <- data.frame(file = names(range_values_75th), range_value = unlist(range_values_75th))

# Merge the data frames by file name
result_df <- merge(merge(min_df, max_df, by = "file"), range_df, by = "file")
# Save the result_df data frame as a CSV file
write.csv(result_df, "result_summary.csv", row.names = FALSE)




# Define the file path for the folder where you want to save the CSV file
folder_path <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/"

# Save the result_df data frame as a CSV file in the specified folder
write.csv(result_df, file.path(folder_path, "MinMax_summary.csv"), row.names = FALSE)


install.packages("rlang")
library("ggplot2")

# Read the CSV file
data <- read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/MinMax_summary.csv")

# Extract the column containing the maximum values
max_values <- data$max_value  # Replace "max_column" with the actual column name containing the maximum values

# Plot the histogram
hist(max_values,
     main = "Distribution of Maximum Values",
     xlab = "Maximum Values",
     ylab = "Frequency",
     col = "skyblue",
     border = "black",
     breaks = 10)  # Adjust the number of bins as needed



ggplot(data, aes(x =max_values )) +
               geom_freqpoly(color = "blue", alpha = 0.5) +  # Adjust color and transparency
               labs(title = "Distribution of column_name", x = "Values", y = "Density")






