#grouped combine


# load required packages
rm(list = ls(all = TRUE))
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <-  "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\masked_areas\\masked_7518\\scaled"
parent_dir_data <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results"
#parent_dir <- "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\masked_areas\\glo_masked18\\scaled"
#parent_dir <- "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\masked_areas\\avg_masked18\\scaled"

# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
# rankmap_files <- list.files(parent_dir,  pattern = "scaled75_", full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = ".tif", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("1_[0-9]_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "acidic.tif")
writeRaster(mean_raster , output,overwrite=TRUE)

selected_files=rankmap_files[grep("3_[0-9]_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "alkaline.tif")
writeRaster(mean_raster , output,overwrite=TRUE)










##Elevation
selected_files <- rankmap_files[grep("[0-9]_1_[0-9]", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "lowE.tif")
writeRaster(mean_raster , output,overwrite=TRUE)



selected_files <- rankmap_files[grep("[0-9]_2_[0-9]", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "modE.tif")
writeRaster(mean_raster , output,overwrite=TRUE)

#humid
# Set the path to the parent directory

selected_files <- rankmap_files[grep("[0-9]_[0-9]_2", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "moist.tif")
writeRaster(mean_raster , output,overwrite=TRUE)


selected_files <- rankmap_files[grep("[0-9]_[0-9]_4", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "dry.tif")
writeRaster(mean_raster , output,overwrite=TRUE)




##Differences
Dif=list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", full.names = T)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/dry.tif" )    
m_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/modE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/moist.tif")


PH=acidic-alkaline
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "Dif_PH.tif")
writeRaster(PH, output,overwrite=TRUE)

Ele=m_ele-l_ele
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "Dif_Ele.tif")
writeRaster(Ele , output,overwrite=TRUE)

humidity=moist-dry
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518", "Dif_Hum.tif")
writeRaster(humidity , output,overwrite=TRUE)





















