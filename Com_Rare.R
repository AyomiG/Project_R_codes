rm(list = ls(all = TRUE))

library(terra)

# # startegy focus common
# raster1 <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/ComplimentarityC.tif")
# raster2 <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/ConnectivityC.tif")
# 

# # # startegy focus rare
#  raster1=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/CompRare.tif")
# raster2 =rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/ConRare.tif")
# # # 
# startegy focus complimentarity difference
# raster1<- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/ComplimentarityC.tif")
# raster2=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/CompRare.tif")

# # # 
# # startegy focus connectivity difference
raster1<- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/ConnectivityC.tif")
raster2=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/ConRare.tif")


# Load your study area boundary vector (replace with your actual path)
zurich_boundary <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/zurich.shp")
zurich_boundary <- project(zurich_boundary, "epsg:21781")

acidic <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/acidic.tif")
xt <- ext(acidic)

# Create a new raster for the composite within the study area
composite_raster <- rast(raster1)

# Assign values based on conditions within the study area
values(composite_raster) <- 0
values(composite_raster)[values(raster1) > 0 & values(raster2) == 0] <- 1  # Unique to raster1
values(composite_raster)[values(raster1) > 0 & values(raster2) > 0] <- 2   # Overlap
values(composite_raster)[values(raster1) == 0 & values(raster2) > 0] <- 3  # Unique to raster2

# Set all other values to 0 (which will be colored white)
values(composite_raster)[!values(composite_raster) %in% c(1, 2, 3)] <- 0

# Crop and mask the raster to the Zurich boundary
cropped_raster <- crop(composite_raster, ext(zurich_boundary))
composite_raster <- mask(cropped_raster, zurich_boundary)

# Load additional data
Waterbodiess <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess <- crop(Waterbodiess, xt)

tot <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot <- project(tot, acidic)
tot <- rasterize(tot, acidic)

# Define File name
fln = fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/connD.png"
png(fln,width=30,height=40,unit="cm",res=300,pointsize=7.5)
# Define color palette for plotting, adding white for 0
colors <- c("grey", 'purple','yellow','green')
# Plot the composite raster with different colors without legend and labels
plot(composite_raster, col = colors, axes = FALSE, legend = FALSE)



# #plot(Diff1, col = c("purple","lightgray", "yellow"), axes = FALSE, legend = FALSE)
plot(Waterbodiess, add = TRUE,
     col = c("darkblue", "#FFFFFF00"),  # White with alpha channel (transparent)
     legend = FALSE, axes = FALSE)

dev.off()



# 
# et= c("green4","ivory2","orange")
# plot(Diff, col =et, axes = FALSE, legend = FALSE)
# plot(Diff, col =et, axes = FALSE, legend = FALSE,add=T)
# plot(Waterbodiess, col = "blue1", legend = FALSE, axes = FALSE, add = TRUE)
# plot(tot, col = "wheat3", legend = FALSE, axes = FALSE, add = TRUE)
# 
