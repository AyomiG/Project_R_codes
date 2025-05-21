
library(terra)
library(RColorBrewer)
#library(wsl)
raster1=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/C_comp.tif")
raster2=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/C_con.tif")
raster3=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/R_comp.tif")
raster4=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/R_con.tif")
#raster1-raster2,raster3-raster4,raster1-raster3,raster2-raster4
acidic <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/final_map/acidic.tif") 

Waterbodiess=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess = crop(Waterbodiess, ext(acidic))


# Calculate the difference
#raster_diff <- raster1 - raster2
raster_diff <- raster3 - raster4
#raster_diff <- raster1 - raster3
#raster_diff <- raster2 - raster4
# Define a color palette from RColorBrewer





# Define thresholds for low, medium, and high differences
# low_threshold <- 10    # Magnitude considered low
# medium_threshold <- 30 # Magnitude considered medium
# 
# breaks <- c(-Inf, -medium_threshold, -low_threshold,
#                                 low_threshold, medium_threshold, Inf)
#breaks= c(-Inf, -7, -2, 2, 7, Inf)
breaks= c(-Inf, -5, -1.5, 1.5, 5, Inf)

# Create a smooth color gradient

#fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Common_D.png"
# fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Rare_D.png"
#fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Comp_D.png"
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Conn_D.png"


tot <- vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot <- project(tot, acidic)
tot <- rasterize(tot, acidic)
# Plot the raster difference
# png(fln,width=30,height=40,unit="cm",res=300,pointsize=7.5)
# plot(raster_diff, col = palette , legend = FALSE, axes = FALSE, mar = c(0.1, 0.1, 0.1, 0.1))
# plot(Waterbodiess, add = TRUE, 
#      col = c("skyblue", "#FFFFFF00"),  # White with alpha channel (transparent)
#      legend = FALSE, axes = FALSE)
# plot(tot, col = "#FFC107", legend = FALSE, axes = FALSE, add = TRUE)
# 
# # Close PNG device
# dev.off()

# Load the RColorBrewer package
# Load the RColorBrewer package
# Check the range of raster_diff
print(range(values(raster_diff), na.rm = TRUE))

# # Dynamically set color breaks based on data range
# data_min <- min(values(raster_diff), na.rm = TRUE)
# data_max <- max(values(raster_diff), na.rm = TRUE)
# 
# # Ensure range covers symmetrical values for diverging palette
# range_limit <- max(abs(data_min), abs(data_max))
#breaks <- seq(-range_limit, range_limit, length.out = 202) # 201 intervals
#breaks = c(-Inf,-7.5,-2.5,2.5,7.5,Inf)

# Define the color palette with white at the center (0)
palette <- brewer.pal(5, "PRGn")

# Save the plot to a PNG file
png(fln, width = 30, height = 40, unit = "cm", res = 300, pointsize = 7.5)

# Plot with adjusted breaks and colors
plot(raster_diff, col = palette, breaks = breaks, legend = TRUE, axes = FALSE, mar = c(0.1, 0.1, 0.1, 0.1))

# Overlay additional layers
plot(Waterbodiess, add = TRUE, col = c("deepskyblue", "#FFFFFF00"), legend = FALSE, axes = FALSE)
plot(tot, col = "#EEDC85", legend = FALSE, axes = FALSE, add = TRUE)

# Close the PNG device
dev.off()


#







library(RColorBrewer)
# Define color palette (reversed to show dark colors for high values)
# Check custom_palette directly
custom_palette <- colorRampPalette(brewer.pal(9, "PRGn"))(141)  # Define your palette
image(1:length(custom_palette), 1, as.matrix(1:length(custom_palette)), col = custom_palette, axes = FALSE)

# Set the breaks to match your data range
breaks <- seq(0, 1, length.out = length(custom_palette) + 1)

# Create the color scale
cscl(col = custom_palette,
     crds = c(0.3, 0.7, 1.16, 1.21),
     zrng = c(0, 1),
     breaks = breaks,
     at = seq(0, 1, length.out = 6),  # Five breaks will create six ticks
     lablag = 0.8,
     titlag = 2,
     tickle = 0.2,
     tria = "l",
     horiz = TRUE)

# Add axis labels for low and high
axis(1, at = c(0, 1), labels = c("Low", "High"), line = 1)

# Close the PNG device if it was opened before
dev.off()































# First, let's examine the data range
min_val <- min(values(raster_diff), na.rm = TRUE)
max_val <- max(values(raster_diff), na.rm = TRUE)

# Create more balanced color visualization
n_colors <- 100

# Option 1: Modified PRGn with more subtle colors
palette <- colorRampPalette(c("#006837", "#f7f7f7", "#b2182b"))(n_colors)

# Option 2: Alternative using custom breaks
breaks <- seq(min_val, max_val, length.out = n_colors)

# Create the plot with improved parameters
png(fln, width=30, height=40, unit="cm", res=300, pointsize=7.5)

# Add proper margins
par(mar = c(1, 1, 1, 4))  # Adjust margins to accommodate legend

# Plot with explicit breaks and scaling
plot(raster_diff,
     col = palette,
     breaks = breaks,
     legend.width = 1,    # Add legend
     legend = F,
     legend.shrink = 0.75,
     axes = FALSE)

# Add water bodies
plot(Waterbodiess, 
     add = TRUE, 
     col = c("skyblue", "#FFFFFF00"),
     legend = FALSE)
plot(tot,col ="orange",legend=F,axes=F, add=T)
dev.off()


# Assuming your raster_diff is (raster1 - raster2)
library(terra)
library(RColorBrewer)

# Create a diverging color palette
# Blue for negative values (where raster2 > raster1)
# Red for positive values (where raster1 > raster2)
n_colors <- 100  # Number of colors on each side
# pal <- c(rev(brewer.pal(9, "purple")[1:9]),  # Blues for negative
#          "#FFFFFF",                          # White for zero
#          brewer.pal(9, "green")[1:9])        # Reds for positive


pal <- c(rev(brewer.pal(9, "PRGn"))) 
# Create color palette function
palette <- colorRampPalette(pal)
cols <- palette(2 * n_colors + 1)  # +1 for the zero value

# Get the maximum absolute value for symmetric breaks
max_abs <- max(abs(values(raster_diff)), na.rm = TRUE)
breaks <- seq(-max_abs, max_abs, length.out = length(cols) + 1)

# Create the plot
png(fln, width=30, height=40, unit="cm", res=300, pointsize=7.5)
par(mar = c(0.1, 0.1, 0.1, 2))  # Adjust margins

# Plot the raster
plot(raster_diff,
     breaks = breaks,
     col = cols,
     legend = F,
     axes = FALSE)

# Add water bodies
plot(Waterbodiess, 
     add = TRUE,
     col = c("skyblue", "#FFFFFF00"),
     legend = FALSE)

# Add total area overlay
plot(tot,
     add = TRUE,
     col = "#FFC107",
     legend = FALSE)
dev.off()
