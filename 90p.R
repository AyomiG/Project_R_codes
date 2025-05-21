#
#
rm(list = ls(all = TRUE))
library(sf)
library(terra)
library(raster)
#read the PA_shapefile(shp)

shp = st_read("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\oei_betrieb.gpkg")
# transform to spatVector in Terra
tshp = terra::vect(shp)
# writeVector(tshp, filename = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA.shp")
# filter out all PAs with no area of very low area
spatvector_sub <- tshp[tshp$ha >= 0.0025, ]
spatvector_sub$ID = NULL
spatvector_sub$IDproper = 1:nrow(spatvector_sub)
# # writeVector(spatvector_sub, filename = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/PA_.shp")
raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_dv", pattern = "*.tif")
# Define empty lists to store mean values and relevant PAs
mean_sm_values <- list()
relev_pas_list <- list()
mean_mean_sm_values <- list()

# Iterate through the raster files and perform the operations
for (raster_file in raster_files) {
               # Read the raster file
               sm <- rast(paste0("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_dv/", raster_file))
               # Set the coordinate reference system of the raster to match the spatial vector
               crs(sm) <- crs(spatvector_sub)
               # Extract the suitability values from the SDMs for the PA
               suitability_score <- terra::extract(sm, spatvector_sub)
               # Calculate the mean suitability score for each PA in the raster
               poly_avg <- aggregate(list(Mean_SM = suitability_score$sum),
                                     by = list(ID = suitability_score$ID),
                                     FUN = "mean", na.rm = TRUE)
               # Extract the Mean_SM column from poly_avg
               mean_sm_values_nona <- unlist((poly_avg$Mean_SM))
               p90 <- quantile(mean_sm_values_nona, 0.90,na.rm = TRUE)
               # Store the mean values in the list
               mean_sm_values[[basename(raster_file)]] <- mean_sm_values_nona
               # Calculate the average mean suitability score across all iterations
               mean_mean_sm_value <- mean((mean_sm_values_nona), na.rm = TRUE)
               mean_mean_sm_values[[basename(raster_file)]] <- mean_mean_sm_value
               # Subset for relevant PAs based on p50
               relev_pas_p90 <- spatvector_sub[mean_sm_values_nona > p90,]
               relev_pas_list[[basename(raster_file)]] <- relev_pas_p90

               output_filename <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p90/", paste(basename(raster_file), ".shp", sep = ""))
               writeVector(relev_pas_p90, filename = output_filename,overwrite=T)
               # output_filename2 <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75n/", paste(basename(raster_file), ".shp", sep = ""))
               # writeVector(relev_pas_p75, filename = output_filename2,overwrite=T)
}
