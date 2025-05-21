# Clear environment
rm(list = ls())

# Load required libraries
library(terra)
library(sf)

# Load bin raster files
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = ".tif", full.names = TRUE)
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F", pattern = ".tif", full.names = TRUE)
bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/SR", pattern = ".tif", full.names = TRUE)

# Load bin rasters
bin_rasters <- lapply(bin_raster_files, rast)
zurich_boundary <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/zurich.shp")

# Define ratios and weights with names corresponding to the bin rasters
ratios <- c("1_1_1" = 1.369, "1_1_2" = 1.334, "1_1_3" = 1.264, "1_1_4" = 1.292, "1_2_1" = 1.470,
            "1_2_2" = 1.415, "1_2_3" = 1.242, "1_2_4" = 1.100, "2_1_1" = 1.343, "2_1_2" = 1.283,
            "2_1_3" = 1.345, "2_1_4" = 1.365, "2_2_1" = 1.656, "2_2_2" = 1.279, "2_2_3" = 1.230,
            "2_2_4" = 1.534, "3_1_1" = 1.370, "3_1_2" = 1.331, "3_1_3" = 1.287, "3_1_4" = 1.278,
            "3_2_1" = 1.503, "3_2_2" = 1.475, "3_2_3" = 1.482, "3_2_4" = 1.143)

weights <- c(5.597, 4.873, 2.702, 2.333, 4.166, 2.452, 0.723, 0.362, 6.653, 5.513, 5.937, 5.058, 
             0.750, 2.969, 3.144, 0.646, 6.021, 5.244, 5.130, 4.017, 6.342, 4.471, 1.302, 1.223)
names(weights) <- names(ratios)

# Calculate the mean of the weights and the mean of the ratios
mean_weight <- mean(weights)
mean_ratio <- mean(ratios)

# Initialize the combined raster with zeros, matching the extent and CRS of the first bin raster
combined_raster <- rast(nrow = nrow(bin_rasters[[1]]), ncol = ncol(bin_rasters[[1]]), ext = ext(bin_rasters[[1]]), crs = crs(bin_rasters[[1]]))
values(combined_raster) <- 0

# Loop through each bin raster and apply the mean weight and mean ratio
for (i in seq_along(bin_rasters)) {
               current_raster <- bin_rasters[[i]]
               combined_raster <- combined_raster + (current_raster * mean_weight * mean_ratio)
}

# Convert the combined raster to a vector and sort to get top cells
flattened_combined_values <- as.vector(combined_raster)
sorted_indices <- order(flattened_combined_values, decreasing = TRUE)

# Assume each cell represents 625 square meters
cell_area <- 625
total_area_needed <- 2000 * 10000 # in square meters
num_cells_needed <- round(total_area_needed / cell_area)

# Select the top cells
selected_cells <- sorted_indices[1:num_cells_needed]
# Initialize the selected cells raster with zeros
selected_raster <- rast(nrow=nrow(combined_raster), ncol=ncol(combined_raster), ext=ext(combined_raster), crs=crs(combined_raster))
values(selected_raster) <- 0

# Set the values of the selected cells to 1
values(selected_raster)[selected_cells] <- 1
zurich_boundary=project(zurich_boundary, "epsg:21781")

# Crop and mask the raster to the Zurich boundary
cropped_raster <- crop(selected_raster, ext(zurich_boundary))
masked_raster <- mask(cropped_raster, zurich_boundary)

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

plot(masked_raster, col = c("white", "red"),legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
# Plot the masked raster with selected places in red
# Plot the masked raster with selected places in red
# plot(cut_raster1, col = colors(length(breaks) - 1), axes=F,legend = F,add = TRUE)
plot(Waterbodiess,col ="blue1",legend=F,axes=F, add=T)
plot(tot,col ="wheat3",legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8, add=T)



