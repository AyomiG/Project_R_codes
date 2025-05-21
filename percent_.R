library(terra)

# Load rasters
raster_paths <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled", pattern = "\\.tif$", full.names = TRUE)
rasters <- rast(raster_paths)  # Stack of 21 rasters

# Create binary masks for "high" values in each raster (top third or using quantile)
high_masks <- lapply(1:nlyr(rasters), function(i) {
               layer <- rasters[[i]]
               thresh <- quantile(values(layer), 0.66, na.rm = TRUE)  # Using 66th percentile
               binary_mask <- layer > thresh
               return(binary_mask)
})

# Convert list to SpatRaster
high_mask_stack <- rast(high_masks)

# Count how many rasters classify each cell as "high"
count_map <- sum(high_mask_stack, na.rm = TRUE)


# Statistics and visualization
# Summary statistics
summary(count_map)