# load required packages
rm(list = ls(all = TRUE))
library(terra)
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg"

# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = ".tif", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("3_[0-9]_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- sum(raster_stack)
threshold_value <- 0.01
# Create a binary raster based on the threshold
binary_raster <- mean_raster >= threshold_value
# Set cells with a value of 0 to NA
binary_raster[binary_raster == 0] <- NA
output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG","alkaline.tif")
writeRaster(binary_raster, output_path, overwrite = TRUE)




# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
# Elevation
selected_files=rankmap_files[grep("[0-9]_1_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- sum(raster_stack)
threshold_value <- 0.01
# Create a binary raster based on the threshold
binary_raster <- mean_raster >= threshold_value
# Set cells with a value of 0 to NA
binary_raster[binary_raster == 0] <- NA
output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG","low.tif")
writeRaster(binary_raster, output_path, overwrite = TRUE)




# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
# Elevation
selected_files=rankmap_files[grep("[0-9]_[0-9]_2", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- sum(raster_stack)
threshold_value <- 0.01
# Create a binary raster based on the threshold
binary_raster <- mean_raster >= threshold_value
# Set cells with a value of 0 to NA
binary_raster[binary_raster == 0] <- NA
output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG","moist.tif")
writeRaster(binary_raster, output_path, overwrite = TRUE)





































# Set the path to the parent directory containing the 36 folders
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75"

# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = ".tif", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("1_[0-9]_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- sum(raster_stack)
threshold_value <- 0.01
# Create a binary raster based on the threshold
binary_raster <- mean_raster >= threshold_value
# Set cells with a value of 0 to NA
binary_raster[binary_raster == 0] <- NA
output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75","alkaline.tif")
writeRaster(binary_raster, output_path, overwrite = TRUE)




# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
# Elevation
selected_files=rankmap_files[grep("[0-9]_3_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- sum(raster_stack)
threshold_value <- 0.01
# Create a binary raster based on the threshold
binary_raster <- mean_raster >= threshold_value
# Set cells with a value of 0 to NA
binary_raster[binary_raster == 0] <- NA
output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75","high.tif")
writeRaster(binary_raster, output_path, overwrite = TRUE)




# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)

selected_files=rankmap_files[grep("[0-9]_[0-9]_4", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- sum(raster_stack)
threshold_value <- 0.01
# Create a binary raster based on the threshold
binary_raster <- mean_raster >= threshold_value
# Set cells with a value of 0 to NA
binary_raster[binary_raster == 0] <- NA
output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75","dry.tif")
writeRaster(binary_raster, output_path, overwrite = TRUE)

