library(terra)

# List all raster files in the folder
bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = ".tif", full.names = TRUE)

# Initialize a list to store the selected cells for each bin
selected_cells <- list()
# Define the bin areas
# bin_areas <- c("1_1_1" = 133, "1_1_2" = 133, "1_1_3" = 33, "1_1_4" = 33, "1_2_1" = 133,
#                "1_2_2" = 33, "1_2_3" = 33, "1_2_4" = 33, "2_1_1" = 133, "2_1_2" = 133,
#                "2_1_3" = 133, "2_1_4" = 133, "2_2_1" = 33, "2_2_2" = 33, "2_2_3" = 33,
#                "2_2_4" = 33, "3_1_1" = 133, "3_1_2" = 133, "3_1_3" = 133, "3_1_4" = 133,
#                "3_2_1" = 33, "3_2_2" = 133, "3_2_3" = 33, "3_2_4" = 33)



# Calculate cell area
cell_area <- (25 * 25) / 10000  # Converting from square meters to hectares

# Initialize a list to store the selected cells for each bin
selected_cells <- list()

# Loop through each bin raster file
for (bin_file in bin_raster_files) {
               # Read the bin raster
               bin_raster <- rast(bin_file)
               
               # Convert NA values to zeros
               bin_raster[is.na(bin_raster)] <- 0
               
               # Flatten the raster values and append to the flattened vector
               flattened_raster_values <- as.vector(bin_raster)
               
               # Find the indices of the top cells based on their values
               top_cell_indices <- order(flattened_raster_values, decreasing = TRUE)
               
               # Extract the bin code from the raster file name
               bin <- tools::file_path_sans_ext(basename(bin_file))
               
               # Get the area for this bin
               bin_area <- bin_areas[bin]
               
               # Calculate the number of cells needed for this bin
               bin_cells_needed <- round(bin_area / cell_area)
               
               # Select the required number of top cells for this bin
               selected_cells[[bin]] <- top_cell_indices[1:min(bin_cells_needed, length(top_cell_indices))]
}

# Assume selected_cells is a list containing the indices of selected cells for each bin
# Extract all selected cell indices into a single vector
all_selected_cells <- unlist(selected_cells)
combined_raster=rast(bin_raster_files)
combined_raster2=sum(combined_raster)


# Convert the indices to coordinates
coordinates <- xyFromCell(combined_raster2, all_selected_cells)
plot(combined_raster2)
# Plot the cell locations
points(coordinates, pch = 20, col = "blue")


# Concatenate all selected cells into a single vector
all_selected_cells <- unlist(selected_cells)
as.data.frame(all_selected_cells)
# Check for duplicates
duplicates <- all_selected_cells[duplicated(all_selected_cells)]

# Print duplicates if any
print(duplicates)




# #RARE
# library(terra)
# 
# # List all raster files in the folder
# bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = ".tif", full.names = TRUE)
# 
# # Initialize a list to store the selected cells for each bin
# selected_cells <- list()
# 
# bin_areas<- c("1_1_1" = 33, "1_1_2" = 33, "1_1_3" = 133, "1_1_4" = 133, "1_2_1" = 33,
#               "1_2_2" = 133, "1_2_3" = 133, "1_2_4" = 133, "2_1_1" = 33, "2_1_2" = 33,
#               "2_1_3" = 33, "2_1_4" = 33, "2_2_1" = 133, "2_2_2" = 133, "2_2_3" = 133,
#               "2_2_4" = 133, "3_1_1" = 33, "3_1_2" = 33, "3_1_3" = 33, "3_1_4" = 33,
#               "3_2_1" = 133, "3_2_2" = 33, "3_2_3" = 133, "3_2_4" = 133)
# 
# # Loop through each bin raster file
# for (bin_file in bin_raster_files) {
#                # Read the bin raster
#                bin_raster <- rast(bin_file)
#                
#                # Convert NA values to zeros
#                bin_raster[is.na(bin_raster)] <- 0
#                
#                # Flatten the raster values and append to the flattened vector
#                flattened_raster_values <- as.vector(bin_raster)
#                
#                # Find the indices of the cells based on their values in increasing order
#                sorted_cell_indices <- order(flattened_raster_values)
#                
#                # Exclude zero values from the sorted cell indices
#                non_zero_indices <- sorted_cell_indices[flattened_raster_values[sorted_cell_indices] > 0]
#                
#                # Extract the bin code from the raster file name
#                bin <- tools::file_path_sans_ext(basename(bin_file))
#                
#                # Get the area for this bin
#                bin_area <- bin_areas[bin]
#                
#                # Calculate the number of cells needed for this bin
#                bin_cells_needed <- round(bin_area / cell_area)
#                
#                # Select the required number of cells for this bin
#                selected_cells[[bin]] <- non_zero_indices[1:min(bin_cells_needed, length(non_zero_indices))]
# }
# 
# # Assume selected_cells is a list containing the indices of selected cells for each bin
# # Extract all selected cell indices into a single vector
# all_selected_cells <- unlist(selected_cells)
# combined_raster=rast(bin_raster_files)
# combined_raster2=sum(combined_raster)
# 
# # Convert the indices to coordinates
# coordinates <- xyFromCell(combined_raster2, all_selected_cells)
# 
# # Plot the combined raster
# plot(combined_raster2)
# 
# # Plot the cell locations
# points(coordinates, pch = 20, col = "blue")
# 
# 
# # Concatenate all selected cells into a single vector
# all_selected_cells <- unlist(selected_cells)
# as.data.frame(all_selected_cells)
# # Check for duplicates
# duplicates <- all_selected_cells[duplicated(all_selected_cells)]
# 
# # Print duplicates if any
# print(duplicates)
# 
?masking
