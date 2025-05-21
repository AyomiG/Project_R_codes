rm(list = ls(all = TRUE))
library(rgeos)
library(RColorBrewer)
library(terra)

# con=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Mean_delta_H.tif")
# comp=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_2_1.tif")
# # mat now contains the calculated values based on your dataset
# 
# xt=ext(comp)
# # Extract values
# values1 <- extract(con,xt, xy = TRUE)
# values2 <- extract(comp, xt,xy = TRUE)
# data <- data.frame(con = values1, comp= values2)
# 
# 
# # mat now contains the calculated values based on your dataset
# data<- na.omit(data)
# data$result<-sqrt(data$con.sum^2 + data$comp.rankmap^2)
# result<-sqrt(con^2 + comp^2)
# cols<-colorRampPalette(brewer.pal(9,'BuGn'))
# cols1<-cols(141)
# data$cols<-cols1[floor(data$result)]
# plot(data$con.sum,data$comp.rankmap,col=data$cols)
# data$cols<-cols1[floor(data$result)]
# #raster
# # Perform the calculation on the raster objects
# result <- sqrt(con^2 + comp^2)
# # Plot the raster object
# plot(result, col = cols1,legend=F,axes=F)
# 
# 
# 









# 
# Define the folder paths containing the comp and con files
comp_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/"
con_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/"

# Define the output folder path
output_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/comb_ras"

# List all the comp files in the folder
comp_files <- list.files(comp_folder, pattern = "*.tif", full.names = TRUE)
# 
# # # Define color gradient
# # cols <- colorRampPalette(brewer.pal(9, 'BuGn'))
# # cols1 <- cols(141)
# 
# # Iterate over each comp file
for (comp_file in comp_files) {
               # Extract the file name without extension
              filename <- tools::file_path_sans_ext(basename(comp_file))
              
#                # Construct the corresponding con file path
               con_file <- file.path(con_folder, paste0(filename, ".tif"))
#                
#                # Check if both comp and con files exist
               if (file.exists(comp_file) && file.exists(con_file)) {
                              # Read the raster files
                              con <- rast(con_file)
                             comp <- rast(comp_file)
                             
                            # Calculate the result
                          result <- sqrt(con^2 + comp^2)
                           
                           # # Plot the result
                           # plot(result, col = cols1, legend = FALSE, axes = FALSE)
                           
                          # Write the raster to disk
                           # Write the raster to disk
                              output_file <- file.path(output_folder, paste0(filename, ".tif"))
                             writeRaster(result, filename = output_file, overwrite = TRUE)
               }
}



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
               # Construct the corresponding con file path
               con_file <- file.path(con_folder, basename(comp_file))
               
               # Check if both comp and con files exist
               if (file.exists(comp_file) && file.exists(con_file)) {
                              # Read the raster files
                              con <- rast(con_file)
                              comp <- rast(comp_file)
                              
                              # Extract values with NA removal
                              xt <- ext(comp)
                              values1 <- extract(con, xt, cells = TRUE, xy = TRUE)
                              values2 <- extract(comp, xt, cells = TRUE, xy = TRUE)
                              
                              # Set column names for values1 and values2
                              names(values1) <- "con"
                              names(values2) <- "comp"
                              
                              # Create a data frame with extracted values
                              data <- data.frame(con = values1, comp = values2)
                              data=na.omit(data)
                              
                              # Check if data contains finite values
                              if (nrow(data) > 0) {
                                             # Calculate result
                                             data$result <- sqrt(data$con^2 + data$comp^2)
                                             
                                             # Create color palette
                                             data$cols <- cols1[floor(data$result)]
                                             
                                             # Plot the result
                                             plot(data$con, data$comp, col = data$cols,pch=10,cex=.2,
                                                  xlab = "Connectivity", ylab = "Complementarity")
                                             
                                             # Save the plot to the output folder
                                             plot_filename <- file.path(output_folder, paste0("plot_", basename(comp_file), ".png"))
                                             png(plot_filename)
                                             dev.copy(png, plot_filename)
                                             dev.off()
                              } else {
                                             print(paste("Data in", basename(comp_file), "contains only non-finite values. Skipping plot generation."))
                              }
               }
}










