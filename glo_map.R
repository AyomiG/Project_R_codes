# Load required libraries
library(geos)
library(RColorBrewer)
library(terra)

# Set the directory paths and load the required files
parent_dir_data <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked18/scaled"
ss_pa <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/CPA.tif")
rankmap_files <- list.files(parent_dir_data, pattern = ".tif", full.names = TRUE)
acidic <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map/acidic.tif")
out_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_p_glo"

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

# Define color
cli <- brewer.pal(9, "BuGn")
clsi <- colorRampPalette(cli)(141)

et <- brewer.pal(9, "PuOr")
etc <- colorRampPalette(et)(141)

wc <- c("darkblue", "skyblue")

# Total current PA
tot <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot <- terra::project(tot, acidic)
tot <- rasterize(tot, acidic)

# Water bodies
Waterbodiess <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess <- crop(Waterbodiess, ext(acidic))

# Load ss_pa file once
terra::crs(ss_pa) <- "EPSG:2056"
ss_pa <- terra::project(ss_pa, acidic)
ss_pa <- resample(ss_pa, acidic, method = "bilinear")
ss_pa <- crop(ss_pa, ext(acidic))

# Loop over each data file
for (data_file in rankmap_files) {
               # Load the data file
               rankmap <- rast(data_file)
               rankmap <- terra::project(rankmap, acidic)
               
               # Extract the figures from the filename
               data_figures <- gsub(".*?(\\d+_\\d+_\\d+).*", "\\1", data_file)
               
               # Set up plot parameters
               png(file.path(out_dir, paste0(data_figures, ".png")), width = 30, height = 40, unit = "cm", res = 300, pointsize = 7.5)
               
               # Plot the rank map
               plot(rankmap, col = clsi, legend = FALSE, axes = FALSE, asp = 1)
               plot(tot, col = "yellow3", legend = FALSE, axes = FALSE, add = TRUE)
               plot(ss_pa, col = "red", legend = FALSE, axes = FALSE, add = TRUE)
               plot(Waterbodiess, col = wc, legend = FALSE, axes = FALSE, add = TRUE)
               plot(hillsh, bty = "n", legend = FALSE, axes = FALSE, col = rev(hillcol(50)), maxcell = 1e8, add = TRUE)
               contour(crop(telev, ext(acidic)), add = TRUE, maxcells = 1e8, drawlabels = FALSE, col = "grey20", lwd = 0.5, levels = 0:30 * 100)
               
               dev.off()
}
?wsl.plot
