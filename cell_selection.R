# library(terra)
# 
# # Load the rasters
# species_richness <- rast("species_richness.tif")
# habitat_complimentarity <- rast("habitat_complimentarity.tif")
# con <- rast("connectivity.tif")
# 
# # Handle NA values in each raster
# species_richness[is.na(species_richness)] <- 0
# habitat_complimentarity[is.na(habitat_complimentarity)] <- 0
# con[is.na(con)] <- 0
# 
# # Example weights (adjust as needed)
# weights <- c(0.2, 0.7, 0.1)
# 
# # Calculate weighted scores
# weighted_scores <- species_richness * weights[1] + habitat_complimentarity * weights[2] + con * weights[3]
# 
# # Handle NA values in the weighted scores
# weighted_scores[is.na(weighted_scores)] <- 0
# 
# # Extract cell values from the weighted scores raster
# values_weighted <- values(weighted_scores)
# 
# # Handle NA values by setting them to a very low score
# values_weighted[is.na(values_weighted)] <- -Inf
# 
# # Create a data frame with cell IDs and scores
# df_weighted <- data.frame(id = 1:length(values_weighted), score = values_weighted)
# 
# # Ensure the score column is numeric
# df_weighted$score <- as.numeric(df_weighted$score)
# 
# # Calculate the area of each cell
# cell_area <- 25 * 25  # Area of each cell in square meters
# total_area_needed <- 2000 * 10000  # Total area needed in square meters
# num_cells_needed <- total_area_needed / cell_area
# 
# # Rank cells and select the top cells
# top_cells <- df_weighted[order(-df_weighted$score), ][1:num_cells_needed, ]
# 
# # Verify the number of selected cells
# num_selected_cells <- nrow(top_cells)
# cat("Number of selected cells:", num_selected_cells, "\n")
# cat("Total area covered by selected cells (in hectares):", (num_selected_cells * cell_area) / 10000, "\n")
# 
# # Function to create a selection raster
# create_selection_raster <- function(raster_template, top_cells) {
#                selection_raster <- raster_template
#                values(selection_raster) <- NA
#                values(selection_raster)[top_cells$id] <- 1  # Mark selected cells
#                return(selection_raster)
# }
# 
# # Create selection raster
# selection_raster <- create_selection_raster(weighted_scores, top_cells)
# 
# # Plot the selection raster
# plot(selection_raster, main="Selected Areas")
# 
# # Save the selection raster to a file
# writeRaster(selection_raster, "selection.tif", overwrite=TRUE)
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 


rm(list = ls(all = TRUE))
library(terra)
# Define the file paths for each set of rasters
species_richness_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/sm_bins/spp_cant/scaled/skale", pattern = "*.tif", full.names = TRUE)
habitat_complementarity_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled", pattern = "*.tif", full.names = TRUE)
connectivity_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled", pattern = "*.tif", full.names = TRUE)

# Initialize an empty list to store the weighted scores for each raster
weighted_scores_list <- list()

# Example weights (adjust as needed)
weights <- c(0.8, 0.1, 0.1)

# Iterate over the species richness files
for (species_file in species_richness_files) {
               # Extract the base file name (without extension)
               species_base_name <- tools::file_path_sans_ext(basename(species_file))
               
               # Find corresponding files for habitat complementarity and connectivity
               habitat_file <- habitat_complementarity_files[grep(species_base_name, habitat_complementarity_files)]
               connectivity_file <- connectivity_files[grep(species_base_name, connectivity_files)]
               
               # Check if corresponding files were found
               if (length(habitat_file) == 1 && length(connectivity_file) == 1) {
                              # Load the rasters
                              species_richness <- rast(species_file)
                              habitat_complementarity <- rast(habitat_file)
                              connectivity <- rast(connectivity_file)
                              
                              # Handle NA values in each raster
                              species_richness[is.na(species_richness)] <- 0
                              habitat_complementarity[is.na(habitat_complementarity)] <- 0
                              connectivity[is.na(connectivity)] <- 0
                              
                              # Calculate the weighted scores
                              weighted_scores <- species_richness * weights[1] + habitat_complementarity * weights[2] + connectivity * weights[3]
                              
                              # Store the weighted scores in the list
                              weighted_scores_list[[species_base_name]] <- weighted_scores
                              output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/SR",paste0(species_base_name, ".tif"))
                           
                              # Save the weighted raster to a file
                              writeRaster(weighted_scores, output_path, overwrite = TRUE)
               } else {
                              cat("Corresponding files not found for", species_file, "\n")
               }
}

rm(list = ls(all = TRUE))
library(terra)
# Define the file paths for each set of rasters
species_richness_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/sm_bins/spp_cant/scaled/skale", pattern = "*.tif", full.names = TRUE)
habitat_complementarity_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled", pattern = "*.tif", full.names = TRUE)
connectivity_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled", pattern = "*.tif", full.names = TRUE)

# Initialize an empty list to store the weighted scores for each raster
weighted_scores_list <- list()

# Example weights (adjust as needed)
weights <- c(0.1, 0.8, 0.1)

# Iterate over the habitat complementarity files
for (habitat_file in habitat_complementarity_files) {
               # Extract the base file name (without extension)
               habitat_base_name <- tools::file_path_sans_ext(basename(habitat_file))
               
               # Find corresponding files for species richness and connectivity
               species_file <- species_richness_files[grep(habitat_base_name, species_richness_files)]
               connectivity_file <- connectivity_files[grep(habitat_base_name, connectivity_files)]
         
               # Check if corresponding files were found
               if (length(species_file) == 1 && length(connectivity_file) == 1) {
                              # Load the rasters
                              species_richness <- rast(species_file)
                              habitat_complementarity <- rast(habitat_file)
                              connectivity <- rast(connectivity_file)
                              
                              # Handle NA values in each raster
                              species_richness[is.na(species_richness)] <- 0
                              habitat_complementarity[is.na(habitat_complementarity)] <- 0
                              connectivity[is.na(connectivity)] <- 0
                              
                              # Calculate the weighted scores
                              weighted_scores <- species_richness * weights[1] + habitat_complementarity * weights[2] + connectivity * weights[3]
                              
                              # Store the weighted scores in the list
                              weighted_scores_list[[habitat_base_name]] <- weighted_scores
                              output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F",paste0(habitat_base_name, ".tif"))
                              
                              # Save the weighted raster to a file
                              writeRaster(weighted_scores, output_path, overwrite = TRUE)
               } else {
                              cat("Corresponding files not found for", habitat_file, "\n")
               }
}




rm(list = ls(all = TRUE))
library(terra)

# Define the file paths for each set of rasters
species_richness_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/sm_bins/spp_cant/scaled/skale", pattern = "*.tif", full.names = TRUE)
habitat_complementarity_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled", pattern = "*.tif", full.names = TRUE)
connectivity_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled", pattern = "*.tif", full.names = TRUE)

# Initialize an empty list to store the weighted scores for each raster
weighted_scores_list <- list()

# Example weights (adjust as needed)
weights <- c(0.1, 0.1, 0.8)

# Iterate over the connectivity files
for (connectivity_file in connectivity_files) {
               # Extract the base file name (without extension)
               connectivity_base_name <- tools::file_path_sans_ext(basename(connectivity_file))
               
               # Find corresponding files for species richness and habitat complementarity
               species_file <- species_richness_files[grep(connectivity_base_name, species_richness_files)]
               habitat_file <- habitat_complementarity_files[grep(connectivity_base_name, habitat_complementarity_files)]
               
               # Check if corresponding files were found
               if (length(species_file) == 1 && length(habitat_file) == 1) {
                              # Load the rasters
                              species_richness <- rast(species_file)
                              habitat_complementarity <- rast(habitat_file)
                              connectivity <- rast(connectivity_file)
                              
                              # Handle NA values in each raster
                              species_richness[is.na(species_richness)] <- 0
                              habitat_complementarity[is.na(habitat_complementarity)] <- 0
                              connectivity[is.na(connectivity)] <- 0
                              
                              # Calculate the weighted scores
                              weighted_scores <- species_richness * weights[1] + habitat_complementarity * weights[2] + connectivity * weights[3]
                              
                              # Store the weighted scores in the list
                              weighted_scores_list[[connectivity_base_name]] <- weighted_scores
                              output_path <- file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F",paste0(connectivity_base_name, ".tif"))
                              
                              # Save the weighted raster to a file
                              writeRaster(weighted_scores, output_path, overwrite = TRUE)
               } else {
                              cat("Corresponding files not found for", connectivity_file, "\n")
               }
}
