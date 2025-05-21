# Load the required packages
library(dplyr)
folder_path="C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/distinct"
csv_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/grouping_outputs", pattern = "\\.csv$", full.names = TRUE)
# List all filtered CSV files
csv_files<- csv_files[!grepl("([0-9]_3_[0-9]|1_2_3|1_2_4|3_2_3)", csv_files)]
csv_files=csv_files[grepl("([0-9]_[0-9]_[0-9])", csv_files)]

# Function to process each CSV file: count unique rows and save the distinct data
process_csv_file <- function(file) {
               # Read the CSV file into a data frame
               df <- read.csv(file)
               
               # Remove duplicate rows and keep distinct rows
               unique_df <- df %>% distinct()
               
               # Count total and unique rows
               total_rows <- nrow(df)
               unique_row_count <- nrow(unique_df)
               
               # Print the results
               cat(file, "has", unique_row_count, "unique rows out of", total_rows, "total rows.\n")
               
               # Save the distinct data into a new CSV file (in the same folder or another folder)
               output_file <- file.path(folder_path, paste0("distinct_", basename(file)))
               write.csv(unique_df, output_file, row.names = FALSE)
}

# Loop through each CSV file in the folder, process, and save distinct rows
for (csv_file in csv_files) {
               process_csv_file(csv_file)
}
