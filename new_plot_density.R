# # Load necessary libraries
# library(terra)
# library(RColorBrewer)
# library(ggplot2)
# library(hexbin)
# # 
# # # Load your rasters (replace paths with your actual file locations)
# # comp <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_1_1.tif")
# # con <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/3_1_1.tif")
# # 
# # # Convert rasters to data frames
# # connectivity_df <- as.data.frame(con, xy=TRUE, na.rm=TRUE)
# # colnames(connectivity_df) <- c("x", "y", "connectivity")
# # complementarity_df <- as.data.frame(comp, xy=TRUE, na.rm=TRUE)
# # colnames(complementarity_df) <- c("x", "y", "complementarity")
# # 
# # # Merge data frames by coordinates
# # merged_df <- merge(connectivity_df, complementarity_df, by=c("x", "y"))
# # 
# # # Remove rows with NA values
# # merged_df <- na.omit(merged_df)
# # 
# # # Calculate R-squared
# # lm_model <- lm(complementarity ~ connectivity, data = merged_df)
# # r_squared <- summary(lm_model)$r.squared
# # 
# # # Create the plot
# # p <- ggplot(merged_df, aes(x = connectivity, y = complementarity)) +
# #                stat_binhex(bins = 30, size=0.5) +  # Adjust the number of bins as needed
# #                scale_fill_gradientn(colours = c('#fff5f0','#fee0d2','#fcbba1','#fc9272','#fb6a4a','#ef3b2c','#cb181d','#a50f15','#67000d'),
# #                                     name = "Frequency") +
# #                geom_smooth(method = "lm", color = "black", se = FALSE) +
# #                labs(x = "Connectivity", y = "Complementarity") +
# #                theme_minimal() +
# #                theme(
# #                               panel.grid.major = element_blank(),
# #                               panel.grid.minor = element_blank(),
# #                               plot.title = element_blank(),
# #                               plot.margin = margin(5.5, 15, 5.5, 5.5),
# #                               axis.title = element_text(size = 16),
# #                               legend.position = "none"
# #                ) +
# #                annotate("text", x = Inf, y = Inf, 
# #                         label = paste("R² =", round(r_squared, 3)), 
# #                         hjust = 1.1, vjust = 1.1, size = 5)
# # 
# # # Display the plot
# # print(p)
# # 
# # # Optionally, save the plot
# # # ggsave("connectivity_complementarity_heatmap.png", p, width = 10, height = 8, dpi = 300)
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# # Load necessary libraries
# library(terra)
# library(RColorBrewer)
# library(ggplot2)
# 
# # Load your rasters (replace paths with your actual file locations)
# comp <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_1_1.tif")
# con <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/3_1_1.tif")
# 
# # Convert rasters to data frames
# connectivity_df <- as.data.frame(con, xy=TRUE, na.rm=TRUE)
# colnames(connectivity_df) <- c("x", "y", "connectivity")
# complementarity_df <- as.data.frame(comp, xy=TRUE, na.rm=TRUE)
# colnames(complementarity_df) <- c("x", "y", "complementarity")
# 
# # Merge data frames by coordinates
# merged_df <- merge(connectivity_df, complementarity_df, by=c("x", "y"))
# 
# # Remove rows with NA values
# merged_df <- na.omit(merged_df)
# 
# # Calculate R-squared
# lm_model <- lm(complementarity ~ connectivity, data = merged_df)
# r_squared <- summary(lm_model)$r.squared
# 
# # Create a 2D density estimate
# dens <- MASS::kde2d(merged_df$connectivity, merged_df$complementarity, n = 100)
# dens_df <- data.frame(expand.grid(connectivity = dens$x, complementarity = dens$y), density = as.vector(dens$z))
# 
# # Create the plot
# p <- ggplot(dens_df, aes(x = connectivity, y = complementarity, color = density)) +
#                geom_point(size = 2, alpha = 0.5) +  # Adjust size and alpha as needed
#                scale_color_gradientn(colours = c('#fff5f0','#fee0d2','#fcbba1','#fc9272','#fb6a4a','#ef3b2c','#cb181d','#a50f15','#67000d'),
#                                      name = "Density") +
#                geom_smooth(data = merged_df, aes(x = connectivity, y = complementarity), 
#                            method = "lm", color = "black", se = FALSE) +
#                labs(x = "Connectivity", y = "Complementarity") +
#                theme_minimal() +
#                theme(
#                               panel.grid.major = element_blank(),
#                               panel.grid.minor = element_blank(),
#                               plot.title = element_blank(),
#                               plot.margin = margin(5.5, 15, 5.5, 5.5),
#                               axis.title = element_text(size = 16),
#                               legend.position = "none"
#                ) +
#                annotate("text", x = Inf, y = Inf, 
#                         label = paste("R² =", round(r_squared, 3)), 
#                         hjust = 1.1, vjust = 1.1, size = 5)
# 
# # Display the plot
# print(p)
# 
# # Optionally, save the plot
# # ggsave("connectivity_complementarity_scatter.png", p, width = 10, height = 8, dpi = 300)
# 
# 
# 
# 







# Load necessary libraries
# Load necessary libraries
library(terra)
library(RColorBrewer)
library(ggplot2)

# Load your rasters (replace paths with your actual file locations)
comp <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/2_1_2.tif")
con <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/2_1_2.tif")

# Load your rasters (replace paths with your actual file locations)
comp <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/1_1_4.tif")
con <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/1_1_4.tif")


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
library(ggplot2)
library(RColorBrewer)

# Your existing data preparation code here...

# Modified plot code
p <- ggplot(dens_df, aes(x = connectivity, y = complementarity, color = density)) +
               geom_point(size = 2, alpha = 0.5) +
               scale_color_gradientn(
                              colours = brewer.pal(9, "YlOrRd"),
                              trans = "sqrt",
                              name = "Density"
               ) +
               geom_smooth(
                              data = merged_df, 
                              aes(x = connectivity, y = complementarity),
                              method = "lm", 
                              color = "black", 
                              se = FALSE
               ) +
               labs(
                              x = "Connectivity", 
                              y = "Complementarity",
                              title = paste("R² =", round(r_squared, 3))  # Add R² as a proper title
               ) +
               theme_minimal() +
               theme(
                              panel.grid.major = element_blank(),
                              panel.grid.minor = element_blank(),
                              plot.title = element_text(
                                             size = 30,            # Increase title font size
                                             face = "bold",        # Make it bold
                                             hjust = 0.5,          # Center the title
                                             margin = margin(b = 20)  # Add space below title
                              ),
                              plot.margin = margin(15, 15, 15, 15),  # Increased overall margins
                              axis.title = element_text(size = 30),
                              axis.text = element_text(size = 30),
                              legend.position = "none"
               )

# Save at 600 DPI
ggsave(
               filename = "212.png",  # Specify your output file name
               plot = p,
               device = "png",
               dpi = 600,                       # Set resolution to 600 DPI
               width = 10,                      # Width in inches
               height = 8,                      # Height in inches
               units = "in"                     # Units for width/height
)

# Display the plot
print(p)
