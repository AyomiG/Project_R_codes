# Load necessary libraries
library(sf)
library(ggplot2)

# Assuming shapefiles are named as habitat1.shp, habitat2.shp, ..., habitat36.shp
# Adjust the file names based on your actual data
file_names <- paste0("habitat", 1:36, ".shp")

# Read shapefiles into a list
shapefiles <- lapply(file_names, st_read)

# Combine all polygons into a single sf object
all_polygons <- do.call(rbind, shapefiles)

# Check for overlapping areas
overlap <- st_intersection(all_polygons)

# Plot all polygons and overlapping areas
ggplot() +
               geom_sf(data = all_polygons, aes(fill = as.factor(group)), color = "black") +
               geom_sf(data = overlap, fill = "red", alpha = 0.5) +
               scale_fill_manual(values = rainbow(36)) +
               labs(title = "Overlapping Areas and All Polygons") +
               theme_minimal()
