library(terra)

# Load your raster datasets
raster1 <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/C_con.tif")
raster2 <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/R_con.tif")

# Load the Zurich boundary vector
zurich_boundary <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/zurich.shp")
zurich_boundary <- project(zurich_boundary, "epsg:21781")

# Create a new raster for the composite
composite_raster <- rast(raster1)
values(composite_raster) <- 0

# Assign values based on conditions
values(composite_raster)[values(raster1) > 0 & values(raster2) == 0] <- 1  # Unique to raster1
values(composite_raster)[values(raster1) > 0 & values(raster2) > 0] <- 2   # Overlap
values(composite_raster)[values(raster1) == 0 & values(raster2) > 0] <- 3  # Unique to raster2

# Crop and mask the composite raster to the Zurich boundary
cropped_raster <- crop(composite_raster, ext(zurich_boundary))
composite_raster <- mask(cropped_raster, zurich_boundary)

# Load additional data
Waterbodiess <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess <- crop(Waterbodiess, ext(composite_raster))

# Define the output file name
output_file <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Diff_con.tif"

# Create the plot
png(output_file, width = 30, height = 40, unit = "cm", res = 300, pointsize = 7.5)

# Define the color palette
colors <- c("white", "purple", "yellow", "green")

# Plot the composite raster with the defined colors
plot(composite_raster, col = colors, axes = FALSE, legend = FALSE)
plot(Waterbodiess, add = TRUE, col = c("darkblue", "#FFFFFF00"), legend = FALSE, axes = FALSE)

# Add a legend
legend("topright", legend = c("Unique to Raster 1", "Overlap", "Unique to Raster 2", "Waterbodies"),
       fill = colors, bty = "n", cex = 0.8)

dev.off()