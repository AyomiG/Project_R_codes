# Remove all objects from the global environment
rm(list = ls(all = TRUE))

# open gpkg file
# install.packages("sf")
library(sf)
library(terra)
library(raster)
shp = st_read("R:\\brunp\\shared\\oei_betrieb.gpkg")
sm=rast("C:\\Users\\ogundipe\\Documents\\data\\visua\\sm.tif")
# transform to spatVector in Terra
tshp = terra::vect(shp)   
# save as shapefile
# writeVector(tshp, filename = "C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\PA.shp")


# Print the shapefile object
# print(shapefile)
# write.csv(shapefile,file= "C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA.csv")


# Read the SpatVector file into R
spatvector <- terra::vect("C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\PA.shp")

# Assuming your SpatVector is named "spatvector"
spatvector_sub <- spatvector[spatvector$ha >= 0.0025, ]

# Create a new column in the shapefile dataframe to store the suitability score of each PA
# spatvector_sub$suitability_score <- NA
# Extract the suitability values from the SDMs for the PA
suitability_score<- terra::extract(sm,spatvector_sub)

poly_avg = aggregate(list(Mean_SM = suitability_score$sum),
                     by= list(ID = suitability_score$ID),
                     FUN = "mean", na.rm = TRUE)

# Calculate the 25th, 50th (median), and 75th percentiles
percentiles <- quantile(poly_avg$Mean_SM, probs = c(0.5, 0.75), na.rm = TRUE)
percentiles

# Print the percentiles
print(percentiles)
# Create a plot
plot(percentiles, type = "o", xaxt = "n", ylab = "Value", xlab = "Percentile", main = "Percentiles")

# Extract the Mean_SM column from poly_avg
mean_sm_values <- unlist(poly_avg$Mean_SM)

# Create a histogram of the Mean_SM values
hist(mean_sm_values, main = "Histogram of Mean_SM", xlab = "Mean_SM Value", ylab = "Frequency", col = "lightblue")

# Create a box plot
boxplot(mean_sm_values, main = "Box Plot of Data", xlab = "Data", ylab = "Value")

# p50 <- quantile(mean_sm_values, 0.50,na.rm = TRUE)
# p75 <- quantile(mean_sm_values, 0.75,na.rm = TRUE)
# bins <- c(min(mean_sm_values), p50, p75, max(mean_sm_values))
# hist(mean_sm_values, breaks = bins, col = c("blue", "green", "red"),
#      xlab = "Values", main = "Histogram with Percentile Ranges")


# Remove missing values
# imputed_mean_sm_values <- mean_sm_values[!is.na(mean_sm_values)]
# Impute missing values with the mean (replace 'mean' with your chosen imputation method)
imputed_mean_sm_values <- ifelse(is.na(mean_sm_values), mean(mean_sm_values, na.rm = TRUE), mean_sm_values)


# Calculate percentiles and create bins
p50 <- quantile(imputed_mean_sm_values, 0.50)
p75 <- quantile(imputed_mean_sm_values, 0.75)
bins <- c(min(imputed_mean_sm_values), p50, p75, max(imputed_mean_sm_values))

# Create the histogram
par(bg = "white")
hist(imputed_mean_sm_values, breaks = bins, col = c("blue", "green", "red"),
     xlab = "Values", main = "Histogram with Percentile Ranges")

# Add a legend (optional)
legend("topright", legend = c("0-50%", "50-75%", "75-100%"),
       fill = c("blue", "green", "red"))
par(bg = "white")


# # Merge the spatvector_sub and poly_avg dataframes based on the "ID" column
 spatvector_sub <- cbind(spatvector_sub, poly_avg)

 
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
 
 # Print the summary statistics for each bin
 print(summary_df)
 
# Save the shapefile with the new suitability score column to a new file
# write.csv(spatvector_sub,file = "C:\\Users\\ogundipe\\Documents\\data\\visua\\new_shape.csv")

# Filter polygons with suitability values 
 # Define the desired suitability range
sel_range = spatvector_sub$Mean_SM>=727.5 & spatvector_sub$Mean_SM <=3862
spatvector_high= spatvector_sub[sel_range, ]
writeVector(spatvector_high, filename = "C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\spatvector_high.shp")

# View or work with the filtered dataset
# Read the first shapefile (replace 'shapefile1.shp' with the actual file path)
shapefile1 <- st_read("C:\\Users\\ogundipe\\Documents\\data\\visua\\shape_PA\\PA.shp")
# Convert 'spatvector_high' to an sf object
sf_spatvector_high <- st_as_sf(spatvector_high)

# Perform the overlay operation (intersection in this example)
overlay_result <- st_intersection(shapefile1, sf_spatvector_high)
spp_file <- spatvector_high$mycolumn







