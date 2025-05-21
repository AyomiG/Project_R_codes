library(terra)

# Paths
input_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F"

output_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/masked"

# Load Zurich shapefile
zurich_boundary <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/zurich.shp")

# List raster files
raster_files <- list.files(input_folder, pattern = "\\.tif$", full.names = TRUE)

# Loop through each raster
for (file in raster_files) {
               # Get original filename (e.g., 1_1_1.tif)
               base_name <- tools::file_path_sans_ext(basename(file))
               
               # Load raster
               r <- rast(file)
               
               # Ensure same CRS
               zurich_projected <- project(zurich_boundary, crs(r))
               
               # Crop and mask
               r_cropped <- crop(r, zurich_projected)
               r_masked <- mask(r_cropped, zurich_projected)
               
               # Save masked raster using original name
               writeRaster(r_masked,
                           filename = file.path(output_folder, paste0(base_name, ".tif")),
                           overwrite = TRUE)
}
#top third

library(terra)

# Input directory (masked rasters)
input_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/masked"
output_folder <- file.path(input_folder, "top_third_binary")

# Create output directory if it doesn't exist
if (!dir.exists(output_folder)) dir.create(output_folder)

# List masked raster files
raster_files <- list.files(input_folder, pattern = ".tif$", full.names = TRUE)

# Loop through rasters and reclassify top third
for (file in raster_files) {
               base_name <- tools::file_path_sans_ext(basename(file))
               
               r <- rast(file)
               
               # Calculate 66th percentile threshold (excluding NA)
               threshold <- quantile(values(r), probs = 0.66, na.rm = TRUE)
               
               # Create binary mask: 1 for top third, NA elsewhere
               r_binary <- classify(r, matrix(c(-Inf, threshold, NA,
                                                threshold, Inf, 1), 
                                              ncol = 3, byrow = TRUE))
               
               # Save output
               writeRaster(r_binary,
                           filename = file.path(output_folder, paste0(base_name, "_top_third.tif")),
                           overwrite = TRUE)
}

##total
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map7518/acidic.tif" ) 
xt=ext(acidic)
Waterbodiess=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess = crop(Waterbodiess, xt)
#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)


# Path to your top-third binary rasters
input_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/masked/top_third_binary"

# List and load all binary rasters
binary_files <- list.files(input_folder, pattern = "_top_third\\.tif$", full.names = TRUE)
binary_stack <- rast(binary_files)

# Sum across all 21 rasters to get overlap count per pixel (ignoring NA)
overlap_count <- sum(binary_stack, na.rm = TRUE)

# Print summary of the original overlap count
print("Summary of original overlap count:")
print(summary(overlap_count))

# Alternative reclassification approach using app function
classified_raster <- app(overlap_count, function(x) {
               ifelse(is.na(x), NA, 
                      ifelse(x >= 15, 3, 
                             ifelse(x >= 8, 2, 
                                    ifelse(x >= 1, 1, NA))))
})

# Print summary of the classified raster to verify
print("Summary of classified raster:")
print(summary(classified_raster))
print("Unique values in classified raster:")
print(unique(values(classified_raster)))
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/masked/comp.png"

png(fln, width=30, height=40, unit="cm", res=600, pointsize=7.5)
# Save the reclassified raster
writeRaster(classified_raster, 
            filename = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/overlap_classified.tif", 
            overwrite = TRUE)

# Create a color palette
my_colors <- c("#ffffbb", "#fd8d3c", "#bd0026")

# Set up the plot area
par(mar = c(5, 4, 4, 2))

# Plot with custom colors
plot(classified_raster, 
     col = my_colors,
     legend = F, 
     axes = FALSE)

plot(Waterbodiess, add = TRUE, 
     col = c("deepskyblue", "#FFFFFF00"), 
     legend = FALSE, 
     axes = FALSE)

plot(tot, 
     col = "#1A1A1A",  # Golden color for specific layer
     legend = FALSE, 
     axes = FALSE, 
     add = TRUE)
dev.off()
dev.off()









# Load classified overlap raster
combined_classified <- classified_raster

# List top third binary rasters
top_raster_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Final/Comp_F/masked/top_third_binary", 
                               pattern = ".tif$", full.names = TRUE)

# Initialize vectors
overlap_percents <- numeric(length(top_raster_files))
plot_labels <- character(length(top_raster_files))
group_ids <- character(length(top_raster_files))

# Define acronym mappings
ph_map <- c("A", "Ak", "N")          # Soil pH: 1, 2, 3
elev_map <- c("LE", "ME")              # Elevation: 1, 2
moist_map <- c("W", "MO", "MD", "D") # Moisture: 1, 2, 3, 4

# Loop and compute
for (i in seq_along(top_raster_files)) {
               r <- rast(top_raster_files[i])
               r <- resample(r, combined_classified, method = "near")
               
               high_mask <- combined_classified == 3
               masked <- mask(r, high_mask, maskvalues = 0)
               
               overlap_count <- global(masked, "sum", na.rm = TRUE)[[1]]
               total_top <- global(r, "sum", na.rm = TRUE)[[1]]
               overlap_percents[i] <- (overlap_count / total_top) * 100
               
               base <- tools::file_path_sans_ext(basename(top_raster_files[i]))
               parts <- unlist(strsplit(base, "_"))
               
               # Generate acronym-based label
               label_ph <- ph_map[as.numeric(parts[1])]
               label_elev <- elev_map[as.numeric(parts[2])]
               label_moist <- moist_map[as.numeric(parts[3])]
               
               label_id <- paste(label_ph, label_elev, label_moist, sep = "/")
               plot_labels[i] <- label_id
               
               group_ids[i] <- parts[1]  # Keep numeric for sorting
}

# Create dataframe
df <- data.frame(
               label = plot_labels,
               percent = overlap_percents,
               group = as.numeric(group_ids),
               stringsAsFactors = FALSE
)

# Remove rows with any NA values
df <- na.omit(df)
# Sort by group and percent
df_sorted <- df[order(df$group, df$percent), ]

# Define group-based colors
group_colors <-c("#17BECF", "#9467BD", "#8FBC8F")
group_factors <- factor(df_sorted$group)
bar_colors <- group_colors[group_factors]

# Plot bar chart
bar_pos <- barplot(df_sorted$percent,
                   names.arg = df_sorted$label,
                   las = 2,
                   col = bar_colors,
                   width = 1.5,
                   space = 0.2,
                   xlim = c(0, length(df_sorted$percent) * 1.8),
                   ylab = "Overlap(%)",
                   cex.names = 1.0,
                   ylim = c(0, max(df_sorted$percent) + 10))

