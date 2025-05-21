rm(list = ls(all = TRUE))
library(rgeos)
library(RColorBrewer)
library(terra)
# Set the main directory path
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/Output_global_with_postprocess"

# Get a list of all subdirectories
rankmap_files <- list.files(parent_dir, recursive = TRUE, pattern = "rankmap.tif", full.names = TRUE)
plot_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Output_plots/"
acidic <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map/acidic.tif") 

# Load elevation
elev <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Elevation_25.tif")
elev <- terra::project(elev, acidic)
elev <- resample(elev, acidic, method = "bilinear")
telev <- crop(elev, ext(acidic))
telev <- mask(telev, acidic)

# Prepare hillshade
slp <- terrain(telev, v = "slope", unit = "radians")
asp <- terrain(telev, v = "aspect", unit = "radians")
hillshd <- shade(slp, asp, direction = 315)
hill_resampled <- resample(hillshd, acidic, method = "bilinear")
hillsh <- crop(hill_resampled, ext(acidic))
hillsh <- mask(hillsh, acidic)
hillcol <- colorRampPalette(c("#00000000", "#000000DA"), alpha = TRUE)

#Define color
# cli = brewer.pal(9,"YlOrRd")
cli = brewer.pal(9,"BuGn")
clsi = colorRampPalette(cli)(50)

et=brewer.pal(9,"PuOr")
etc<- colorRampPalette(et)(50)
# Generate colors from the palette
wc=c("darkblue","skyblue")


# current pa
pas <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
pas <- terra::project(pas, acidic)
pas <- rasterize(pas, acidic)
ss_pa <- crop(pas, ext(acidic))

##water
Waterbodiess <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess <- crop(Waterbodiess, ext(acidic))

# Define Zurich canton
cantons <- vect("C:/Users/ogundipe/Downloads/swissboundaries3d_2019-01_2056_5728.shp/swissBOUNDARIES3D_1_5_TLM_KANTONSGEBIET.shp")
cantons=project(cantons, "epsg:21781")
zurich_canton <- cantons[cantons$NAME == "Zürich", ] 
zurich_canton =crop(zurich_canton,ext(acidic))
zurich_canton_raster <- rasterize(zurich_canton, acidic, field = "NAME")

# Plot each rank map with the basename as the title
for (file in rankmap_files) {
               # Extract the number from the directory path
               # basename <- basename(dirname(file))
               number <- gsub(".*?/(\\d+_\\d+_\\d+)/.*", "\\1", file)
               
               # Load and preprocess the rank map
               rankmap <- rast(file)
               rankmap <- terra::project(rankmap, acidic)
               rankmap <- crop(rankmap, ext(zurich_canton))
               
               # Mask rank map with Zurich canton
               rankmap <- mask(rankmap, zurich_canton_raster)
               
               
               # Set up plot parameters
               png(paste0(plot_dir, number, ".png"), width = 17, height = 30, unit = "cm", res = 300, pointsize = 7.5)
               
               # Plot the rank map
               plot(rankmap, col = clsi, legend = FALSE, axes = FALSE, main = number)
               plot(ss_pa, col = "red", legend = FALSE, axes = FALSE, add = TRUE)
               plot(Waterbodiess, col = wc, legend = FALSE, axes = FALSE, add = TRUE)
               plot(hillsh, bty = "n", legend = FALSE, axes = FALSE, col = rev(hillcol(50)), maxcell = 1e8, add = TRUE)
               contour(crop(telev, ext(acidic)), add = TRUE, maxcells = 1e8, drawlabels = FALSE, col = "grey20", lwd = 0.5, levels = 0:30 * 100)

               dev.off()
}
