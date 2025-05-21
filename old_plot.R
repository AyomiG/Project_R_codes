# Load necessary library
library(terra)

# Load your rasters (replace paths with your actual file locations)
comp <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_1_1.tif")
con <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/3_1_1.tif")
xt=ext(comp)
# Extract values
# Extract values
values1 <- extract(con, xt, cells = TRUE, xy = TRUE)
values2 <- extract(comp, xt, cells = TRUE, xy = TRUE)

# Combine the extracted values into a data frame
data <- data.frame(con = values1[,4], comp= values2[,4])

# Remove NA values
data <- na.omit(data)

# Calculate the correlation coefficient (R) and R squared
correlation <- cor(data$con, data$comp)
r_squared <- correlation^2

# Create the plot
# Create the plot with point shapes and regression line
plot(data$con, data$comp, 
     pch = 19,  # Point shape (circle) - choose from '?pch' for options
     xlab = "connectivity", 
     ylab = "complimentarity",
     col = "black",
     cex = 0.5,
     cex.axis = 1.3, # Size of the axis numbers
     cex.lab = 1.7, # Size of the axis labels
     cex.main = 1.3)  # Set line color (optional)

# Add regression line
abline(lm(comp ~ con, data = data), col = "red", lwd=2)  # Red regression line

# Add R-squared as title
# Add R-squared as title (corrected)
title(main = paste("R²:", round(r_squared, 2)))
    

