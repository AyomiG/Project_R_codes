# Set the main directory path
main_directory <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/Output_with_postprocess"

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

terra::plot(terra_stack[[17:35]])

terra::plot(terra_stack[[33:35]])


# Assuming final_raster_stack is a list of SpatRaster objects with associated file paths



























# Overlay the rasters
overlay_raster <- terra::overlay(final_raster_stack)

# Plot the overlay raster
plot(overlay_raster)




ap=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/ZH/APA.shp")
plot(ap)
shapefile=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/ZH/Zur.shp")
##area 166083
library(sf)

# Check the structure of the shapefile
str(shapefile)

# Calculate the area of the single feature in square meters
area_m2 <- st_area(shapefile)

# Print the calculated area
print(area_m2)

# Install and load the sf package
install.packages("sf")
library(sf)

# Replace "path/to/your/shapefile1.shp" and "path/to/your/shapefile2.shp" with the paths to your shapefiles
shapefile1 <- st_read("path/to/your/shapefile1.shp")
shapefile2 <- st_read("path/to/your/shapefile2.shp")

# Combine the two shapefile# Set the main directory path
main_directory <- "C:/path/to/your/directory"

# Get a list of subdirectories in the main directory
subdirectories <- list.dirs(main_directory, full.names = TRUE, recursive = FALSE)

# Initialize an empty list to store individual raster stacks
raster_stacks <- list()

# Loop through each subdirectory
for (subdirectory in subdirectories) {
               # Get a list of raster files in the subdirectory
               raster_files <- list.files(subdirectory, pattern = "rankmap.tif", full.names = TRUE)
               
               # Check if there are raster files in the subdirectory
               if (length(raster_files) > 0) {
                              # Initialize an empty list to store individual rasters
                              rasters <- list()
                              
                              # Loop through each raster file
                              for (raster_file in raster_files) {
                                             # Load the raster
                                             current_raster <- raster(raster_file)
                                             
                                             # Check if the raster is valid
                                             if (!is.null(current_raster)) {
                                                            rasters[[raster_file]] <- current_raster
                                             } else {
                                                            warning(paste("Skipping invalid raster file:", raster_file))
                                             }
                              }
                              
                              # Check if there are valid rasters to stack
                              if (length(rasters) > 0) {
                                             raster_stack <- stack(rasters)
                                             raster_stacks[[subdirectory]] <- raster_stack
                              } else {
                                             warning(paste("No valid raster files found in:", subdirectory))
                              }
               }
}

# Check if there are raster stacks to work with
if (length(raster_stacks) > 0) {
               # Perform further analysis or visualization with the raster stacks
} else {
               warning("No valid raster stacks found in any subdirectory.")
}
s into a single sf object
combined_shapefile <- st_combine(c(shapefile1, shapefile2))

# Save the combined shapefile to a new file
st_write(combined_shapefile, "path/to/your/output/combined_shapefile.shp")
