rm(list = ls(all = TRUE))
# Load necessary libraries
library(dplyr)
library(terra)

# Read species and habitat bin data
spec1 <- read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua - Copy/dataprep1.csv")

# Identify raster files
raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current", pattern = "*.tif", full.names = TRUE)

# Clean and organize habitat bin data
bins <- na.omit(bins[, 1:5])
uni_bins <- unique(bins[, 1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
uni_bins$PH <- as.numeric(uni_bins$PH)
uni_bins$Elevation <- as.numeric(uni_bins$Elevation)
uni_bins <- na.omit(uni_bins)

# Merge species data with habitat bin data
combo <- merge(spec1, uni_bins, by.x = "TypoCH2", by.y = "hab")
filtered_combo <- combo %>% filter(has_VALPAR_SDM == 1)
filtered_combo$with_dot = gsub(" ", ".", filtered_combo$VALPAR_SDM)

# Initialize an empty list to store matching files
matching_files_list <- vector("list", length = nrow(filtered_combo))

# Loop through each row of filtered_combo
for (i in 1:nrow(filtered_combo)) {
               value <- paste0(filtered_combo$with_dot[i], "_")
               matching_files <- grep(value, raster_files, value = TRUE)
               if (length(matching_files) > 1) {
                              stop(matching_files)
               }
               matching_files_list[[i]] <- matching_files
}

# Add matching files information to filtered_combo
filtered_combo$Matching_Files <- matching_files_list

# Filter out rows with empty matching file lists
filtered_combo <- filtered_combo %>% filter(sapply(Matching_Files, length) > 0)

# Merge the content of the three columns into one column
filtered_combo$Combined <- paste(filtered_combo$PH, "_", filtered_combo$Elevation, "_", filtered_combo$Humidity, sep = "")

# Load the raster of Acer pseudoplatanus_zh
acer_raster <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current/Acer pseudoplatanus_zh.tif")

# Create a mask for non-NA values
#my_mask <- terra::ifel(!is.na(acer_raster), 1, NA)

# Assuming you have your unique values and other necessary data loaded
unique_values <- unique(filtered_combo$Combined)

for (value in unique_values) {
               # Filter rasters based on the current value
               selected_rasters <- unique(unlist(filtered_combo$Matching_Files[filtered_combo$Combined == value]))
               selected_rasters <- rast(selected_rasters)
               
               # Replace NA values with 0
               selected_rasters[is.na(selected_rasters)] <- 0
               
               # Calculate sum and multiply by 100
               sm <- sum(selected_rasters) * 100
               
               # Save the output raster to a file
               file_name <- paste0(value, ".tif")
               writeRaster(sm, filename = file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/sm_bins_con", file_name), overwrite = TRUE)
}



##Resistance
# Specify the folder path where your raster files are located
folder_path <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/sm_bins_con/sm_bins_conn/"
# List the files in the folder
raster_files <- list.files(folder_path, full.names = TRUE)

# Specify the folder path where you want to save the processed rasters
Res_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/res_bin/"

# Loop through each raster file
for (file in raster_files) {
               # Load the raster object
               raster_obj <- rast(file)
               
               # Perform operations on the raster object
               log_tych_b <- log(raster_obj + 2)
               res_tych_b <- max(values(log_tych_b), na.rm = TRUE) - log_tych_b
               res_tych_b <- res_tych_b / max(values(res_tych_b), na.rm = TRUE)
               
               # Save the resulting raster object
               writeRaster(res_tych_b, filename = paste0(Res_folder, basename(file), ".tif"), overwrite = TRUE)
               
               
               
}




# Set your working directory to the folder containing the files


# List all files in the directory
files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75n/PA_con", full.names = T)
# Define regular expression pattern to match the desired dimension format
# Define regular expression pattern to match the desired dimension format
pattern <- "\\d+-\\d+_\\d"

# Extract and rename files based on the pattern
# Extract and rename files based on the pattern
for (file in files) {
               # Extract figures matching the pattern
               new_name <- gsub(".*(\\d+-\\d+_\\d)\\..*", "\\1", file)
               
               # Get the extension
               extension <- tools::file_ext(file)
               
               # Construct the new file name with extension
               new_name <- paste0(new_name, ".", extension)
               
               # Rename the file
               file.rename(file, new_name)
}
