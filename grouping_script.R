library(tidyverse)
library(stringr)

# Read the CSV file
reference_data <- read.csv("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua - Copy/allSp_FloraO_inclZielarte.csv",
                 col.names = c("sn", "Group", "Orig_Name", "TAXONIDCH", "TypoCH2", "VALPAR_SDM", "has_VALPAR_SDM"))

# Convert Orig_Name column to an array of strings
reference_Orig_Names <- as.character(reference_data$VALPAR_SDM)

# Directory path
directory <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_"

# List all csv files in the directory
csv_files <- list.files(directory, pattern = "\\.csv$", full.names = TRUE)

output_directory <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/grouping_outputs"

# Loop through each csv file
for (csv_file in csv_files) {
               data <- read_csv(csv_file)
               # Extract basename from each row starting from second row
               basenames <- data[-1, 1]
               # Define the regex pattern
               pattern <- ".*/([^_]+)_.*"
               # Apply the regex pattern to each string in the array
               extracted_text <- sapply(basenames, function(x) {
                              sub(pattern, "\\1", x)
               })
               
               extracted_text <- iconv(extracted_text, "ASCII", "UTF-8", sub = "byte")
               reference_Orig_Names <- iconv(reference_Orig_Names, "ASCII", "UTF-8", sub = "byte")
               
               
               # Remove spaces in each string of extracted_text
               extracted_text_no_space <- gsub(" ", "", extracted_text)
               
               # Remove spaces in each string of reference_Orig_Names
               reference_Orig_Names <- gsub(" ", "", reference_Orig_Names)

               # Find indices of orig_names in Orig_Name column
               indices <- match(extracted_text_no_space, reference_Orig_Names)
               
               # Extract corresponding Group values
               corresponding_groups <- reference_data$Group[indices]
               
               # Convert corresponding_groups to a factor to ensure all groups are accounted for
               corresponding_groups_factor <- factor(corresponding_groups)
               
               # Count the occurrences of each group
               group_counts <- as.list(table(corresponding_groups_factor))
               
               # Convert the result to a named list (dictionary-like structure)
               group_counts_dict <- as.list(group_counts)

               
               
               # Create a data frame with extracted_text, basenames, and corresponding_groups
               result_df <- data.frame(extracted_text = extracted_text, basenames = basenames, corresponding_groups = corresponding_groups)
               
               # Define the output filename with "_withgrouping" at the end
               output_filename <- paste0(sub(".*/([^/]+)\\.csv$", "\\1_withgrouping.csv", csv_file))
               
               # Construct the full path for the output file
               output_file <- file.path(output_directory, output_filename)
               
               # write to directory
               write.csv(result_df, file = output_file, row.names = FALSE)
               
               # Convert group_counts_dict to a data frame
               group_counts_df <- data.frame(Group = names(group_counts_dict), Count = unlist(group_counts_dict))
               
               # Append the data frame to the end of the existing output_file
               write.table(group_counts_df, file = output_file, append = TRUE, sep = ",", col.names = !file.exists(output_file), row.names = FALSE)
               
}

