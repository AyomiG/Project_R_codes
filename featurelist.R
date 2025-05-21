##feature.list
#connectivity with zonation
 #species file path to text files
library(dplyr)
 # Read the CSV file into R
 species_names <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\selected_rasters.csv", header = T)
 # Remove duplicates based on 'File_Name' column
 species_names_filtered <- species_names %>%
                filter(!grepl("covariate_ensemble\\.1", species))
 
 # Define the file path to be added
 file_path <- "C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL\\"
 ending <- "_zh.tif"
 
 # Modify the "Species" column
 species_names_filtered$species <- paste0(file_path,  species_names_filtered$species, ending)
 
 # Save the modified data as a text file
 writeLines(  species_names_filtered$species, "bincorrected_data.txt")
 

 