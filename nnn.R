# Set the main directory path
main_directory <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/Output_average_with_postprocess"

# Get a list of all subdirectories
subdirectories <- list.dirs(main_directory, full.names = TRUE, recursive = FALSE)

# Initialize an empty list to store individual raster stacks
raster_stacks <- list()

# Initialize an empty vector to store titles
titles <- character()

# Loop through each subdirectory
for (subdir in subdirectories) {
               
               # Check if the "final_output" subfolder exists
               final_output_path <- file.path(subdir, "final_output")
               if (dir.exists(final_output_path)) {
                              
                              # Check if the "rankmap.tif" file exists within "final_output"
                              rankmap_file <- list.files(final_output_path, pattern = "rankmap.tif", full.names = TRUE)
                              if (length(rankmap_file) > 0) {
                                             
                                             # Extract numeric part from the file path as title
                                             title <- gsub("[^0-9]", "", basename(subdir))
                                             
                                             # Read the raster and add it to the list
                                             raster <- rast(rankmap_file)
                                             raster_stacks <- c(raster_stacks, raster)
                                             
                                             # Add title to the vector
                                             titles <- c(titles, title)
                              }
               }
}

# Check if there are rasters to stack
if (length(raster_stacks) > 0) {
               
               # Stack the rasters
               final_raster_stack <- c(raster_stacks)
               
               # Set titles for each layer
               names(final_raster_stack) <- titles
               
               # Print information about the stacked raster
               print(final_raster_stack)
               
} else {
               cat("No valid raster files found.")
}

# Assuming final_raster_stack is a list of SpatRaster objects
terra_stack <- rast(final_raster_stack)

# Plot with titles
terra::plot(terra_stack)
