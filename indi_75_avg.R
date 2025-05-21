# Set the main directory path
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/Output_with_postprocess"
pas_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75",pattern = ".shp", full.names = TRUE)

# Get a list of all subdirectories containing rank map files
rankmap_files <- list.files(parent_dir, recursive = TRUE, pattern = "rankmap.tif", full.names = TRUE)

# Specify the directory to save plots
plot_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Output_plots2/"

# Load the acidic raster
acidic <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map/acidic.tif")

# Define Zurich canton
cantons <- vect("C:/Users/ogundipe/Downloads/swissboundaries3d_2019-01_2056_5728.shp/swissBOUNDARIES3D_1_5_TLM_KANTONSGEBIET.shp")
cantons = project(cantons, "epsg:21781")
zurich_canton <- cantons[cantons$NAME == "Zürich", ] 
zurich_canton <- crop(zurich_canton, ext(acidic))
zurich_canton_raster <- rasterize(zurich_canton, acidic, field = "NAME")

##water
Waterbodiess <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess <- crop(Waterbodiess, ext(acidic))

#Define color
# cli = brewer.pal(9,"YlOrRd")
cli = brewer.pal(9,"BuGn")
clsi = colorRampPalette(cli)(50)

et=brewer.pal(9,"PuOr")
etc<- colorRampPalette(et)(50)
# Generate colors from the palette
wc=c("darkblue","skyblue")



# Plot each rankmap with the corresponding pas
for (file in rankmap_files) {
               # Extract the number from the rankmap file path
               number <- gsub(".*\\/(\\d+_\\d+_\\d+)\\/.*", "\\1", file)
               
               # Find the corresponding pas file
               corresponding_pas <- grep(number, pas_files, value = TRUE)
               
               # Check if a corresponding pas file was found
               if (length(corresponding_pas) > 0) {
                              # Load and preprocess the rank map
                              rankmap <- rast(file)
                              rankmap <- terra::project(rankmap, acidic)
                              rankmap <- crop(rankmap, ext(zurich_canton))
                              
                              # Mask rank map with Zurich canton
                              rankmap <- mask(rankmap, zurich_canton_raster)
                              
                              # Load and preprocess the corresponding pas
                              pas <- vect(corresponding_pas)
                              pas <- terra::project(pas, acidic)
                              pas <- rasterize(pas, acidic)
                              pas <- crop(pas, ext(acidic))
                              
                              # Plotting code for rankmap and pas
                              png(paste0(plot_dir, number, ".png"))  # Save plot with number as filename
                              # Plot the rank map
                              plot(rankmap, col = clsi, legend = FALSE, axes = FALSE, main = number)
                              plot(pas, col = "red", legend = FALSE, axes = FALSE, add = TRUE)
                              plot(Waterbodiess, col = wc, legend = FALSE, axes = FALSE, add = TRUE)
                              plot(hillsh, bty = "n", legend = FALSE, axes = FALSE, col = rev(hillcol(50)), maxcell = 1e8, add = TRUE)
                              contour(crop(telev, ext(acidic)), add = TRUE, maxcells = 1e8, drawlabels = FALSE, col = "grey20", lwd = 0.5, levels = 0:30 * 100)
                              
                              dev.off()
               } else {
                              # Print a message if no corresponding pas file was found
                              cat("No corresponding pas file found for rankmap", file, "\n")
               }
}
