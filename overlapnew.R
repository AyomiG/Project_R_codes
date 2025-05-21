# Load required packages
library(sf)
library(terra)

# Load each map as an sf object
map1 <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"
map2 <- list.files(map1, pattern =".shp" , full.names = TRUE)
selected_files=map2[grep("result_1",map2 )]
a=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_1_1.tif.shp")
b=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_1_2.tif.shp")
c=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_1_3.tif.shp")
d=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_1_4.tif.shp")
e=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_2_1.tif.shp")
f=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_2_2.tif.shp")
g=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_2_3.tif.shp")
h=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_2_4.tif.shp")
i=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_3_2.tif.shp")
j=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_3_3.tif.shp")
k=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75/result_1_3_4.tif.shp")

# Load each map as an sf object
map1 <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"
map2 <- list.files(map1, pattern =".shp" , full.names = TRUE)
selected_files=map2[grep("result_1",map2 )]
for (m in length(selected_files)){
               mv=vect(m)
               br=terra::project(mv,acidic)
               br_crp<- crop(br, ext(acidic))
               br_crp <- rasterize(br_crp, acidic, field = "Name")
}

#rasterization
rast_object=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map75/acidic.tif" ) 

br=terra::project(a,acidic)
br_crp<- crop(br, ext(acidic))
br_crp <- rasterize(br_crp, acidic)




library(sf)
library(terra)

# Load each map as an sf object
map1 <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"
map2 <- list.files(map1, pattern = ".shp", full.names = TRUE)
selected_files <- map2[grep("result_1", map2)]

library(sf)
library(terra)

# Load the raster layer
raster_file <- "path_to_your_raster_file.tif"
raster_layer <- rast(raster_file)

# Specify the output directory for saving rasterized files
output_dir <- "output_directory/"

# Load each map as an sf object
map1 <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"
map2 <- list.files(map1, pattern = ".shp", full.names = TRUE)
selected_files <- map2[grep("result_1", map2)]
for (m in selected_files) {
               # Read the current file
               mv <- vect(m)
               
               # Project the vector layer to match the projection of the raster layer
               mv_proj <- project(mv, rast_object)
               
               # Crop the raster layer to the extent of the vector layer
               raster_crp <- crop(mv_proj, ext(rast_object))
               
               # Rasterize the cropped raster layer using the vector layer
               rasterized <- rasterize(raster_crp,acidic)
               
               # Extract the numeric part from the basename of the file
               basename_num <- gsub("[^0-9_0-9_0-9]", "", basename(m))
               basename_num <- sub("_", "", basename_num, fixed = TRUE)
               
               # Save the resulting raster
               output_file <-file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/rast_acidic75/",paste0 ("ac_",basename_num, ".tif"))
               writeRaster(rasterized, output_file, overwrite = TRUE)
}

# Load each map as an sf object
map1 <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75"
map2 <- list.files(map1, pattern = ".shp", full.names = TRUE)
selected_files <- map2[grep("result_[0-9]_[0-9]_4", map2)]
for (m in selected_files) {
               # Read the current file
               mv <- vect(m)
               
               # Project the vector layer to match the projection of the raster layer
               mv_proj <- project(mv, acidic)
               
               # Crop the raster layer to the extent of the vector layer
               raster_crp <- crop(mv_proj, ext(acidic))
               
               # Rasterize the cropped raster layer using the vector layer
               rasterized <- rasterize(raster_crp,acidic, field = "Name")
               
               # Extract the numeric part from the basename of the file
               basename_num <- gsub("[^0-9_0-9_0-9]", "", basename(m))
               basename_num <- sub("_", "", basename_num, fixed = TRUE)
               
               # Save the resulting raster
               output_file <-file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/rast_hum75/",paste0 ("d_",basename_num, ".tif"))
               writeRaster(rasterized, output_file, overwrite = TRUE)
}








##avg50
# Load each map as an sf object
map1 <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/pavg"
map2 <- list.files(map1, pattern = ".shp", full.names = TRUE)
selected_files <- map2[grep("result_3", map2)]
for (m in selected_files) {
               # Read the current file
               mv <- vect(m)
               
               # Project the vector layer to match the projection of the raster layer
               mv_proj <- project(mv, acidic)
               
               # Crop the raster layer to the extent of the vector layer
               raster_crp <- crop(mv_proj, ext(acidic))
               
               # Rasterize the cropped raster layer using the vector layer
               rasterized <- rasterize(raster_crp,acidic, field = "Name")
               
               # Extract the numeric part from the basename of the file
               basename_num <- gsub("[^0-9_0-9_0-9]", "", basename(m))
               basename_num <- sub("_", "", basename_num, fixed = TRUE)
               
               # Save the resulting raster
               output_file <-file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/ras_acidicM/",paste0 ("AK_",basename_num, ".tif"))
               writeRaster(rasterized, output_file, overwrite = TRUE)
}


#eleavg

##avg50
# Load each map as an sf object
map1 <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/pavg"
map2 <- list.files(map1, pattern = ".shp", full.names = TRUE)
selected_files <- map2[grep("result_[0-9]_[0-9]_4", map2)]
for (m in selected_files) {
               # Read the current file
               mv <- vect(m)
               
               # Project the vector layer to match the projection of the raster layer
               mv_proj <- project(mv, acidic)
               
               # Crop the raster layer to the extent of the vector layer
               raster_crp <- crop(mv_proj, ext(acidic))
               
               # Rasterize the cropped raster layer using the vector layer
               rasterized <- rasterize(raster_crp,acidic, field = "Name")
               
               # Extract the numeric part from the basename of the file
               basename_num <- gsub("[^0-9_0-9_0-9]", "", basename(m))
               basename_num <- sub("_", "", basename_num, fixed = TRUE)
               
               # Save the resulting raster
               output_file <-file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/ras_eleM/",paste0 ("d_",basename_num, ".tif"))
               writeRaster(rasterized, output_file, overwrite = TRUE)
}

 