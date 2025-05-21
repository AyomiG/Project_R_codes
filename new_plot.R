

# Load necessary libraries
# Load necessary libraries
library(terra)
library(RColorBrewer)
library(ggplot2)

# Load your rasters (replace paths with your actual file locations)
comp <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_1_1.tif")
con <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/3_1_1.tif")

# Convert rasters to data frames
connectivity_df <- as.data.frame(con, xy=TRUE, na.rm=TRUE)
colnames(connectivity_df) <- c("x", "y", "connectivity")
complementarity_df <- as.data.frame(comp, xy=TRUE, na.rm=TRUE)
colnames(complementarity_df) <- c("x", "y", "complementarity")

# Merge data frames by coordinates
merged_df <- merge(connectivity_df, complementarity_df, by=c("x", "y"))

# Remove rows with NA values
merged_df <- na.omit(merged_df)

# Calculate R-squared
lm_model <- lm(complementarity ~ connectivity, data = merged_df)
r_squared <- summary(lm_model)$r.squared

# Create a 2D density estimate
dens <- MASS::kde2d(merged_df$connectivity, merged_df$complementarity, n = 100)
dens_df <- data.frame(expand.grid(connectivity = dens$x, complementarity = dens$y), density = as.vector(dens$z))

# Create the plot with a customized ColorBrewer palette
p <- ggplot(dens_df, aes(x = connectivity, y = complementarity, color = density)) +
               geom_point(size = 2, alpha = 0.5) +  # Adjust size and alpha as needed
               scale_color_gradientn(colours = brewer.pal(9, "YlOrRd"),  # Use OrRd palette with 9 colors
                                     trans = "sqrt",  # Apply square root transformation for better color contrast
                                     name = "Density") +
               geom_smooth(data = merged_df, aes(x = connectivity, y = complementarity), 
                           method = "lm", color = "black", se = FALSE) +
               labs(x = "Connectivity", y = "Complementarity") +
               theme_minimal() +
               theme(
                              panel.grid.major = element_blank(),
                              panel.grid.minor = element_blank(),
                              plot.title = element_blank(),
                              plot.margin = margin(5.5, 15, 5.5, 5.5),
                              axis.title = element_text(size = 20),
                              axis.text = element_text(size = 20),
                              legend.position = "none"
               ) +
               annotate("text", x = Inf, y = Inf, 
                        label = paste("R² =", round(r_squared, 3)), 
                        hjust = 1.1, vjust = 1.1, size = 8)

# Display the plot
print(p)

