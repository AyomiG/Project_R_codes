##Protected Area data prep and selection of areas with highest suitability scores
# Remove all objects from the global environment
rm(list = ls(all = TRUE))

library(sf)
library(terra)
library(raster)
#read the PA_shapefile(shp)
shp = st_read("R:\\brunp\\shared\\oei_betrieb.gpkg")
#sm is the sum of rasters of all the SDMs of species found under bin 1_2_1
sm=rast("C:\\Users\\ogundipe\\Documents\\data\\visua\\sm.tif")
# transform to spatVector in Terra
tshp = terra::vect(shp)
# writeVector(tshp, filename = "C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\PA.shp")
# write.csv(shapefile,file= "C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA.csv")
# Read the SpatVector file into R
spatvector <- terra::vect("C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\PA.shp")

# filter out all PAs with no area of very low area
spatvector_sub <- spatvector[spatvector$ha >= 0.0025, ]
# Extract the suitability values from the SDMs for the PA
suitability_score<- terra::extract(sm,spatvector_sub)

poly_avg = aggregate(list(Mean_SM = suitability_score$sum),
                     by= list(ID = suitability_score$ID),
                     FUN = "mean", na.rm = TRUE)

# Extract the Mean_SM column from poly_avg
mean_sm_values <- unlist(poly_avg$Mean_SM)

# Impute missing values with the mean 
imputed_mean_sm_values <- mean_sm_values[!is.na(mean_sm_values)]
# Calculate percentiles and create bins
p50 <- quantile(imputed_mean_sm_values, 0.50)
p75 <- quantile(imputed_mean_sm_values, 0.75)
bins <- c(min(imputed_mean_sm_values), p50, p75, max(imputed_mean_sm_values))

# Create the histogram
hist(imputed_mean_sm_values, breaks = bins, col = c("blue", "green", "red"),
     xlab = "Values", main = "Histogram with Percentile Ranges")
legend("topright", legend = c("0-50%", "50-75%", "75-100%"),
       fill = c("blue", "green", "red"))

# Create a factor variable representing the bins
bin_labels <- c("0-50%", "50-75%", "75-100%")
bin_factor <- cut(imputed_mean_sm_values, breaks = bins, labels = bin_labels, include.lowest = TRUE)

# Create a data frame with the value range and summary statistics for each bin
summary_df <- data.frame(
               Bin = bin_labels,
               Value_Range = sapply(1:(length(bins) - 1), function(i) {
                              paste(bins[i], bins[i + 1], sep = " - ")
               }),
               Count = table(bin_factor),
               Mean = tapply(imputed_mean_sm_values, bin_factor, mean),
               Median = tapply(imputed_mean_sm_values, bin_factor, median),
               Min = tapply(imputed_mean_sm_values, bin_factor, min),
               Max = tapply(imputed_mean_sm_values, bin_factor, max)
)

print(summary_df)
# Merge the spatvector_sub and poly_avg dataframes based on the "ID" column
spatvector_sub <- cbind(spatvector_sub, poly_avg)

# Filter polygons(PAs) with high suitability values (that falls in the 75th percentile and above)
sel_range = spatvector_sub$Mean_SM>=727.5 & spatvector_sub$Mean_SM <=3862
spatvector_high= spatvector_sub[sel_range, ]
# Save the shapefile with the new suitability score column to a new file
writeVector(spatvector_high, filename = "C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\spatvector_high.shp")

##rasterize the data so, as to be recognized as a zonation input
#for the PA features
# Define the raster extent and resolution based on your data
# Open a raster file (e.g., GeoTIFF)
raster_data <- rast("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL/Bryum.klinggraeffii_loc_covariate_ensemble_zh.tif")

# Rasterize the vector data to the SpatRaster object
rasterized_data <- rasterize(spatvector_high,raster_data)

# Save the SpatRaster object to a file
writeRaster(rasterized_data, filename ="C:\\Users\\ogundipe\\Documents\\data\\visua\\rasterized_polygons.tif" )
tt=raster("C:\\Users\\ogundipe\\Documents\\data\\visua\\rasterized_polygons.tif")
ss="C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\spatvector_high.shp"

# Extract raster values to a data frame
tt_df <- extract(tt,ss,cells = TRUE)

# Save the data frame to a CSV file
write.csv(tt_df, file = "C:\\Users\\ogundipe\\Documents\\data\\visua\\rasterized_polygons.csv", row.names = FALSE)
