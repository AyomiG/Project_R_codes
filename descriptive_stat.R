# Load necessary libraries
library(terra)  # For raster manipulation
library(dplyr)  # For data manipulation
library(parallel)  # For parallel processing on Windows

# Define the directories containing the .comp and .con files
comp_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled"
con_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled"

# Get list of all .tif files in each directory
comp_files <- list.files(comp_dir, pattern = "\\.tif$", full.names = TRUE)
con_files <- list.files(con_dir, pattern = "\\.tif$", full.names = TRUE)

# Preallocate vectors to store R-squared values
r_squared_values <- numeric(length(comp_files))

# Function to process each pair of files and calculate R-squared
process_files <- function(comp_file, con_file) {
               # Load rasters
               comp <- rast(comp_file)
               con <- rast(con_file)
               
               # Convert rasters to data frames
               connectivity_df <- as.data.frame(con, xy = TRUE, na.rm = TRUE)
               colnames(connectivity_df) <- c("x", "y", "connectivity")
               complementarity_df <- as.data.frame(comp, xy = TRUE, na.rm = TRUE)
               colnames(complementarity_df) <- c("x", "y", "complementarity")
               
               # Merge data frames by coordinates
               merged_df <- merge(connectivity_df, complementarity_df, by = c("x", "y"))
               
               # Remove rows with NA values
               merged_df <- na.omit(merged_df)
               
               # Calculate R-squared
               if (nrow(merged_df) > 1) {  # Ensure there are enough data points for regression
                              lm_model <- lm(complementarity ~ connectivity, data = merged_df)
                              r_squared <- summary(lm_model)$r.squared
               } else {
                              r_squared <- NA
               }
               
               return(r_squared)
}

# Set up a cluster for parallel processing
num_cores <- detectCores() - 1  # Leave one core free
cl <- makeCluster(num_cores)

# Export necessary objects to the cluster
clusterExport(cl, c("comp_files", "con_files", "process_files", "rast"))

# Use parLapply for parallel processing
r_squared_values <- unlist(parLapply(cl, 1:length(comp_files), function(i) {
               process_files(comp_files[i], con_files[i])
}))

# Stop the cluster after processing
stopCluster(cl)

# Calculate average R-squared and the standard error of the mean R-squared
average_r_squared <- mean(r_squared_values, na.rm = TRUE)
standard_error_r_squared <- sd(r_squared_values, na.rm = TRUE) / sqrt(sum(!is.na(r_squared_values)))

# Print results
cat("Average R-squared:", average_r_squared, "\n")
cat("Standard Error of R-squared:", standard_error_r_squared, "\n")
