rm(list = ls(all = TRUE))
#library(rgeos)
library(RColorBrewer)
library(terra)

con=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Mean_delta_H.tif")
comp=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_2_1.tif")
# mat now contains the calculated values based on your dataset

xt=ext(comp)
e= ext(669250, 716900.000000001, 223900.000000003, 283350.000000004 )
# Resample "Con" raster to match the extent of "comp"
con <- resample(con, comp, method = "bilinear")
con=terra::project(con, comp)
# Scaling operation
ac_q <- quantile(values(con), probs = seq(0, 1, 0.01), na.rm = TRUE)
vls_sc <- cut(values(con), breaks = ac_q)
vls_sc <- as.numeric(vls_sc)
resc_map <- con
values(con) <- vls_sc
# Extract values
values1 <- extract(con,xt,cells=T, xy = TRUE)
values2 <- extract(comp, xt,xy = TRUE)
data <- data.frame(con = values1, comp= values2)
# Assuming you have a raster object named 'raster_data'
#
# # Create a raster with NA values based on the extent and dimensions of 'con'
# na_raster <- rast(
#                nrows = nrow(comp),  # Use existing raster dimensions
#                ncols = ncol(comp),
#                ext = ext(comp),  # Inherit extent
#                crs = crs(comp),  # Inherit coordinate system
#                vals = NA
# )
# 
# # Plot the NA raster
# plot(na_raster)
# 
# # Fill the new raster with True (1) for NA and False (0) for valid values
# na_raster[is.na(comp)] <- 1
# 
# # Now, 'na_raster' contains a binary representation of NA locations
# 
# plot(comp, main = "Original Raster")  # Show the original data
# plot(na_raster, main = "NA Locations", add = TRUE, col="brown")  # Overlay the NA raster for comparison
# 
# 
















con=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Mean_delta_H.tif")
comp=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_2_1.tif")
# mat now contains the calculated values based on your dataset


# Extract values with NA removal
xt <- ext(comp)
values1 <- extract(con, xt, cells = TRUE, xy = TRUE)
values2 <- extract(comp, xt, cells = TRUE, xy = TRUE)

# mat now contains the calculated values based on your dataset

data<- na.omit(data)
data$result<-sqrt(data$con.sum^2 + data$comp.rankmap^2)
result<-sqrt(con^2 + comp^2)
cols<-colorRampPalette(brewer.pal(9,'BuGn'))
cols1<-cols(141)
data$cols<-cols1[floor(data$result)]
plot(data$con.sum,data$comp.rankmap,col=data$cols)














# Plot the matrix image
image(data$con.sum, data$comp.rankmap, col=data$cols)

# Add a color legend
legend("topright", legend = levels(data$cols), fill = levels(data$cols))





# mat now contains the calculated values based on your dataset

data <- na.omit(data)

# Remove rows with NA values
df <- na.omit(data)

# Create a matrix from the data frame
data<- as.matrix(df)

# Perform calculations on the matrix (if needed)
# For example, compute the Euclidean distance between the two raster values
# Calculate the square root of the sum of squares for each pair of values
data$result <- sqrt(df$con.sum^2 + df$comp.rankmap^2)

# If you need to reshape the result into a matrix, you can do so
result_matrix <- matrix(data$result, nrow = nrow(df), ncol = ncol(df)) 
# # Convert the matrix to a raster object
# result_raster <- rast(result_matrix)

# Plot the raster image
image(result_raster)


# Plot the matrix as an image
image(data_matrix$result)




# Plot a scatter plot of the values
plot(data$con.sum,data$comp.rankmap, xlab ="con", ylab = "comp", 
     main = "Scatter Plot of Values")

# Define segments based on mean values
mean_sum <- mean(data$con.sum, na.rm = TRUE)
mean_rankmap <- mean(data$comp.rankmap, na.rm = TRUE)


# Add midline
abline(h = mean_rankmap, col = "blue")  # Horizontal line
abline(v = mean_sum, col = "red")       # Vertical line


# Generate random data points
# Define the ranges for each segment
segment1_range <- c(0, 20)
segment2_range <- c(20, 40)
segment3_range <- c(40, 60)
segment4_range <- c(60, 80)
segment5_range <- c(80, 100)

# Plot the scatter plot
plot(data$con.sum, data$comp.rankmap, xlab = "con.sum", ylab = "comp.rankmap", main = "Scattered Points by Segment")

# Draw lines to separate segments
segments(segment1_range[1], segment1_range[1], segment1_range[2], segment1_range[1], col = "red")
segments(segment1_range[2], segment1_range[1], segment1_range[2], segment1_range[2], col = "red")

segments(segment2_range[1], segment2_range[1], segment2_range[2], segment2_range[1], col = "blue")
segments(segment2_range[2], segment2_range[1], segment2_range[2], segment2_range[2], col = "blue")

segments(segment3_range[1], segment3_range[1], segment3_range[2], segment3_range[1], col = "green")
segments(segment3_range[2], segment3_range[1], segment3_range[2], segment3_range[2], col = "green")

segments(segment4_range[1], segment4_range[1], segment4_range[2], segment4_range[1], col = "orange")
segments(segment4_range[2], segment4_range[1], segment4_range[2], segment4_range[2], col = "orange")

segments(segment5_range[1], segment5_range[1], segment5_range[2], segment5_range[1], col = "purple")
segments(segment5_range[2], segment5_range[1], segment5_range[2], segment5_range[2], col = "purple")









mean_rankmap <- mean(data$comp.rankmap, na.rm = TRUE)
mean_sum <- mean(data$con.sum, na.rm = TRUE)

# # Add midline
# abline(h = mean_rankmap, col = "blue")  # Horizontal line
# abline(v = mean_sum, col = "red")       # Vertical line
# # Define segments
segment1 <- data[data$con.sum< mean_sum & data$comp.rankmap< mean_rankmap, ]
segment2 <- data[data$con.sum>= mean_sum & data$comp.rankmap < mean_rankmap, ]
segment3 <- data[data$con.sum < mean_sum & data$comp.rankmap >= mean_rankmap, ]
segment4 <- data[data$con.sum >= mean_sum & data$comp.rankmap >= mean_rankmap, ]
# Assuming you have the segment coordinates stored in segment1, segment2, segment3, segment4
# Extract the coordinates of the segments
segment1_coords <- cbind(segment1$con.x, segment1$con.y)
segment2_coords <- cbind(segment2$con.x, segment2$con.y)
segment3_coords <- cbind(segment3$con.x, segment3$con.y)
segment4_coords <- cbind(segment4$con.x, segment4$con.y)
View(segment4)
View(segment4)
View(segment4_coords)
View(segment4_coords)
View(segment4)
View(segment4)
# Plot the raster map
plot(comp)
# Add points for each segment
points(segment1_coords, col = "red", pch = 16)
points(segment2_coords, col = "blue", pch = 16)
points(segment3_coords, col = "green", pch = 16)
points(segment4_coords, col = "red", pch = 16)

# Add a legend
legend("bottomleft", legend = c("Segment 1", "Segment 2", "Segment 3", "Segment 4"),
col = c("red", "blue", "green", "orange"), pch = 16)
rm(list = ls(all = TRUE))
library(rgeos)
library(RColorBrewer)
library(terra)
con=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Mean_delta_H.tif")
comp=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_2_1.tif")
# Scaling operation
ac_q <- quantile(values(con), probs = seq(0, 1, 0.01), na.rm = TRUE)
vls_sc <- cut(values(con), breaks = ac_q)
vls_sc <- as.numeric(vls_sc)
resc_map <- con
values(con) <- vls_sc
xt=ext(comp)
library(raster)
# Resample "Con" raster to match the extent of "comp"
con <- resample(con, comp, method = "bilinear")
# Extract values
values1 <- extract(con,xt, xy = TRUE)
values2 <- extract(comp, xt,xy = TRUE)














