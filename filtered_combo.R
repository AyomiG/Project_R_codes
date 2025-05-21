## combo files
library(dplyr)
filtered_combo <- combo %>% filter( has_VALPAR_SDM==1)
filtered_combo$with_dot = gsub(" ","\\.",filtered_combo$VALPAR_SDM)
grep(filtered_combo$with_dot[1], raster_files, value = TRUE)
#Initialize an empty vector to store the matching files
matching_files_vector <- character(length = nrow(filtered_data))

# Loop through each row in filtered_data
for (i in 1:nrow(filtered_combo)) {
               value <- filtered_combo$with_dot[i] 
               matching_files <- grep(value, raster_files, value = TRUE) 
               matching_files_vector[i] <- paste(matching_files, collapse = ', ')  
}
filtered_combo$Matching_Files <- matching_files_vector
# Merge the content of the three columns into one column
filtered_combo$Combined <- paste(filtered_combo$PH, ".",filtered_combo$Elevation, ".",
                                 filtered_combo$Humidity,sep = "")



# Find indices of cells in "Combined_Column" that don't have up to 3 digits at the beginning
indices <- grep("^[0-9]{1,3}\\.", filtered_combo$Combined)

# Create a sample dataframe
df <- data.frame(your_column = c("Apple", "123Banana", "Cherry", "456Grapes"))

# Use grepl to find cells that don't start with a digit
result <- grepl("^[^0-9]", filtered_combo$Combined)

# Subset the dataframe based on the condition
filtered_df <- filtered_combo[result, ]

# View the filtered dataframe
print(filtered_df)

# Use grepl to find cells that don't start with a digit
result <- grepl("^[^0-9]", filtered_combo$Combined)
# Subset the dataframe based on the condition
filtered_df <- filtered_combo[result, ]
# View the filtered dataframe
print(filtered_df)


write.csv(combo, file.path("C:\\Users\\ogundipe\\Documents\\data\\visua", "combo_.csv"))
 


uni_bins<- unique(bins[,1:4])

tst = rast(filtered_combo$Matching_Files[1:5])

sm = sum(tst)
