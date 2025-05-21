# load required packages
rm(list = ls(all = TRUE))
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"

# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = ".shp", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("result_[0-9]_1", rankmap_files )]
# Read in the selected shapefiles
shapefiles <- lapply(selected_files, st_read)

# Combine all shapefiles into one
combined_shapefile <- do.call(st_union, shapefiles)

# Write the combined shapefile to disk
write_sf(combined_shapefile, "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/combined_shapefilel.shp")





# load required packages
rm(list = ls(all = TRUE))
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"

library(sf)

# Set the path to the parent directory containing the shapefiles
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"

# Get the list of shapefiles
rankmap_files <- list.files(parent_dir, pattern = "\\.shp$", full.names = TRUE)
selected_files=rankmap_files[grep("result_[0-9]_[0-9]_4", rankmap_files )]

# Initialize an empty list to store individual shapefiles
shapefiles <- list()

# Read in each shapefile and append it to the list
for (file in selected_files) {
               shapefile <- st_read(file)
               shapefiles <- c(shapefiles, list(shapefile))
}

# Combine all shapefiles into one
combined_shapefile <- do.call(rbind, shapefiles)
# Write the combined shapefile to disk
write_sf(combined_shapefile, "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/combined_shapefiledry.shp")
