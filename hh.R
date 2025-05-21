rm(list = ls(all = TRUE))

library(sf)
library(terra)
# Get a list of all of the raster files in the folder 
raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/bin_ras", pattern = "*.tif")
shp = st_read("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/oei_betrieb.gpkg")
# transform to spatVector(PA) in Terra
spatvector= terra::vect(shp)
# Save the SpatVector object to a file
# writeVector(spatvector, "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/PA.shp")
# Filter out all PAs with no area of very low area
# spatvector2 <- terra::vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/PA.shp")
spatvector_sub <- spatvector[spatvector$ha >= 0.0025, ]
# # Create an empty list to store the results for each type of 'sm'
# result_list <- list()
# percentiles50 <- list()
# percentiles75 <- list()
# 
# # Iterate through the raster files and perform the operations
# for (raster_file in raster_files) {
#                
#                # Read the raster file
#                sm <- rast(paste0("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/bin_ras/", raster_file))
#                
#                sp_l = read.csv(...)
#                sm_rel = sm/nrow(sp_l)
#                
#                crs(sm) = crs(spatvector_sub)
#                # Extract the suitability values from the SDMs for the PA
#                suitability_score <- terra::extract(sm, spatvector_sub)
#                
#                # Calculate the mean suitability score for each PA in the raster
#                poly_avg = aggregate(list(Mean_SM = suitability_score$sum),
#                                     by= list(ID = suitability_score$ID),
#                                     FUN = "mean", na.rm = TRUE)
#                
#                # Extract the Mean_SM column from poly_avg
#                mean_sm_values <- unlist(poly_avg$Mean_SM)
#                
#                # Remove all missing values from the vector
#                mean_sm_values_nona <- na.omit(mean_sm_values)
#                
#                # Calculate percentiles and create bins
#                p50 <- quantile(mean_sm_values_nona, 0.50) 
#                p75 <- quantile(mean_sm_values_nona, 0.75)
#                # bins <- c(min(mean_sm_values), p50, p75, max(mean_sm_values))
#                
#                # Store the results in the list
#                percentiles50[[basename(raster_file)]] <- quantile(p50)
#                percentiles75[[basename(raster_file)]] <- quantile(p75)
#                result_list[[basename(raster_file)]] <-  mean_sm_values
#                
#                # Subset for relevant PAs
#                relev_pas = spatvector_sub[mean_sm_values > p50,]
#                
# 
# }
# 
# 
# 
# library(terra)
# 
# # Load the raster data
# raster_data <- rast("raster_data.tif")
# 
# # Get a SpatRaster object with the NA values identified
# na_mask <- is.na(raster_data)
# 
# # Mask out the NA values in the raster object
# masked_raster <- raster_data * na_mask
# 
# # Save the masked raster
# writeRaster(masked_raster, "masked_raster.tif")
# 
# 



raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/bin_div", pattern = "*.tif")
# Define empty lists to store mean values and relevant PAs
mean_sm_values <- list()
relev_pas_list <- list()
mean_mean_sm_values <- list()
mean_mean_sm_avg <- mean(unlist(mean_mean_sm_values))

# Iterate through the raster files and perform the operations
for (raster_file in raster_files) {
               # Read the raster file
               sm <- rast(paste0("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/bin_div/", raster_file))
               
               # Set the coordinate reference system of the raster to match the spatial vector
               crs(sm) = crs(spatvector_sub)
               
               # Extract the suitability values from the SDMs for the PA
               suitability_score <- terra::extract(sm, spatvector_sub)
               
               # Calculate the mean suitability score for each PA in the raster
               poly_avg = aggregate(list(Mean_SM = suitability_score$sum),
                                    by = list(ID = suitability_score$ID),
                                    FUN = "mean", na.rm = TRUE)
               
               # Extract the Mean_SM column from poly_avg
               mean_sm_values_nona <- unlist(na.omit(poly_avg$Mean_SM))
               
               # Calculate percentiles
               p50 <- quantile(mean_sm_values_nona, 0.50)
               p75 <- quantile(mean_sm_values_nona, 0.75)
               
               # Store the mean values in the list
               mean_sm_values[[basename(raster_file)]] <- mean_sm_values_nona
               
               # Calculate the average mean suitability score across all iterations
               mean_mean_sm_value <- mean(unlist( mean_sm_values_nona))
               mean_mean_sm_values[[basename(raster_file)]] <- mean_mean_sm_value
               
               # Subset for relevant PAs based on p50
               relev_pas_p50 <- spatvector_sub[mean_sm_values_nona > p50,]
               relev_pas_list[[basename(raster_file)]] <- relev_pas_p50
               # Save the relevant PAs as separate spatvector files
               # Save the relevant PAs as separate spatvector files
               output_filename <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/p50/", paste(basename(raster_file), ".shp", sep = ""))
               writeVector(relev_pas_p50, filename = output_filename)
               
               # Subset for relevant PAs based on p75
               relev_pas_p75 <- spatvector_sub[mean_sm_values_nona > p75,]
               relev_pas_list[[paste0(basename(raster_file), "_p75")]] <- relev_pas_p75
               # Save the relevant PAs as separate spatvector files
               output_filename2 <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/p75/", paste(basename(raster_file), ".shp", sep = ""))
               writeVector(relev_pas_p75, filename = output_filename2)
               
               # Subset for relevant PAs based on p75
               # Subset for relevant PAs based on p75
               relev_pas_avg <- spatvector_sub[mean_sm_values_nona >  mean_mean_sm_value,]
               relev_pas_list[[paste0(basename(raster_file),"_avg")]] <- relev_pas_avg
               
               # Save the relevant PAs as separate spatvector files
               output_filename3 <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/pavg/", paste(basename(raster_file), ".shp", sep = ""))
               writeVector(relev_pas_avg, filename = output_filename3)

}
             
m=vect("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\p50\\result_1_1_1.tif.shp")
h=vect("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\p75\\result_1_1_1.tif.shp")
av=vect("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\pavg\\result_1_1_1.tif.shp")              
# Set up the layout for the plot
par(mfrow = c(3, 1))  # 1 row and 3 columns (adjust as needed)
plot(m)
plot(h)
plot(av)