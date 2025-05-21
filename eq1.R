# Load required packages
rm(list = ls(all = TRUE))
library(terra)
library(sf)

# Load the bin rasters
bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = ".tif", full.names = TRUE)
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F", pattern = ".tif", full.names = TRUE)
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/SR", pattern = ".tif", full.names = TRUE)

bin_rasters <- lapply(bin_raster_files, rast)

# Load Zurich canton shapefile
zurich_boundary <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/zurich.shp")

# Check CRS of the raster and the shapefile
raster_crs <- crs(bin_rasters[[1]])
shapefile_crs <- crs(zurich_boundary)

# Reproject Zurich boundary shapefile if CRS do not match
if (!identical(raster_crs, shapefile_crs)) {
               zurich_boundary <- project(zurich_boundary, raster_crs)
}

# Define weights and ratios with names corresponding to the bin rasters
weights <- c(5.597, 4.873, 2.702, 2.333, 4.166, 2.452,6.653, 5.513, 5.937, 5.058, 0.750, 2.969, 3.144, 0.646, 6.021, 5.244, 5.130, 4.017, 6.342, 4.471, 1.223)
names(weights) <- paste0(c("1_1_1", "1_1_2", "1_1_3", "1_1_4", "1_2_1", "1_2_2", 
                           "2_1_1", "2_1_2", "2_1_3", "2_1_4", "2_2_1", "2_2_2", "2_2_3", "2_2_4", 
                           "3_1_1", "3_1_2", "3_1_3", "3_1_4", "3_2_1", "3_2_2","3_2_4"), ".tif")
ratios <- c("1_1_1.tif" = 1.369, "1_1_2.tif" = 1.334, "1_1_3.tif" = 1.264, "1_1_4.tif" = 1.292, "1_2_1.tif" = 1.470,
            "1_2_2.tif" = 1.415, "2_1_1.tif" = 1.343, "2_1_2.tif" = 1.283,
            "2_1_3.tif" = 1.345, "2_1_4.tif" = 1.365, "2_2_1.tif" = 1.656, "2_2_2.tif" = 1.279, "2_2_3.tif" = 1.230,
            "2_2_4.tif" = 1.534, "3_1_1.tif" = 1.370, "3_1_2.tif" = 1.331, "3_1_3.tif" = 1.287, "3_1_4.tif" = 1.278,
            "3_2_1.tif" = 1.503, "3_2_2.tif" = 1.475,"3_2_4.tif" = 1.143)

# Assign names to bin_rasters
names(bin_rasters) <- names(weights)

# Initialize the combined raster with zeros, matching the extent and CRS of the first bin raster
combined_raster <- rast(nrow=nrow(bin_rasters[[1]]), ncol=ncol(bin_rasters[[1]]), ext=ext(bin_rasters[[1]]), crs=crs(bin_rasters[[1]]))
values(combined_raster) <- 0

# Loop through each bin raster and apply the weights and ratios
for (bin_name in names(bin_rasters)) {
               weight <- weights[bin_name]
               ratio <- ratios[bin_name]
               current_raster <- bin_rasters[[bin_name]]
               
               # Multiply the current raster by its weight and ratio
               weighted_raster <- current_raster * weight * (1 / ratio)
               
               # Add the weighted raster to the combined raster
               combined_raster <- combined_raster + weighted_raster
               
}

# Calculate the sum of weights
sum_weights <- sum(weights)

# Calculate the sum of inverse ratios
sum_inverse_ratios <- sum(1 / unname(ratios))

# Divide the combined raster by the product of the sum of weights and the sum of inverse ratios
combined_raster <- combined_raster / (sum_weights * sum_inverse_ratios)


plot(combined_raster)

# # Convert the combined raster to a vector and sort to get top cells
# flattened_combined_values <- as.vector(combined_raster)
# sorted_indices <- order(flattened_combined_values, decreasing = TRUE)
# 
# # Assume each cell represents 625 square meters
# cell_area <- 625
# total_area_needed <- 2000 * 10000 # in square meters
# num_cells_needed <- round(total_area_needed / cell_area)
# 
# # Select the top cells
# selected_cells <- sorted_indices[1:num_cells_needed]
# 
# # Initialize the selected cells raster with zeros
# selected_raster <- rast(nrow=nrow(combined_raster), ncol=ncol(combined_raster), ext=ext(combined_raster), crs=crs(combined_raster))
# values(selected_raster) <- 0
# 
# # Set the values of the selected cells to 1
# values(selected_raster)[selected_cells] <- 1

# Crop and mask the raster to the Zurich boundary
cropped_raster <- crop(combined_raster, ext(zurich_boundary))
masked_raster2 <- mask(cropped_raster, zurich_boundary)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/acidic.tif" ) 
xt=ext(acidic)
# Load elevation
elev=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Elevation_25.tif")
elev=terra::project(elev,acidic)
elev<- resample(elev, acidic, method = "bilinear")
# Crop elelvation
telev=crop(elev,xt)
# telev = disagg(telev,fact=6,method="bilinear")
# telev=telev/10
telev <- mask(telev, acidic)


# Prepare hillshade
slp <- terrain(telev, v = "slope", unit="radians")
asp <- terrain(telev, v = "aspect", unit="radians")
hillshd <-shade(slp, asp,direction=315)
# Resample hillshade to match Zurich raster
# zurich_canton_raster <- rasterize(zurich_canton, elev, field = "NAME")
hill_resampled <- resample(hillshd, acidic, method = "bilinear")
hillsh = crop(hill_resampled,xt)
hillsh <- mask(hillsh, acidic)
hillcol=colorRampPalette(c("#00000000","#000000DA"),alpha=TRUE)
##water
Waterbodiess=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess = crop(Waterbodiess, xt)
#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)

# # # Define File name
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/CONG.png"
# # # 
# # # # Define the colors representing shades of green, yellow, and orange
# # # # Define the colors representing shades of green, yellow, and orange
png(fln,width=30,height=40,unit="cm",res=300,pointsize=7.5)
# # pdf(fln,width=10/2.54,height=6.54/2.54,useDingbats = F,pointsize=7.5)
plot(masked_raster2, col = c("ivory2", "red"), legend = FALSE, axes = FALSE, mar = c(0.1, 0.1, 0.1, 0.1))
# Plot the masked raster with selected places in red
# Plot the masked raster with selected places in red
# plot(cut_raster1, col = colors(length(breaks) - 1), axes=F,legend = F,add = TRUE)
plot(Waterbodiess, add = TRUE, 
     col = c("darkblue", "#FFFFFF00"),  # White with alpha channel (transparent)
     legend = FALSE, axes = FALSE)
plot(tot,col ="tan",legend=F,axes=F, add=T)
# Close PNG device
dev.off()

# Save the composite raster to a new file
#writeRaster(masked_raster2, "ConnectivityC.tif",overwrite = TRUE)



