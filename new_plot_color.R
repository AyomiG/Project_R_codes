##indi_75C
rm(list = ls(all = TRUE))
library(geos)
library(RColorBrewer)
library(terra)
# Set the main directory path
parent_dir_data <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled"
#parent_dir_data <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled"
# Get a list of all subdirectories
parent_dir_sspa <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PAR_75/crs"
# Get a list of all subdirectories containing data files
rankmap_files <- list.files(parent_dir_data, pattern = ".tif", full.names = TRUE)
acidic <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map/acidic.tif") 
out_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_pn"
#out_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn"
#
cli <- c("#d0e3e7", "#6488C0", "#023858")
#Define color
# Generate colors from the palette
#wc=c("deepskyblue","deepskyblue")
wc = c("deepskyblue", "transparent")


#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)

##water
Waterbodiess <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess <- crop(Waterbodiess, ext(acidic))
# # Define File name
#fln = "C://Users//ogundipe//Documents//OneDrive - Eidg. Forschungsanstalt WSL//visua//new_data//Output_plotsF"
# Plot each rank map with the basename as the title
# Set the main directory paths
cantons  <-   vect("C:/Users/ogundipe/Downloads/swissboundaries3d_2019-01_2056_5728.shp/swissBOUNDARIES3D_1_5_TLM_KANTONSGEBIET.shp")  # Replace with your actual file path
cantons=terra::project(cantons, "epsg:21781")
zurich_canton <-  cantons[cantons$NAME == "Zürich", ]

# Loop through files
rankmap_files <- list.files(parent_dir_data, pattern = ".tif", full.names = TRUE)
for (data_file in rankmap_files) {
               data_figures <- gsub(".*?(\\d+_\\d+_\\d+).*", "\\1", data_file)
               ss_pa_files <- list.files(parent_dir_sspa, pattern = paste0(data_figures, ".tif"), full.names = TRUE)
               
               if (length(ss_pa_files) > 0) {
                              ss_pa <- rast(ss_pa_files[1])
                              ss_pa <- terra::project(ss_pa, acidic)
                              ss_pa <- resample(ss_pa, acidic, method = "bilinear")
                              ss_pa <- crop(ss_pa, ext(acidic))
                              
                              rankmap <- rast(data_file)
                              rankmap <- crop(rankmap, zurich_canton )
                              rankmap<- mask(rankmap, zurich_canton)
                              
                              
                              # Classify values into Low (0-33), Medium (34-66), High (67-100)
                              rankmap <- classify(rankmap, cbind(c(1, 34, 67), c(33, 66, 100)))
                              
                              
                             # png(file.path(out_dir, paste0(data_figures, ".png")), width = 30, height = 40, unit = "cm", res = 600, pointsize = 7.5)
                              png(file.path(out_dir, paste0(data_figures, ".png")), width = 30, height = 40, unit = "cm", res = 600, pointsize = 7.5)
                              
                              plot(rankmap, col = cli, legend = FALSE, axes = FALSE, asp = 1)
                              plot(tot, col = "#AAA508", legend = FALSE, axes = FALSE, add = TRUE)
                              plot(ss_pa, col = "red", legend = FALSE, axes = FALSE, add = TRUE)
                              plot(Waterbodiess, col = wc, legend = FALSE, axes = FALSE, add = TRUE)
                              
                              dev.off()
               } else {
                              cat("No corresponding ss_pa file found for:", data_file, "\n")
               }
}