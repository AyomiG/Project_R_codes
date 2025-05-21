# Load required packages
rm(list = ls(all = TRUE))
library(terra)
library(sf)
library(RColorBrewer)

# Load the bin rasters
bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = ".tif", full.names = TRUE)
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F", pattern = "[1-9]_[1-9]", full.names = TRUE)
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

# Define weights with names corresponding to the bin rasters
weights <- c(5.597, 4.873, 2.702, 2.333, 4.166, 2.452, 6.653, 5.513, 5.937, 5.058, 0.750, 2.969, 3.144, 0.646, 6.021, 5.244, 5.130, 4.017, 6.342, 4.471, 1.223)
names(weights) <- paste0(c("1_1_1", "1_1_2", "1_1_3", "1_1_4", "1_2_1", "1_2_2", 
                           "2_1_1", "2_1_2", "2_1_3", "2_1_4", "2_2_1", "2_2_2", "2_2_3", "2_2_4", 
                           "3_1_1", "3_1_2", "3_1_3", "3_1_4", "3_2_1", "3_2_2","3_2_4"), ".tif")
# Remove the ratios vector since we're not using ratios anymore

# Assign names to bin_rasters
names(bin_rasters) <- names(weights)

# Initialize the combined raster with zeros, matching the extent and CRS of the first bin raster
combined_raster <- rast(nrow=nrow(bin_rasters[[1]]), ncol=ncol(bin_rasters[[1]]), ext=ext(bin_rasters[[1]]), crs=crs(bin_rasters[[1]]))
values(combined_raster) <- 0

# Loop through each bin raster and apply the weights only (no ratio scaling)
for (bin_name in names(bin_rasters)) {
               weight <- weights[bin_name]
               current_raster <- bin_rasters[[bin_name]]
               
               # Multiply the current raster by its weight (no ratio scaling)
               weighted_raster <- current_raster * weight
               
               # Add the weighted raster to the combined raster
               combined_raster <- combined_raster + weighted_raster
}

# Calculate the sum of weights
sum_weights <- sum(weights)

# Normalize the combined raster by the sum of weights (since no ratios are used)
combined_raster <- combined_raster / sum_weights

# 
# n_colors <- 100 # More colors for better differentiation between values
# palette <- colorRampPalette(brewer.pal(9, "RdPu"))(n_colors) 

# Crop and mask the raster to the Zurich boundary
cropped_raster <- crop(combined_raster, ext(zurich_boundary))
masked_raster <- mask(cropped_raster, zurich_boundary)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/acidic.tif" ) 
xt=ext(acidic)
Waterbodiess=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess = crop(Waterbodiess, xt)
#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)
# 
# # # # Define File name
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/nc/C_Con.png"
#fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I//nc/C_Comp.png"
#masked_raster2=raster1 <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/scaled_ones/scaled_C_con.tif")

# # # # 
# # # # # Define the colors representing shades of green, yellow, and orange
# # # # # Define the colors representing shades of green, yellow, and orange
#  png(fln,width=30,height=40,unit="cm",res=300,pointsize=7.5)
#  plot(masked_raster2C, col = palette, legend = FALSE, axes = FALSE, mar = c(0.1, 0.1, 0.1, 0.1))
# # # Plot the masked raster with selected places in red
# # # Plot the masked raster with selected places in red
# # # plot(cut_raster1, col = colors(length(breaks) - 1), axes=F,legend = F,add = TRUE)
#  plot(Waterbodiess, add = TRUE, 
#   col = c("skyblue", "#FFFFFF00"),  # White with alpha channel (transparent)
#   legend = FALSE, axes = FALSE)
#  plot(tot,col ="#FFC107",legend=F,axes=F, add=T)
# # # Close PNG device
# # dev.off()
# # # # Close the plot
# dev.off()
# #op = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/C_comp.tif"
#  op = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/C_con.tif"
# # 
# # # Assuming the desired folder is one level above your current working directory:
#  writeRaster(masked_raster, op,overwrite = TRUE)

 # Plotting
 png(fln, width=30, height=40, unit="cm", res=300, pointsize=7.5)
 
# Define breaks for low, medium, and high
breaks <- c(0, 33, 66, 100)  # 0-33 Low, 34-66 Medium, 67-100 High
palette <- c("#FDE0DD", "#D467A5", "#67001F") 

plot(masked_raster, 
     col = palette, 
     breaks = breaks,  # Define the categories
     legend = FALSE, 
     axes = FALSE, 
     mar = c(0.1, 0.1, 0.1, 0.1))

plot(Waterbodiess, add = TRUE, 
     col = c("deepskyblue", "#FFFFFF00"), 
     legend = FALSE, 
     axes = FALSE)

plot(tot, 
     col = "#EEDC85",  # Golden color for specific layer
     legend = FALSE, 
     axes = FALSE, 
     add = TRUE)

dev.off()
