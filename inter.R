##paths
file1 <- readLines("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_file/1_2_3.txt")
file2 <- readLines("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_file/3_1_3.txt")
# Remove extra double quotes and backslashes
paths_file1 <- i
# Convert paths to sets for comparison
# set1 <- as.character(unique(file1))
# set2 <- as.character(unique(file2))
# #
# set1 <- set1[-1]
#
# set2 <- set2[-1]
# # Find the intersection of paths
common_paths7<- intersect(file1,file2)
# # Extract paths from the files
# paths_file1 <- file1
# paths_file1
# # Read the contents of the text files
# file1 <- readLines("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/1_2_1/1_2_1.txt")
