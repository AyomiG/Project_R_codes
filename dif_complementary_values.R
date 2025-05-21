# Install and load required packages
install.packages(c("terra", "dplyr"))
library(terra)
library(dplyr)

# Define the function to calculate statistics for each raster
calculate_statistics <- function(r) {
               values <- values(r, na.rm = TRUE)
               stats <- data.frame(
                              mean = mean(values),
                              median = median(values),
                              min = min(values),
                              max = max(values),
                              sd = sd(values)
               )
               return(stats)
}

# Define the path to the main directory containing category folders
main_dir <- "path_to_your_rasters"

# List all category folders
categories <- list.dirs(path = main_dir, full.names = TRUE, recursive = FALSE)

all_statistics <- list()

for (category in categories) {
               # List all raster files in the current category folder
               raster_files <- list.files(path = category, pattern = "\\.tif$", full.names = TRUE)
               
               # Load all raster files into a list
               rasters <- lapply(raster_files, rast)
               
               # Calculate statistics for each raster
               statistics_list <- lapply(rasters, calculate_statistics)
               
               # Combine the statistics into a single data frame
               statistics_df <- do.call(rbind, statistics_list)
               statistics_df <- cbind(file = basename(raster_files), statistics_df)
               
               # Add a column for the category
               statistics_df$category <- basename(category)
               
               # Store the results
               all_statistics[[basename(category)]] <- statistics_df
}

# Combine all statistics into one data frame
final_statistics_df <- bind_rows(all_statistics)

# Export results to CSV
write.csv(final_statistics_df, "complementarity_statistics.csv", row.names = FALSE)
