# load required packages
rm(list = ls(all = TRUE))
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked"

# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = "scaledg_", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("scaledg_1", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked", "acidic.tif")
writeRaster(mean_raster , output)



# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = "scaledg_", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("scaledg_3", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked", "alkaline.tif")
writeRaster(mean_raster , output)




##Elevation
selected_files <- rankmap_files[grep("scaledg_[0-9]_3", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked", "HighE.tif")
writeRaster(mean_raster , output)


##Elevation
selected_files <- rankmap_files[grep("scaledg_[0-9]_1", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked", "lowE.tif")
writeRaster(mean_raster , output)


#humid
# Set the path to the parent directory
selected_files <- rankmap_files[grep("scaledg_[0-9]_[0-9]_4", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked", "dry.tif")
writeRaster(mean_raster , output)

#humid
# Set the path to the parent directory
selected_files <- rankmap_files[grep("scaledg_[0-9]_[0-9]_2", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked", "moist.tif")
writeRaster(mean_raster , output)


##Differences

acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked/dry.tif" )    
H_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked/HighE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas//avg_masked/moist.tif")


PH=acidic-alkaline
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked", "Dif_PH.tif")
writeRaster(PH, output)

Ele=H_ele-l_ele
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked", "Dif_Ele.tif")
writeRaster(Ele , output)

humidity=moist-dry
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked", "Dif_Hum.tif")
writeRaster(humidity , output)





















