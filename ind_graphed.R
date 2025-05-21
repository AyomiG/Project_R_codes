rm(list = ls(all = TRUE))
library(rgeos)
library(RColorBrewer)
library(terra)

# con=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Mean_delta_H.tif")
# comp=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_2_1.tif")
# # mat now contains the calculated values based on your dataset


comp<- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/masked_7518/scaled/3_2_1.tif")
con <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/3_2_1.tif")

xt=ext(comp)
# Extract values
values1 <- extract(con, xt, cells = TRUE, xy = TRUE)
values2 <- extract(comp, xt, cells = TRUE, xy = TRUE)
data <- data.frame(con = values1, comp= values2)


# mat now contains the calculated values based on your dataset
data<- na.omit(data)
data$result<-sqrt(data[, 4]^2 + data[, 8]^2)
cols<-colorRampPalette(brewer.pal(9,'BuGn'))
cols1<-cols(141)
data$cols<-cols1[floor(data$result)]

# output_folder <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results"
# plot_filename <- file.path(output_folder, paste0("plot_test", ".png"))
# png(plot_filename)
# dev.copy(png, plot_filename)
plot(data[, 4], data[, 8],col=data$cols)

dev.off()
