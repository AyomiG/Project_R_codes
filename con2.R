#Connectivity 2


# Set the path to the main directory containing the 24 folders
main_dir <- "R:/poppman/shared/dami/out"
out_f="C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files"

# Get the list of subdirectories in the main directory
sub_dirs <- list.dirs(main_dir, full.names = TRUE, recursive = FALSE)

# # Loop through each subdirectory
# for (sub_dir in sub_dirs) {
#                # Get the folder name
#                folder_name <- basename(sub_dir)
#                
#                # Construct the file path to Mean_delta_H.tif
#                file_path <- file.path(sub_dir, "Mean_delta_H.tif")
#                
#                # Read the file
#                raster_data <- terra::::rast(file_path)
#                
#                # Save the file with a new name based on the folder name
#                new_file_name <- paste0(folder_name, "_Mean_delta_H.tif")
#                new_file_path <- file.path(out_f, new_file_name)
#                writeRaster(raster_data, filename = new_file_path, overwrite = TRUE)
# }

new_file_path

library(terra)

# Define the folder containing the "con" files
folder_path <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files"
o_path <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled"
# Get the list of "con" files in the folder
con_files <- list.files(folder_path, pattern = "\\.tif$", full.names = TRUE)
# Define the corresponding "comp" file
comp_file <-"C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/1_1_1.tif"

# Loop through each "con" file
for (con_file in con_files) {
               # Read the "con" raster
               con <- rast(con_file)
               con<- project(con, "epsg:21781")
               # Read the "comp" raster
               comp <- rast(comp_file)
               
               # Resample "Con" raster to match the extent of "comp"
               con <- resample(con, comp, method = "bilinear")
               
               # Scaling operation
               ac_q <- quantile(values(con), probs = seq(0, 1, 0.01), na.rm = TRUE)
               # Add a small jitter to ensure uniqueness in breaks
               ac_q <- ac_q + runif(length(ac_q), -1e-10, 1e-10)
               vls_sc <- cut(values(con), breaks = ac_q)
               vls_sc <- as.numeric(vls_sc)
               resc_map <- con
               values(con) <- vls_sc
               
               # Define the output file path
               output_file <- file.path(o_path,basename(con_file))
               
               # Save the rescaled "con" raster
               writeRaster(con, filename = output_file, overwrite = TRUE)
}
con
