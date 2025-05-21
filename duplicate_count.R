
# Install dplyr if necessary
install.packages("dplyr")

# Load dplyr package
library(dplyr)

# Define a function to check for duplicate rows and count them
check_and_count_duplicates <- function(file) {
               data <- read.csv(file)
               total_rows <- nrow(data)
               unique_rows <- nrow(distinct(data))
               num_duplicates <- total_rows - unique_rows
               if (num_duplicates > 0) {
                              message(paste("File", basename(file), "contains", num_duplicates, "duplicate rows."))
               }
               return(list(data = data, duplicates = num_duplicates))
}

# List all filtered CSV files
l_filtered <- l[!grepl("([0-9]_3|1_2_3|1_2_4|3_2_3)", l)]

# Check and count duplicates in each file
results <- lapply(l_filtered, check_and_count_duplicates)

# Combine the data frames from each file
combined_data <- bind_rows(lapply(results, `[[`, "data"))

# Remove duplicate rows from the combined data
combined_data_unique <- distinct(combined_data)

# Count total number of rows in unique data
total_rows <- nrow(combined_data_unique)
print(paste("Total number of unique rows:", total_rows))













































# Step 1: List all CSV files starting with a digit
l = list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/bin_", 
               pattern = "^[0-9].*\\.csv$", full.names = TRUE)

# Step 2: Filter out unwanted files
l_filtered = l[!grepl("([0-9]_3_[0-9]|1_2_3|1_2_4|3_2_3)", l)]
library(dplyr)
# Step 2: Read each CSV and combine them into a single data frame
combined_data <- lapply(l_filtered, read.csv) %>% bind_rows()

# Step 3: Remove duplicate rows to keep only unique rows
unique_data <- distinct(combined_data)

# Step 4: Count the total number of rows
total_rows <- nrow(unique_data)
print(paste("Total number of unique rows:", total_rows))

# Step 5: Write the combined and unique data to a new CSV file
write.csv(combined_data, "combined_data.csv", row.names = FALSE)
# Identify the duplicate rows (rows that appear more than once)
duplicate_rows <- combined_data %>%
               group_by_all() %>%       # Group by all columns
               filter(n() > 1) %>%      # Keep only rows that appear more than once
               ungroup()                # Ungroup to avoid group-specific operations

# Print the list of duplicate rows
print(duplicate_rows)
