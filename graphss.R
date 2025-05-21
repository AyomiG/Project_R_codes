rm(list = ls(all = TRUE))
#library(rgeos)
library(RColorBrewer)
library(terra)


# Define the folder paths containing the comp and con files
comp_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/"
con_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/"

# Define the output folder path
output_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results"

# List all the comp files in the folder
comp_files <- list.files(comp_folder, pattern = "*.tif", full.names = TRUE)


# Define color gradient
cols <- colorRampPalette(brewer.pal(9, 'OrRd'))
cols1 <- cols(141)
dir.create(output_folder, showWarnings = FALSE)
for (comp_file in comp_files) {
               cat("Processing...", comp_file, "\n")
               
               # Construct the corresponding con file path
               con_file <- file.path(con_folder, basename(comp_file))
               
               # Check if both comp and con files exist
               if (file.exists(comp_file) && file.exists(con_file)) {
                              # Read the raster files
                              con <- rast(con_file)
                              comp <- rast(comp_file)
                              
                              # Extract values with NA removal
                              xt <- ext(comp)

                              # Extract values
                              values1 <- extract(con, xt, cells = TRUE, xy = TRUE)
                              values2 <- extract(comp, xt, cells = TRUE, xy = TRUE)
                              data <- data.frame(con = values1, comp= values2)
                              
                              # mat now contains the calculated values based on your dataset
                              data<- na.omit(data)
                              
                              # Check if data contains finite values
                              if (nrow(data) > 0) {
                                             # Calculate result
                                             data$result<-sqrt(data[, 4]^2 + data[, 8]^2)
               
                                             # Create color palette
                                             data$cols <- cols1[floor(data$result)]
                                             
                                             
                                             
                                             # Save the plot to the output folder
                                             plot_filename <- file.path(output_folder, paste0("plot_", basename(comp_file), ".png"))
                                             png(plot_filename)
                                             dev.copy(png, plot_filename)
                                             
                                             # Plot the result
                                             plot(data[, 4], data[, 8], col = data$cols,pch=15,cex=1.5,
                                                  xlab = "Connectivity", ylab = "Complementarity")
                                             
                                             dev.off()
                              } else {
                                             print(paste("Data in", basename(comp_file), "contains only non-finite values. Skipping plot generation."))
                              }
               }
               cat("Processed...", comp_file , "\n")
}










