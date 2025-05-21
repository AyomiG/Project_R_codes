# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
                           pattern = "*.tif", full.names = TRUE)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
filtered_data2$Filename =NA
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)

# raster_list=list()
# 
# for (file in raster_files) {
#                image <- raster(file)
#                 raster_list[[file]] <- image
# }
# 
# # Load the raster package
# library(raster)
# data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep.csv")
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)
bins <- bins[,1:5]
head(bins)
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
head(uni_bins)
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv", stringsAsFactors = FALSE)
uni_bins<- unique(bins[,1:4])
bins <- na.omit(bins[,1:5])
uni_bins<- unique(bins[,1:4])
uni_bins <- uni_bins[which(uni_bins$hab != ""),]
head(uni_bins)
dim(uni_bins)
View(uni_bins)
head(spec)
summary(spec)
combo <- merge(spec, uni_bins, by.x = "TypoCH", by.y = "hab")
combo <- merge(spec, uni_bins, by.x = "TypoCH2", by.y = "hab")
View(combo)
filtered_data2
# library(raster)
raster_files <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",
pattern = "*.tif", full.names = TRUE)
filered_data2$Filename =NA
filtered_data2$Filename =NA
filtered_data2
?grep
grep(filtered_data2$VALPAR_SDM[1], raster_files, value = TRUE)
head(raster_files)
filtered_data2$with_dot = gsub(" ","\\.",filtered_data2$VALPAR_SDM)
head(filtered_data2)
grep(filtered_data2$with_dot[1], raster_files, value = TRUE)
data <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
spec <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\allSp_FloraO_inclZielarte.csv")
bins <- read.csv("C:\\Users\\ogundipe\\Documents\\data\\visua\\dataprep1.csv")
View(bins)

# # Create a list of tiff images
# tiff_images <- list.files("C:\\Users\\ogundipe\\Documents\\data\\visua\\daten_UNIL",pattern = "*.tif")
# 
# # Search for the tiff images with the names "my_image.tif" and "your_image.tif"
# tiff_images <- grep("Chara", raster_list,value = TRUE)
# 
# tiff_images
# # Print the list of tiff images
# print(tiff_images)
# plot(tiff_images)
# plot.window()
# plot(tiff_images)

filename <- basename(raster_files)
selname  <- which(grepl("Chara", filename))
Chafile <- raster_files[selname]
Charasters <- terra::rast(Chafile)
# Sum the raster layers
sum_raster <- Charasters[[1]]+Charasters[[2]]+Charasters[[3]]+Charasters[[5]]

# Visualize the summed raster
plot(sum_raster)

filtered_data2
