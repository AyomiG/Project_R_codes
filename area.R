# Remove all objects from the global environment
rm(list = ls(all = TRUE))
library(terra)

# Load your priority map raster
priority_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/HighE.tif")

# Load the hierarchical mask layer representing protected areas
protected_areas_mask <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/CPA.tif")

# Identify areas with high priority outside protected areas
# Identify areas with high priority outside protected areas
# Identify areas with high priority outside protected areas
# Identify areas with high priority outside protected areas
high_priority_outside_protected <- ifel(protected_areas_mask == 0 & (!is.na(priority_map) | is.na(protected_areas_mask)), priority_map, NA)

# Plot the result
plot(high_priority_outside_protected)




# Assuming you have three raster objects: high_priority_outside_protected, protected_areas_mask, and priority_map

# Plot side by side
par(mfrow=c(1, 3)) # Set up a 1x3 grid for plots
# Plot the priority_map
plot(priority_map, main="Priority Map")
# Plot the protected_areas_mask
plot(protected_areas_mask, main="Protected Areas")

# Plot the high_priority_outside_protected
plot(high_priority_outside_protected, main="High Priority Outside Protected Areas")




# Assuming you have three raster objects: acidic_map, basic_map, and neutral_map

# Load your priority map raster
acidic_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/wet.tif")
alkaline_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/moist.tif")
neutral_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/moderate.tif")
dry <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/dry.tif")

# Set a threshold for similarity
# threshold <- 0.8
threshold <- 0.5
# Set the threshold for low values
low_threshold <- 0.2  # Adjust this based on your criteria
# Identify areas outside protected areas with consistently high values across the three maps
consistently_high_areas <- ifel(protected_areas_mask == 0 & acidic_map > threshold & alkaline_map > threshold & neutral_map > threshold & dry > threshold, 1, NA)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder", "HumH5.tif")
writeRaster(consistently_high_areas , output, overwrite = TRUE)
# Identify areas outside protected areas with consistently low values across the three maps
consistently_low_areas <- ifel(protected_areas_mask == 0 & acidic_map < low_threshold & alkaline_map < low_threshold & neutral_map < low_threshold & dry< threshold, 1, NA)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder", "HumL.tif")
writeRaster(consistently_low_areas , output, overwrite = TRUE)



# Load your priority map raster(Elevation)
neutral_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/medE.tif")
alkaline_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/HighE.tif")
acidic_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/lowE.tif")
consistently_high_areas <- ifel(protected_areas_mask == 0 & acidic_map > threshold & alkaline_map > threshold & neutral_map > threshold, 1, NA)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder", "EleH5.tif")
writeRaster(consistently_high_areas , output, overwrite = TRUE)
# Identify areas outside protected areas with consistently low values across the three maps
consistently_low_areas <- ifel(protected_areas_mask == 0 & acidic_map < low_threshold & alkaline_map < low_threshold & neutral_map < low_threshold, 1, NA)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder", "EleL.tif")
writeRaster(consistently_low_areas , output, overwrite = TRUE)


# Assuming you have raster layers named acidic_map, alkaline_map, and neutral_map
neutral_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/neutral.tif")
alkaline_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/alkaline.tif")
acidic_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/acidic.tif")
consistently_high_areas <- ifel(protected_areas_mask == 0 & acidic_map > threshold & alkaline_map > threshold & neutral_map > threshold, 1, NA)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder", "PHH5.tif")
writeRaster(consistently_high_areas , output, overwrite = TRUE)
# Identify areas outside protected areas with consistently low values across the three maps
consistently_low_areas <- ifel(protected_areas_mask == 0 & acidic_map < low_threshold & alkaline_map < low_threshold & neutral_map < low_threshold, 1, NA)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder", "PHL.tif")
writeRaster(consistently_low_areas , output, overwrite = TRUE)



# Plot the result
par(mfrow=c(1, 3))
plot(protected_areas_mask, main="Protected Areas")
# Plot the result
plot(consistently_low_areas, main="low")
# Plot the result
plot(consistently_high_areas, main="high")


# Plot the protected_areas_mask
plot(protected_areas_mask, main="Protected Areas")
plot(similar_trends_outside_protected)



# Given values
total_area_zurich <- 172894
water_area <- 6811
protected_area <- 13322.179

# Exclude water area from the total area
land_area_zurich <- total_area_zurich - water_area

# Calculate the percentage of protected area in Zurich Canton (excluding water)
percentage_protected_area <- (protected_area / land_area_zurich) * 100

# Print the result
cat("Percentage of protected area in Zurich Canton (excluding water):", round(percentage_protected_area, 2), "%\n")
  8.02 %

output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots", "water.tif")
writeRaster(ll , output, overwrite = TRUE)



# The group of species represented in the provided files includes various aquatic and wetland plants, such as Utricularia intermedia, Sparganium natans,
# Juncus bulbosus, Ranunculus reptans, Eleocharis acicularis, Glyceria notata, Myosotis cespitosa, Nasturtium officinale, Berula erecta, Leersia oryzoides,
# Carex paupercula, Phleum alpinum, Carex echinata, Viola palustris, Eriophorum scheuchzeri, 
# Carex canescens, Lycopodiella inundata, and many more.