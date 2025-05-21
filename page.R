
# Load libraries
library(ggplot2)
library(cowplot)
library(png)
library(grid)

# Define the directory where your PNG files are stored
png_dir <-"C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/com_png"

# List all PNG files in the directory
png_files <- list.files(png_dir, pattern = "\\.png$", full.names = TRUE)

# Create a list to store the ggplot objects
plot_list <- list()

# Loop to read each PNG file and store it as a ggplot object
for (img_path in png_files) {
               img <- readPNG(img_path)
               p <- ggplot() + 
                              annotation_custom(rasterGrob(img, width=unit(1,"npc"), height=unit(1,"npc"))) + 
                              theme_void()
               plot_list[[length(plot_list) + 1]] <- p
}

# Check if any plots were added to the list
if (length(plot_list) > 0) {
               # Arrange the plots into a grid
               combined_plot <- plot_grid(plotlist = plot_list, ncol = 7, nrow = 3)
               
               # Save the combined plot to a file
               ggsave(file.path(png_dir, "combined_maps.png"), combined_plot, width = 14, height = 6)
               
               # Display the combined plot
               print(combined_plot)
} else {
               message("No plots to combine. Please check the file paths and names.")
}







#graphs


# Define the directory where your PNG files are stored
png_dir <-"C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_p"

# List all PNG files in the directory
png_files <- list.files(png_dir, pattern = "\\.png$", full.names = TRUE)

# Create a list to store the ggplot objects
plot_list <- list()

# Loop to read each PNG file, extract the number, and store it as a ggplot object
for (i in seq_along(png_files)) {
               img_path <- png_files[i]
               img <- readPNG(img_path)
               
               # Extract the numbers from the file name
               file_name <- basename(img_path)
               title <- gsub(".*_(\\d+_\\d+_\\d+).*", "\\1", file_name)  # Extracts the pattern "3_2_2" from "plot_3_2_2.png"
               
               p <- ggplot() + 
                              annotation_custom(rasterGrob(img, width=unit(1,"npc"), height=unit(1,"npc"))) + 
                              ggtitle(paste("Map", title)) +
                              theme_void() +
                              theme(plot.title = element_text(hjust = 0.5))
               
               plot_list[[i]] <- p
}

# Arrange the plots into a grid
combined_plot <- plot_grid(plotlist = plot_list, ncol = 7, nrow = 3)  # Adjust ncol and nrow as per your layout preference

# Save the combined plot to a file
ggsave(file.path(png_dir, "combined_maps2.png"), combined_plot, width = 21, height = 14)  # Adjust width and height as needed

# Display the combined plot
print(combined_plot)