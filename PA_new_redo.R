#
#
rm(list = ls(all = TRUE))
library(sf)
library(terra)
library(raster)
#read the PA_shapefile(shp)
#shp = st_read("R:\\brunp\\shared\\oei_betrieb.gpkg")
shp = st_read("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\oei_betrieb.gpkg")
# transform to spatVector in Terra
tshp = terra::vect(shp)
# writeVector(tshp, filename = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA.shp")
# filter out all PAs with no area of very low area
spatvector_sub <- tshp[tshp$ha >= 0.0025, ]
spatvector_sub$ID = NULL
spatvector_sub$IDproper = 1:nrow(spatvector_sub)
# writeVector(spatvector_sub, filename = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA_.shp")
raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_dv", pattern = "*.tif")
# Define empty lists to store mean values and relevant PAs
mean_sm_values <- list()
relev_pas_list <- list()
mean_mean_sm_values <- list()
# mean_mean_sm_avg <- mean(unlist(mean_mean_sm_values))
# Iterate through the raster files and perform the operations
for (raster_file in raster_files) {
               # Read the raster file
               sm <- rast(paste0("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_dv/", raster_files[1]))
               # Set the coordinate reference system of the raster to match the spatial vector
               crs(sm) = crs(spatvector_sub)
               # Extract the suitability values from the SDMs for the PA
               suitability_score <- terra::extract(sm, spatvector_sub)
               # Calculate the mean suitability score for each PA in the raster
               poly_avg = aggregate(list(Mean_SM = suitability_score$sum),
               by = list(ID = suitability_score$ID),
               FUN = "mean", na.rm = TRUE)
               # Extract the Mean_SM column from poly_avg
               # mean_sm_values_nona <- unlist(na.omit(poly_avg$Mean_SM))
               # Calculate percentiles
               p50 <- quantile(poly_avg$Mean_SM, 0.50, na.rm = TRUE)
               p75 <- quantile(poly_avg$Mean_SM, 0.75, na.rm = TRUE)
               # Store the mean values in the list
               mean_sm_values[[basename(raster_file)]] <- poly_avg
               # Calculate the average mean suitability score across all iterations
               mean_mean_sm_values[[basename(raster_file)]] <- mean(poly_avg$Mean_SM, na.rm = TRUE)
               # Calculate the overall mean of all the sums of mean_mean_sm_values
               overall_mean <- mean(unlist(mean_mean_sm_values), na.rm = TRUE)
               
               # # Subset pavg based on the overall mean
               # pavg_subset <- pavg[pavg$mean_mean_sm_value > overall_mean, ]
               # 
               # Subset for relevant PAs based on p50
               mtch = match(spatvector_sub$IDproper, poly_avg$ID)
               relev_pas_p50 <- spatvector_sub[which(poly_avg$Mean_SM[mtch] > p50),]
               relev_pas_list[[basename(raster_file)]] <- relev_pas_p50
               # Save the relevant PAs as separate spatvector files
               # Save the relevant PAs as separate spatvector files
               output_filename <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p50n/", paste(basename(raster_file), ".shp", sep = ""))
               writeVector(relev_pas_p50, filename = output_filename)
               # Subset for relevant PAs based on p75
               relev_pas_p75 <- spatvector_sub[which(poly_avg$Mean_SM[mtch] > p75),]
               relev_pas_list[[paste0(basename(raster_file), "_p75")]] <- relev_pas_p75
               # Save the relevant PAs as separate spatvector files
               output_filename2 <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75n/", paste(basename(raster_file), ".shp", sep = ""))
               writeVector(relev_pas_p75, filename = output_filename2)
               # Subset for relevant PAs based on p75
               # Subset for relevant PAs based on p75
               relev_pas_avg <- spatvector_sub[which(poly_avg$Mean_SM[mtch] > overall_mean),]
               relev_pas_list[[paste0(basename(raster_file),"_avg")]] <- relev_pas_avg
               # Save the relevant PAs as separate spatvector files
               output_filename3 <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/pavgn/", paste(basename(raster_file), ".shp", sep = ""))
               writeVector(relev_pas_avg, filename = output_filename3)

               
  }
