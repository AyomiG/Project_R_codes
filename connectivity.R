##connectivity
##20.09.23

# Load the necessary packages
library(raster)
library(sf)
library(spatstat)

# Import the geospatial data
pa_boundary <- readOGR("pa_boundary.shp")
species_distribution_data <- readOGR("species_distribution_data.shp")

# Calculate the average suitability score for each species
average_suitability_scores <- sapply(species_distribution_data, function(x) {
               # Calculate the average value of the species distribution data within the PA boundary
               mean(x[pa_boundary])
})

# Calculate the average suitability score for all of the species in the PA
overall_average_suitability_score <- mean(average_suitability_scores)

# Print the overall average suitability score
print(overall_average_suitability_score)




# Load the necessary packages
library(terra)

# Import the geospatial data
pa_boundary <- readShapefile("pa_boundary.shp")
species_distribution_data <- terra::rast("species_distribution_data.tif")

# Calculate the average suitability score for each species
average_suitability_scores <- terra::extract(species_distribution_data, pa_boundary, stats="mean")

# Calculate the overall average suitability score for the PA
overall_average_suitability_score <- mean(average_suitability_scores)

# Print the overall average suitability score
print(overall_average_suitability_score)

