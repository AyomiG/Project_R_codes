# Remove all objects from the global environment
rm(list = ls(all = TRUE))
library(terra)
library(sf)
rastdata=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/bin_ras/2_2_1.tif")
tpa=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA_.shp")
r2 <- rasterize(tpa, rastdata)

# # Create an empty raster layer with the desired extent and resolution
# raster_layer <- rast(ext(tpa), res = 25)  # Adjust resolution as needed
# 
# # Rasterize the vector data onto the empty raster layer
# rasterized <- rasterize(tpa, raster_layer)
# 
# # Plot the rasterized layer
# plot(rasterized)
# 

# pa <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA.shp")
# r3<- rasterize(pa, rastdata)
#Get a list of shapefiles in the folder:
shapefiles <- list.files("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\p75", pattern ="*.shp", full.names = T)
# Rasterize and save each shapefile as a separate raster file
for (shapefile in shapefiles) {
               shp <- vect(shapefile)
               r <- rasterize(shp, rastdata)
               
               # Extracting the desired part of the basename
               base_name <- gsub("\\.shp$", "", basename(shapefile))
               base_name <- gsub("^result_", "", base_name)
               
               output_file <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AR_75", paste0(base_name, ".tif"))
               writeRaster(r, filename = output_file, overwrite = TRUE)
}


#Get a list of shapefiles in the folder:avg
shapefiles1 <- list.files("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\pavg", pattern ="*.shp", full.names = T)
# Rasterize and save each shapefile as a separate raster file
for (shapefil in shapefiles1) {
               shp1 <- vect(shapefil)
               r1 <- rasterize(shp1, rastdata)
               
               # Extracting the desired part of the basename
               base_name1 <- gsub("\\.shp$", "", basename(shapefil))
               base_name1 <- gsub("^result_", "", base_name1)
               
               output_file2 <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AR_avg", paste0(base_name1, ".tif"))
               writeRaster(r1, filename = output_file2, overwrite = TRUE)
}


# Create a list of RPA file paths
rpa_file_paths <- list.files("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\AR_avg\\", pattern = "\\.tif$")

# Rasterize the Abax.ovalis map
rst <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current/Acer pseudoplatanus_zh.tif")
rst[!is.na(rst)] = 0

# Loop through the RPA file paths and perform the operation
for (rpa_file_path in rpa_file_paths) {
               # Read the RPA file
               rpa <- rast("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\AR_avg\\1_1_1.tif.tif")
               rpa[is.na(rpa)] = 0
               
                       
               # Calculate the sum of the rasters
               sm = rst + rpa
               
               # Save the result
               out_path = paste0("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\AI_avg\\",rpa_file_path, ".tif")
               writeRaster(sm, out_path, overwrite = TRUE, datatype = "INT4S")
}




rpa_file_paths <- list.files("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\AR_75\\", pattern = "\\.tif$")

# Rasterize the Abax.ovalis map
# rst <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current/Acer pseudoplatanus_zh.tif")
rst[!is.na(rst)] = 0

# Loop through the RPA file paths and perform the operation
for (rpa_file_path in rpa_file_paths) {
               # Read the RPA file
               rpa <- rast(paste0("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\AR_75\\", rpa_file_path))
               rpa[is.na(rpa)] = 0
               
               # Calculate the sum of the rasters
               sm = rst + rpa
               
               # Save the result
               out_path = paste0("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\AI_75\\",rpa_file_path, ".tif")
               writeRaster(sm, out_path, overwrite = TRUE, datatype = "INT4S")
}

#totalpa
rst <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current/Acer pseudoplatanus_zh.tif")
rst[!is.na(rst)] = 0
r2[is.na(r2)] = 0
# Calculate the sum of the rasters
sm = rst + r2
out_path = paste0("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\","CPA", ".tif")
writeRaster(sm, out_path, overwrite = TRUE, datatype = "INT4S")

#totalpaall
rst <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current/Acer pseudoplatanus_zh.tif")
rst[!is.na(rst)] = 0
r3[is.na(r3)] = 0
# Calculate the sum of the rasters
sm = rst + r3







# Load the raster
#H <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/CPA.tif")
# Count the number of cells with value 1
count_value_1 <- sum(values(r3) == 1, na.rm = TRUE)

# Count the total number of cells
total_cells <- ncell(r3)

# Calculate the percentage
percentage_covered <- (count_value_1 / total_cells) * 100

# Print the result
cat("Percentage of area covered by value 1:", percentage_covered, "%\n")
#3.323692 %
#3.329515 %




hh=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/current/Cucubalus baccifer_zh.tif")
plot(hh)






