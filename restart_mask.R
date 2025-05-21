# Remove all objects from the global environment
rm(list = ls(all = TRUE))
library(rgdal)
library(terra)
library(sf)
#library(raster)

# Set the path to the parent directory containing the 36 folders
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/Output_with_postprocess"

# Get the list of files ending with "rankmap.tif"
rankmap_files <- list.files(parent_dir, pattern = "rankmap\\.tif$", recursive = TRUE, full.names = TRUE)
cantons  <-   vect("C:/Users/ogundipe/Downloads/swissboundaries3d_2019-01_2056_5728.shp/swissBOUNDARIES3D_1_5_TLM_KANTONSGEBIET.shp")  # Replace with your actual file path
cantons=project(cantons, "epsg:21781")
zurich_canton <-  cantons[cantons$NAME == "Zürich", ] 

protected_areas <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/CPA.tif")
protected_areas <- project(protected_areas, "epsg:21781")  # Project to EPSG:21781

water_bodies <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/LU-CH_2018all.tif")
water_bodies1 <- project(water_bodies, "epsg:21781")  # Project to EPSG:21781

# Loop over the list of raster paths
for (path in rankmap_files) {
               # Load raster
               main_map <- rast(path)
               
               # Change CRS to EPSG:21781
               main_map <- project(main_map, "epsg:21781")
               
               # Extract the identifier from the filename (e.g., "3_3_4" or "3_3_3")
               identifier <- gsub('.*/(\\d+_\\d+_\\d+).*', '\\1', path)
               
               # Masking operations
            # Assuming getCantons is a function to get cantons by name
               main_map <- crop(main_map, ext(zurich_canton))
               zurich_canton_raster <- rasterize(zurich_canton, main_map, field = "NAME")
               masked_raster <- mask(main_map, zurich_canton_raster)
               
               # Replace the placeholder paths with actual file paths
               
               protected_areas <- crop(protected_areas, ext(masked_raster))
               masked_raster[protected_areas > 0] <- NA
               
               
               water_bodies1[water_bodies1 != 61 & water_bodies1 != 62] <- NA
               water_bodies1 <- crop(water_bodies1, ext(masked_raster))
               final_map <- mask(masked_raster, water_bodies1, inverse = TRUE)
               
               # Save the masked raster with the identifier as part of the filename
               output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas", paste0("masked75_", identifier, ".tif"))
               writeRaster(final_map, output_path, overwrite = TRUE)
}
