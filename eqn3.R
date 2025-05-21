# Load required libraries
rm(list = ls(all = TRUE))
library(terra)
library(sf)
library(RColorBrewer)

# Load bin raster files
bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = "[0-9]_[0-9]_[0-9]", full.names = TRUE)
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F", pattern = "[0-9]_[0-9]_[0-9]", full.names = TRUE)
#bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/SR", pattern = ".tif", full.names = TRUE)

# Method 1: Using terra package (recommended, faster)
# Read all rasters into a stack
rast_stack <- rast(bin_raster_files)

# Calculate mean across all layers
#rare_emphasis <- mean(rast_stack)
combined_raster=mean(rast_stack)

# Save the result if needed

# 
# # Load bin rasters
# bin_rasters <- lapply(bin_raster_files, rast)
zurich_boundary <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/zurich.shp")
# 
# # Rename rasters with 'sum' as name
# names(bin_rasters) <- paste("renamed_", seq_along(bin_rasters), sep = "")
# 
# # Define ratios with names corresponding to the bin rasters
# ratios <- c("renamed_1" = 1.369, "renamed_2" = 1.334, "renamed_3" = 1.264, "renamed_4" = 1.292, "renamed_5" = 1.470,
#             "renamed_6" = 1.415,"renamed_7" = 1.343, "renamed_8" = 1.283,
#             "renamed_9" = 1.345, "renamed_10" = 1.365, "renamed_11" = 1.656, "renamed_12" = 1.279, "renamed_13" = 1.230,
#             "renamed_14" = 1.534, "renamed_15" = 1.370, "renamed_16" = 1.331, "renamed_17" = 1.287, "renamed_18" = 1.278,
#             "renamed_19" = 1.503, "renamed_20" = 1.475, "renamed_21" = 1.143)
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# # Initialize the combined raster with zeros, matching the extent and CRS of the first bin raster
# combined_raster <- rast(nrow = nrow(bin_rasters[[1]]), ncol = ncol(bin_rasters[[1]]), ext = ext(bin_rasters[[1]]), crs = crs(bin_rasters[[1]]))
# values(combined_raster) <- 0
# 
# # Loop through each bin raster and apply the inverse ratios
# for (i in seq_along(bin_rasters)) {
#                current_raster <- bin_rasters[[i]]
#                current_ratio <- ratios[names(bin_rasters)[i]]
#                # Apply the inverse ratio directly to the raster values
#                combined_raster <- combined_raster + (current_raster / current_ratio)
# }
# 
# # Calculate the sum of inverse ratios
# sum_inverse_ratios <- sum(1 / ratios)
# 
# # Normalize the combined raster by dividing by the sum of inverse ratios
# combined_raster <- combined_raster / sum_inverse_ratios
# 
# # Calculate the mean of all bin rasters
# mean_rasters <- sum(rast(bin_rasters)) / length(bin_rasters)
# 
# # Combine the normalized combined raster with the mean raster
# combined_raster <- combined_raster * mean_rasters
# # # Convert the combined raster to a vector and sort to get top cells
# # flattened_combined_values <- as.vector(combined_raster)
# # sorted_indices <- order(flattened_combined_values, decreasing = TRUE)
# # 
# # # Assume each cell represents 625 square meters
# # cell_area <- 625
# # total_area_needed <- 2000 * 10000 # in square meters
# # num_cells_needed <- round(total_area_needed / cell_area)
# # 
# # # Select the top cells
# # selected_cells <- sorted_indices[1:num_cells_needed]
# # # Initialize the selected cells raster with zeros
# # selected_raster <- rast(nrow=nrow(combined_raster), ncol=ncol(combined_raster), ext=ext(combined_raster), crs=crs(combined_raster))
# # values(selected_raster) <- 0
# 
# # Set the values of the selected cells to 1
# values(selected_raster)[selected_cells] <- 1
zurich_boundary=project(zurich_boundary, "epsg:21781")

# Crop and mask the raster to the Zurich boundary
cropped_raster <- crop(combined_raster, ext(zurich_boundary))
masked_raster <- mask(cropped_raster, zurich_boundary)

acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/acidic.tif" ) 
xt=ext(acidic)
# Load elevation
##water
Waterbodiess=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess = crop(Waterbodiess, xt)

#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)
# # # Define File name
#fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/conare.png"
# # # # 
# # # # # Define the colors representing shades of green, yellow, and orange
# # # # # Define the colors representing shades of green, yellow, and orange
# png(fln,width=30,height=40,unit="cm",res=300,pointsize=7.5)
# # # pdf(fln,width=10/2.54,height=6.54/2.54,useDingbats = F,pointsize=7.5)
# plot(masked_raster, col = c("ivory2", "red"), legend = FALSE, axes = FALSE, mar = c(0.1, 0.1, 0.1, 0.1))
# # Plot the masked raster with selected places in red
# # Plot the masked raster with selected places in red
# # plot(cut_raster1, col = colors(length(breaks) - 1), axes=F,legend = F,add = TRUE)
# plot(Waterbodiess, add = TRUE, 
#      col = c("darkblue", "#FFFFFF00"),  # White with alpha channel (transparent)
#      legend = FALSE, axes = FALSE)
# plot(tot,col ="tan",legend=F,axes=F, add=T)
# # Close PNG device
# dev.off()
# # Save the composite raster to a new file

fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/nc/R_con.png"
#fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/nc/R_Comp.png"

# # # 
# # # # Define the colors representing shades of green, yellow, and orange
# # # # Define the colors representing shades of green, yellow, and orange
# Specify breaks
breaks <- c(0, 33, 66, 100)  # 3 categories
png(fln,width=30,height=40,unit="cm",res=300,pointsize=7.5)
# Define breaks for low, medium, and high
palette <- c("#FDE0DD", "#D467A5", "#67001F") 

#palette <- brewer.pal(3, "RdPu")  # GnBu palette with 3 categories
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
