library(readxl)
# Replace 'your_file_path.xlsx' with the actual path to your Excel file
excel_data <- read_excel("C:\\Users\\ogundipe\\Documents\\data\\visua\\Booktr.xlsx")

cnt = vector()
for(i in 1:nrow(excel_data)){
               ss = as.character(excel_data[i,grep("obs", colnames(excel_data))])
               cnt[i] = length(which(!is.na(ss)))
}
