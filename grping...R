
# List all CSV files in the directory
csv_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/grouping_outputs", pattern = "\\.csv$", full.names = TRUE)

# Initialize an empty list to store dataframes
dfs <- list()

# Define the groups
groups <- c('Fauna', 'Flechten', 'Flora', 'Moose', 'Pilze', 'ZA_Moore', 'ZA_TWW')

# Iterate through each CSV file
for (file in csv_files) {
               # Read CSV file into a dataframe
               df <- read.csv(file)
               
               # Initialize empty vectors to store matching rows and corresponding group values
               matching_rows <- logical(nrow(df))
               corresponding_groups <- character(nrow(df))
               
               # Iterate through each group
               for (group in groups) {
                              # Identify matching rows
                              matching <- df$Matching.Files == group
                              # Update matching rows vector
                              matching_rows <- matching_rows | matching
                              # Update corresponding groups vector for matching rows
                              corresponding_groups[matching] <- ifelse(matching, df$`Matching.Files.1`, NA)
               }
               
               # Check if any matching rows were found
               if (any(matching_rows)) {
                              # Create a dataframe with matching rows and corresponding group values
                              df_selected <- data.frame(Matching_Rows = matching_rows, Corresponding_Groups = corresponding_groups)
                              # Append dataframe to the list
                              dfs <- c(dfs, list(df_selected))
               }
}

# Check if any dataframes were added to the list
if (length(dfs) > 0) {
               # Concatenate all dataframes into a single dataframe
               merged_df <- do.call(rbind, dfs)
               
               # Specify the path to the folder where you want to save the merged data
               folder_path <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/grouping_outputs"
               
               # Write the merged dataframe to a new CSV file in the specified folder
               write.csv(merged_df, file.path(folder_path, "merged_data.csv"), row.names = FALSE)
} else {
               print("No matching rows found.")
}
