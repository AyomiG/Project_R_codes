# Load necessary libraries
library(raster)
library(ggplot2)

# Define paths to your 21 rasters
bin_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Con_F", pattern = ".tif", full.names = TRUE)

# Path to the second raster
second_raster_path <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/high_value_count_map.tif"

# Function to reclassify raster: high value = 1, non-high value = 0
reclassify_raster <- function(raster_path, low_value, high_value) {
               r <- raster(raster_path)
               # Reclassify the raster: values between low_value and high_value become 1, others become 0
               reclassified_raster <- reclassify(r, cbind(0, low_value - 1, 0, high_value, 1))
               return(reclassified_raster)
}

# Load and reclassify the second raster
second_raster <- reclassify_raster(second_raster_path, 14, 21)

# Initialize a vector to store the overlap percentages
overlap_percentages <- numeric(length(bin_raster_files))
raster_names <- character(length(bin_raster_files))

# Loop through each raster file in the list
for (i in 1:length(bin_raster_files)) {
               # Load and reclassify the current raster (66 to 100 are high-value)
               raster_file <- bin_raster_files[i]
               raster_name <- basename(raster_file)  # Get the name of the raster file
               raster_names[i] <- raster_name
               
               raster <- reclassify_raster(raster_file, 66, 100)
               
               # Calculate the overlap between the high-value areas in the raster and the second raster
               overlap <- cellStats(raster * second_raster, stat = "sum")  # Sum of cells where both are high-value
               total_high_value_area <- cellStats(raster, stat = "sum")   # Total high-value area in the current raster
               
               # Calculate the overlap percentage
               if (total_high_value_area > 0) {
                              overlap_percentage <- (overlap / total_high_value_area) * 100
               } else {
                              overlap_percentage <- 0
               }
               
               # Store the overlap percentage
               overlap_percentages[i] <- overlap_percentage
}

# Create a data frame with raster names and overlap percentages
overlap_data <- data.frame(Raster = raster_names, OverlapPercentage = overlap_percentages)

# Create the bar plot
ggplot(overlap_data, aes(x = Raster, y = OverlapPercentage)) +
               geom_bar(stat = "identity") +
               theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
               labs(title = "Percentage of High Value Areas Overlapping with the Second Raster", 
                    x = "Raster Name", 
                    y = "Overlap Percentage") +
               theme_minimal()
