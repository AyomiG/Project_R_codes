# Load necessary library
library(readr)
library(dplyr)
# List all CSV files in the directory
csv_files <- list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_/grouping_outputs", pattern = "*.csv", full.names=T)

# Create an empty data frame to store results
results <- data.frame(File = character(), Group = character(), Count = integer(), stringsAsFactors = FALSE)

# Loop through each CSV file and count the occurrences of each group
for (file in csv_files) {
               data <- read_csv(file)
               group_counts <- data %>%
                              group_by(`corresponding_groups`) %>%
                              summarize(Count = n()) %>%
                              mutate(File = file)
               
               results <- rbind(results, group_counts)
}

# Write the results to a new CSV file
write.csv(results, "group_counts_in_each_file.csv", row.names = FALSE)
