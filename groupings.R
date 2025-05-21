# load required packages
rm(list = ls(all = TRUE))
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas"

# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = "scaled75_", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("scaled75_3", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75", "alkaline.tif")
writeRaster(mean_raster , output)




               

##Elevation
selected_files <- rankmap_files[grep("scaled75_[0-9]_3", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75", "HighE.tif")
writeRaster(mean_raster , output)

#humid
# Set the path to the parent directory
selected_files <- rankmap_files[grep("scaled75_[0-9]_[0-9]_4", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75", "dry.tif")
writeRaster(mean_raster , output)




##Differences
Dif=list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75", full.names = T)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75/dry.tif" )    
H_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75/HighE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75/moist.tif")


PH=acidic-alkaline
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75", "Dif_PH.tif")
writeRaster(PH, output)

Ele=H_ele-l_ele
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75", "Dif_Ele.tif")
writeRaster(Ele , output)

humidity=moist-dry
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75", "Dif_Hum.tif")
writeRaster(humidity , output)





















