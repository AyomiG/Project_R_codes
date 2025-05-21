# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
                           pattern = "*.tif", full.names = TRUE)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
filtered_data2$Filename =NA
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)

# raster_list=list()
# 
# for (file in raster_files) {
#                image <- raster(file)
#                 raster_list[[file]] <- image
# }
# 
# # Load the raster package
# library(raster)
# 
# # Create a list of tiff images
# tiff_images <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",pattern = "*.tif")
# 
# # Search for the tiff images with the names "my_image.tif" and "your_image.tif"
# tiff_images <- grep("Chara", raster_list,value = TRUE)
# 
# tiff_images
# # Print the list of tiff images
# print(tiff_images)
# plot(tiff_images)
# plot.window()
# plot(tiff_images)

filename <- basename(raster_files)
selname  <- which(grepl("Chara", filename))
Chafile <- raster_files[selname]
Charasters <- terra::rast(Chafile)
# Sum the raster layers
sum_raster <- Charasters[[1]]+Charasters[[2]]+Charasters[[3]]+Charasters[[5]]

# Visualize the summed raster
plot(sum_raster)

filtered_data2
