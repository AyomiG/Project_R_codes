
data <- read_excel("C:\\Users\\ogundipe\\Documents\\data\\visua\\Booktr.xlsx", sheet = 4)

# Create a new data frame to store filtered cells
filtered_data <- data

# Loop through rows and columns of the data frame

# for (i in 1:nrow(data)) {
#                for (j in 1:ncol(data)) {
#                               cell_content <- as.character(data[i, j])
#                               if (!is.na(cell_content) && startsWith(cell_content, "1.")) {
#                                              filtered_data[i, j] <- cell_content
#                               } else {
#                                              filtered_data[i, j] <- ""
#                               }
#                }
# }
# 

# # Print the filtered data
# print(filtered_data)
# # Save a data frame as a CSV file
# write.csv(filtered_data, "output_file.csv", row.names =T)
# 




# Loop through rows and columns of the data frame

for (i in 1:nrow(data)) {
               for (j in 1:ncol(data)) {
                              cell_content <- as.character(data[i, j])
                              if (!is.na(cell_content) && grepl("^[2-8]\\.", cell_content)) {
                                             filtered_data2[i, j] <- cell_content
                              } else {
                                             filtered_data2[i, j] <- ""
                              }
               }
}

# Print the filtered data
print(filtered_data2)

# Save a data frame as a CSV file
write.csv(filtered_data2, "C:\\Users\\ogundipe\\Documents\\data\\visua\\output_file2.csv", row.names = TRUE)






