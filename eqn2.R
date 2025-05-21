rm(list = ls(all = TRUE))
library(terra)
library(sf) 

# Load bin raster files
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/SR", pattern = ".tif", full.names = TRUE)
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F", pattern = ".tif", full.names = TRUE)
bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = ".tif", full.names = TRUE)

# Load bin rasters
bin_rasters <- lapply(bin_raster_files, rast)

# Load Zurich canton shapefile
zurich_boundary <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/zurich.shp")

# Define weights with names corresponding to the bin rasters
weights <- c(5.597, 4.873, 2.702, 2.333, 4.166, 2.452, 0.723, 0.362, 6.653, 5.513, 5.937, 5.058, 0.750, 2.969, 3.144, 0.646, 6.021, 5.244, 5.130, 4.017, 6.342, 4.471, 1.302, 1.223)
names(weights) <- paste0(c("1_1_1", "1_1_2", "1_1_3", "1_1_4", "1_2_1", "1_2_2", "1_2_3", "1_2_4", 
                           "2_1_1", "2_1_2", "2_1_3", "2_1_4", "2_2_1", "2_2_2", "2_2_3", "2_2_4", 
                           "3_1_1", "3_1_2", "3_1_3", "3_1_4", "3_2_1", "3_2_2", "3_2_3", "3_2_4"), ".tif")

# Initialize variables to store the weighted sum and sum of weights
weighted_sum <- 0
sum_weights <- sum(weights)

# Loop through each bin raster and apply the weights
for (i in seq_along(bin_rasters)) {
               current_raster <- bin_rasters[[i]]
               
               # Calculate the weighted sum
               weighted_sum <- weighted_sum + (weights[i] * current_raster)
}

# Calculate the mean of all bin rasters
mean_rasters <- sum(rast(bin_rasters)) / length(bin_rasters)

# Combine the weighted sum and the mean
combined_raster <- weighted_sum / sum_weights *mean_rasters

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

