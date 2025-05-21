

rm(list = ls(all = TRUE))
library(rgdal)
library(terra)
library(sf)
# Set the path to the parent directory containing the 35 folders
parent_dir <- "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\masked_areas"

# Get the list of files ending with "masked_*.tif"
masked_files <- list.files(parent_dir, pattern = "masked75_.*\\.tif$", full.names = TRUE)

# Loop over the list of raster paths
for (path in masked_files) {
               # Load masked raster
               masked_map <- rast(path)
               
               # Scaling operation
               ac_q <- quantile(values(masked_map), probs = seq(0, 1, 0.01), na.rm = TRUE)
               vls_sc <- cut(values(masked_map), breaks = ac_q)
               vls_sc <- as.numeric(vls_sc)
               
               resc_map <- masked_map
               values(resc_map) <- vls_sc
               
               # Save the scaled raster with the same identifier
               identifier <- gsub('.*/masked75_(\\d+_\\d+_\\d+).*', '\\1', path)
               output_path <- file.path(parent_dir, paste0("scaled75_", identifier, ".tif"))
               writeRaster(resc_map, output_path, overwrite = TRUE)
}
