##grouping conn

# load required packages
rm(list = ls(all = TRUE))
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <-  "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled"
rankmap_files <- list.files(parent_dir,  pattern = ".tif", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("1_[0-9]_[0-9]", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "acidic.tif")
writeRaster(mean_raster , output,overwrite=TRUE)

selected_files=rankmap_files[grep("3_[0-9]_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "alkaline.tif")
writeRaster(mean_raster , output,overwrite=TRUE)





##Elevation
selected_files <- rankmap_files[grep("[0-9]_1_[0-9]", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "lowE.tif")
writeRaster(mean_raster , output,overwrite=TRUE)

selected_files <- rankmap_files[grep("[0-9]_2_[0-9]", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "modE.tif")
writeRaster(mean_raster , output,overwrite=TRUE)

#humid
# Set the path to the parent directory

selected_files <- rankmap_files[grep("[0-9]_[0-9]_2", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "moist.tif")
writeRaster(mean_raster , output,overwrite=TRUE)


selected_files <- rankmap_files[grep("[0-9]_[0-9]_4", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "dry.tif")
writeRaster(mean_raster , output,overwrite=TRUE)




##Differences
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/dry.tif" )    
m_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/modE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/moist.tif")


PH=acidic-alkaline
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "Dif_PH.tif")
writeRaster(PH, output,overwrite=TRUE)

Ele=m_ele-l_ele
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "Dif_Ele.tif")
writeRaster(Ele , output,overwrite=TRUE)

humidity=moist-dry
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp", "Dif_Hum.tif")
writeRaster(humidity , output,overwrite=TRUE)





















