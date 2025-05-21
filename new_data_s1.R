
rm(list = ls(all = TRUE))
# Load necessary libraries
library(dplyr)
library(terra)
library(raster)
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
filtered_combo$Combined <- paste(filtered_combo$PH, "_",filtered_combo$Elevation, "_",
filtered_combo$Humidity,sep = "")

# Load the raster of Acer pseudoplatanus_zh
acer_raster <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current/Acer pseudoplatanus_zh.tif")

# Create a mask for non-NA values
my_mask <- terra::ifel(!is.na(acer_raster), 1, NA)

# Assuming you have your unique values and other necessary data loaded
unique_values <- unique(filtered_combo$Combined)

for (value in unique_values) {
               # Filter rasters based on the current value
               selected_rasters <- unique(unlist(filtered_combo$Matching_Files[filtered_combo$Combined == value]))
               selected_rasters <- rast(selected_rasters)
               
               # Replace NA values with 0
               selected_rasters[is.na(selected_rasters)] <- 0
               
               # Calculate sum
               sm <- sum(selected_rasters)
               
               # Mask the sum
               out <- mask(sm, my_mask)
               
               # Save the output raster to a file
               file_name <- paste0(value, ".tif")
               writeRaster(out, filename = file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/sm_bins", file_name), overwrite = TRUE)
}


# Set the working directories for rasters and CSV files
raster_folder  <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/sm_bins"
csv_folder  <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_file"
# List the files in the raster and CSV folders
raster_files <- list.files(raster_folder, pattern = ".tif", full.names = TRUE)
output_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_dv"
# Loop through each raster file
for (raster_file in raster_files) {
               # Extract the common identifier from the raster file name
               common_identifier <- tools::file_path_sans_ext(basename(raster_file))
               # Construct the corresponding CSV file path
               csv_file <- file.path(csv_folder, paste(common_identifier, ".csv", sep = ""))
               # Read the raster
               raster <- rast(raster_file)
               # Read the corresponding CSV file
               if (file.exists(csv_file)) {
               csv_data <- read.csv(csv_file)
               # Extract the number of rows in the CSV file
               num_rows <- nrow(csv_data)
               # Divide the raster by the number of rows
               divided_raster <- raster / num_rows
               # Define the output file name
               output_file <- file.path(output_folder, paste("result_", common_identifier, ".tif", sep = ""))
               # Save the divided raster as a GeoTIFF
               writeRaster(divided_raster, filename = output_file)
               } else {
               cat("CSV file not found for", common_identifier, "\n")
               }
}



#One time code

# # Assuming filtered_combo is your data frame
# output_location <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/ND_csv/"
# 
# # Get unique values in the Combined column
# unique_values <- unique(filtered_combo$Combined)
# 
# # Loop through unique values and create CSV and text files
# for (value in unique_values) {
#                # Filter rows for the current value in Combined
#                subset_df <- filtered_combo[filtered_combo$Combined == value, ]
#                
#                # Extract Matching_Files names as character vector
#                matching_files <- as.character(subset_df$Matching_Files)
#                
#                # Write to CSV file
#                csv_file <- paste0(output_location, value, ".csv")
#                write.csv(data.frame(Matching_Files = matching_files), file = csv_file, row.names = FALSE)
#                
#                # Write to text file
#                txt_file <- paste0(output_location, value, ".txt")
#                writeLines(c("/"filename\"", matching_files), txt_file)
# }
# 
# 
