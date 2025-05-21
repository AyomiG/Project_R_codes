# Load necessary libraries
library(terra)


# Define the path to the main directory containing category folders
folder_path <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked18"

# Get a list of all raster files in the folder
raster_files <- list.files(folder_path, pattern = "\\.tif$", full.names = TRUE)

# Function to calculate summary statistics for a single raster
calc_raster_stats <- function(raster_file) {
               r <- rast(raster_file)
               stats <- c(
                              filename = basename(raster_file),
                              min = global(r, min, na.rm = TRUE)[1,1],
                              max = global(r, max, na.rm = TRUE)[1,1],
                              mean = global(r, mean, na.rm = TRUE)[1,1],
                              sd = global(r, sd, na.rm = TRUE)[1,1],
                              sum = global(r, sum, na.rm = TRUE)[1,1]
               )
               return(stats)
}

# Apply the function to all raster files
results <- lapply(raster_files, calc_raster_stats)

# Convert results to a data frame
results_df <- as.data.frame(do.call(rbind, results))

# Save results to a CSV file
write.csv(results_df, "75_statistics.csv", row.names = FALSE)

print("Summary statistics have been saved to 'T_statistics.csv'")