library(sf)
library(terra)

# Load parent vector file
parent <- st_read("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
parent <- as.data.frame(parent)

unique_ha_values <- unique(parent$ha)
id_counts <- table(parent$ID)

# Initialize an empty data frame to store the merged results
parent_with_counts <- parent

# List all bin files in the directory
binfiles <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/p75", pattern = ".shp", full.names = TRUE)

# Select bin files containing "result_1" in their filenames
selected_bin_files <- binfiles[grep("result_[0-9]_[0-9]_1", binfiles)]

# Initialize an empty list to store bin_data
all_bin_data <- list()

# Read all bin_data files and store them in all_bin_data list
for (bin_file in selected_bin_files) {
               bin_data <- st_read(bin_file)
               all_bin_data[[bin_file]] <- bin_data
}

# Initialize an empty list to store counts for each unique 'ha' value
ha_counts <- list()
ha_bin_names <- list()  # List to store the names of the bins picked by each polygon

# Iterate over each unique 'ha' value in the 'parent' data frame
for (unique_ha in unique(parent$ha)) {
               # Initialize a count variable for the current 'ha' value
               count <- 0
               bin_names <- character(0)  # Initialize a vector to store the names of the bins picked by each polygon
               
               # Iterate over each bin_data
               for (bin_data_file in names(all_bin_data)) {
                              # Get the bin_data
                              bin_data <- all_bin_data[[bin_data_file]]
                              
                              # Check if the 'ha' value is present in the bin_data
                              if (unique_ha %in% bin_data$ha) {
                                             # If present, increment the count by 1
                                             count <- count + 1
                                             # Store the name of the bin picked by the current polygon
                                             bin_names <- c(bin_names, basename(bin_data_file))
                              }
               }
               
               # Store the count for the current 'ha' value
               ha_counts[[as.character(unique_ha)]] <- count
               # Store the names of the bins picked by each polygon
               ha_bin_names[[as.character(unique_ha)]] <- bin_names
}

# Print the counts and the names of the bins picked by each polygon
for (i in seq_along(unique_ha_values)) {
               cat("HA:", unique_ha_values[i], " - Count:", ha_counts[[as.character(unique_ha_values[i])]], " - Bins:", ha_bin_names[[as.character(unique_ha_values[i])]], "/n")
}

# Define the range of ha values
lower_bound <- 0.06564
upper_bound <-0.066

# Print the counts and the names of the bins for ha values within the specified range
for (i in seq_along(unique_ha_values)) {
               ha_value <- as.numeric(unique_ha_values[i])
               if (ha_value >= lower_bound & ha_value <= upper_bound) {
                              cat("HA:", ha_value, " - Count:", ha_counts[[as.character(ha_value)]], " - Bins:", ha_bin_names[[as.character(ha_value)]], "/n")
               }
}








file.pa=
# List of paths to your CSV files
a1=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_3_2.csv")
a=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/1_1_1.csv")
b=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/1_1_2.csv")
c=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/1_1_3.csv")
d=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/1_1_4.csv")
e=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/2_1_1.csv")
f=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/2_1_2.csv")
g=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/2_1_3.csv")
h=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/2_1_4.csv")
i=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_1_1.csv")
j=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_1_2.csv")
k=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_1_3.csv")
l=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_1_4.csv")

high1=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_3_2.csv")
high2=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/1_3_3.csv")
High3=read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_3_2.csv")



# # Extract paths from the files
# paths_file1 <- file1
# paths_file1
# # Read the contents of the text files
# file1 <- readLines("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/1_2_1/1_2_1.txt")
# file2 <- readLines("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/3_2_1/3_2_1.txt")
# Extract paths from the files
paths_file1 <- m
paths_file2 <- a1
# Convert paths to sets for comparison
# set1 <- as.character(unique(paths_file1))
# set2 <- as.character(unique(paths_file2))
# # 
# set1 <- set1[-1]
# 
# set2 <- set2[-1]
# # Find the intersection of paths
# common_paths <- intersect(set1,set2)
common_paths <- intersect(paths_file1,paths_file2)








# Read the CSV files
low2 <- read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_1_1.csv")
high1 <- read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/3_3_2.csv")

# Extract paths from the files
paths_low2 <- low2$Matching_Files
paths_high1 <- high1$Matching_Files

# Convert paths to sets for comparison
set_low2 <- as.character(unique(paths_low2))
set_high1 <- as.character(unique(paths_high1))

# Find the intersection of paths
common_paths <- intersect(set_low2, set_high1)

# Print or do further processing with common_paths
print(common_paths)
