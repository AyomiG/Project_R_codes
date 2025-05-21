library(magick)
library(grid)
library(gridExtra)

# Define image paths
image_paths<- c(
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_4.png"
)


image_paths <- c(
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_4.png"
)

image_paths <- gsub("icon_pn", "icomp_pn", image_paths)

output_file <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/composite_panel.png"

# Read images and create grobs
labels <- letters[1:9]
image_grobs <- lapply(image_paths, function(path) {
               img <- image_read(path)
               raster <- as.raster(img)
               rasterGrob(raster, interpolate = FALSE)
})

# Export to file
png(output_file, width = 3000, height = 3000, res = 600)

# Layout setup
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 4, 
                                           widths = unit.c(unit(1, "lines"), unit(rep(1, 3), "null")),
                                           heights = unit.c(unit(1, "lines"), unit(rep(1, 3), "null")))))

# Column and row labels
col_titles <- c("Acidic", "Neutral", "Alkaline")
row_titles <- c("Wet", "Moist", "Dry")

for (i in 1:3) {
               grid.text(col_titles[i], vp = viewport(layout.pos.row = 1, layout.pos.col = i + 1),
                         gp = gpar(fontsize = 14))
}

for (i in 1:3) {
               grid.text(row_titles[i], rot = 90, vp = viewport(layout.pos.row = i + 1, layout.pos.col = 1),
                         gp = gpar(fontsize = 14))
}

# Draw all images and labels
k <- 1
for (row in 1:3) {
               for (col in 1:3) {
                              # Push to the correct viewport
                              pushViewport(viewport(layout.pos.row = row + 1, layout.pos.col = col + 1))
                              
                              # Draw the image
                              grid.draw(image_grobs[[k]])
                              
                              # Add the label
                              grid.text(labels[k], x = 0.05, y = 0.95, just = c("left", "top"), 
                                        gp = gpar(fontsize = 10))
                              
                              # Pop back to parent viewport
                              popViewport()
                              
                              k <- k + 1
               }
}

dev.off()  # Save the file






# the mid elevations


image_paths <- c(
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_2_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_2_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_2_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_2_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_2_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_2_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_2_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_2_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_2_4.png"
)

output_file <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/composite_medpanel.png"

# Placeholder for missing images
placeholder_grob <- function() {
               grobTree(
                              rectGrob(gp = gpar(col = "gray90", fill = "white", lwd = 1)),
                              textGrob("N/A", gp = gpar(col = "gray30", fontsize = 12))
               )
}
# Read images and create grobs
labels <- letters[1:9]
image_grobs <- lapply(image_paths, function(path) {
               if (file.exists(path)) {
                              img <- image_read(path)
                              raster <- as.raster(img)
                              rasterGrob(raster, interpolate = FALSE)
               } else {
                              placeholder_grob()
               }
})

# Export to file
png(output_file, width = 3000, height = 3000, res = 600)

# Layout setup
grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 4, 
                                           widths = unit.c(unit(1, "lines"), unit(rep(1, 3), "null")),
                                           heights = unit.c(unit(1, "lines"), unit(rep(1, 3), "null")))))

# Column and row labels
col_titles <- c("Acidic", "Neutral", "Alkaline")
row_titles <- c("Wet", "Moist", "Dry")

for (i in 1:3) {
               grid.text(col_titles[i], vp = viewport(layout.pos.row = 1, layout.pos.col = i + 1),
                         gp = gpar(fontsize = 14))
}

for (i in 1:3) {
               grid.text(row_titles[i], rot = 90, vp = viewport(layout.pos.row = i + 1, layout.pos.col = 1),
                         gp = gpar(fontsize = 14))
}

# Draw all images and labels
k <- 1
for (row in 1:3) {
               for (col in 1:3) {
                              pushViewport(viewport(layout.pos.row = row + 1, layout.pos.col = col + 1))
                              grid.draw(image_grobs[[k]])
                              grid.text(labels[k], x = 0.05, y = 0.95, just = c("left", "top"), gp = gpar(fontsize = 10))
                              popViewport()
                              k <- k + 1
               }
}

dev.off()



##combined map

library(grid)
library(magick)

# Image paths
image_paths <- c(
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/nc/C_Comp.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/nc/C_Con.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Common_D.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/nc/R_Comp.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/nc/R_con.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Rare_D.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Comp_D.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Conn_D.png"
)

output_file <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/new_I/Dif/Final.png"

# Placeholder for missing images
placeholder_grob <- function() {
               grobTree(
                              rectGrob(gp = gpar(col = "gray90", fill = "white", lwd = 1))
               )
}

# Read and convert images
labels <- letters[1:8]
image_grobs <- lapply(image_paths, function(path) {
               if (file.exists(path)) {
                              img <- image_read(path)
                              raster <- as.raster(img)
                              rasterGrob(raster, interpolate = FALSE)
               } else {
                              placeholder_grob()
               }
})

# Save plot to file
png(output_file, width = 3000, height = 3000, res = 600)

# Create layout with more margin space
grid.newpage()
pushViewport(viewport(layout = grid.layout(
               4, 4,
               widths = unit.c(unit(3, "lines"), unit(rep(1, 3), "null")),   # wider left margin
               heights = unit.c(unit(2, "lines"), unit(rep(1, 3), "null"))   # taller top margin
)))

# Titles
col_titles <- c("Complementarity", "Connectivity", "Difference")
row_titles <- c("Common habitat", "Rare habitat", "Difference")

# Column labels (top)
for (i in 1:3) {
               grid.text(col_titles[i],
                         vp = viewport(layout.pos.row = 1, layout.pos.col = i + 1),
                         gp = gpar(fontsize = 14))
}

# Row labels (left, vertical)
for (i in 1:3) {
               grid.text(row_titles[i],
                         rot = 90,
                         vp = viewport(layout.pos.row = i + 1, layout.pos.col = 1),
                         gp = gpar(fontsize = 14),
                         just = "centre")
}

# Draw image grid
k <- 1
for (row in 1:3) {
               for (col in 1:3) {
                              pushViewport(viewport(layout.pos.row = row + 1, layout.pos.col = col + 1))
                              
                              if (k <= length(image_grobs)) {
                                             grid.draw(image_grobs[[k]])
                                             grid.text(labels[k], x = 0.05, y = 0.95, just = c("left", "top"), gp = gpar(fontsize = 10))
                              } else {
                                             grid.draw(placeholder_grob())
                                             grid.text(labels[k], x = 0.05, y = 0.95, just = c("left", "top"), gp = gpar(fontsize = 10))
                              }
                              
                              popViewport()
                              k <- k + 1
               }
}

dev.off()






library(magick)
library(grid)
library(gridExtra)

# Image paths (using your original paths)
image_paths <- c(
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_pn/1_1_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_4.png",
               "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua - Copy\\increased_plot\\I_114.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_pn/2_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_2.png",
               "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua - Copy\\increased_plot\\I_212.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_pn/3_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_1.png",
               "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua - Copy\\increased_plot\\I_311.png"
)

# Output path - switched to landscape format
output_file <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/Relationship_panel_landscape.png"

# Labels for images (non-bold)
labels <- letters[1:9]

# Create a function to read the image and get its dimensions
get_image_info <- function(path) {
               img <- image_read(path)
               info <- image_info(img)
               return(list(img = img, width = info$width, height = info$height))
}

# Read all images first to gather information
image_info <- lapply(image_paths, get_image_info)

# Group images by column (every 3rd image belongs to the same column)
col1_imgs <- image_info[seq(1, 9, 3)]
col2_imgs <- image_info[seq(2, 9, 3)]
col3_imgs <- image_info[seq(3, 9, 3)]

# Function to create a labeled image grob with specified dimensions
create_labeled_image <- function(image_obj, label, width, height) {
               # Resize image to the specified dimensions
               img <- image_scale(image_obj$img, paste0(width, "x", height))
               
               # Convert to raster
               raster_img <- as.raster(img)
               
               # Create grob with the label (removed bold formatting)
               grob <- rasterGrob(raster_img, interpolate = TRUE)
               
               # Return a labeled grob with non-bold text
               return(annotateGrob(grob, label, x = 0.05, y = 0.95, just = c("left", "top"), 
                                   gp = gpar(fontsize = 14, col = "black")))
}

# Helper function to annotate grobs with text
annotateGrob <- function(grob, label, x, y, just, gp) {
               gTree(children = gList(
                              grob,
                              textGrob(label, x = x, y = y, just = just, gp = gp)
               ))
}

# Set base sizes for columns (optimized for landscape format)
# Giving even more space to the relationship column
col_widths <- c(0.8, 0.8, 1.4)  # Relationship column is now 1.4x larger

# Calculate sizes maintaining aspect ratios while respecting column width ratios
base_width <- 600  # Increased base width for landscape

# Calculate dimensions for each column
col1_width <- base_width * col_widths[1]
col2_width <- base_width * col_widths[2]
col3_width <- base_width * col_widths[3]

# Create image grobs with adjusted sizes
image_grobs <- list()

# First column images
for (i in 1:3) {
               aspect_ratio <- col1_imgs[[i]]$height / col1_imgs[[i]]$width
               height <- col1_width * aspect_ratio
               image_grobs[[(i-1)*3 + 1]] <- create_labeled_image(col1_imgs[[i]], labels[(i-1)*3 + 1], col1_width, height)
}

# Second column images
for (i in 1:3) {
               aspect_ratio <- col2_imgs[[i]]$height / col2_imgs[[i]]$width
               height <- col2_width * aspect_ratio
               image_grobs[[(i-1)*3 + 2]] <- create_labeled_image(col2_imgs[[i]], labels[(i-1)*3 + 2], col2_width, height)
}

# Third column images (relationship plots) - make these larger
for (i in 1:3) {
               aspect_ratio <- col3_imgs[[i]]$height / col3_imgs[[i]]$width
               height <- col3_width * aspect_ratio
               image_grobs[[(i-1)*3 + 3]] <- create_labeled_image(col3_imgs[[i]], labels[(i-1)*3 + 3], col3_width, height)
}

# Set up title grobs
col_titles <- c("Complementarity", "Connectivity", "Relationship")
row_titles <- c("Acidic/Dry", "Neutral/Moist", "Alkaline/Wet")

# Create title grobs - column titles with bold, but not too large
col_title_grobs <- lapply(1:3, function(i) {
               textGrob(col_titles[i], gp = gpar(fontsize = 16, fontface = "bold"))
})

# Row titles with bold but not too large
row_title_grobs <- lapply(row_titles, function(title) {
               textGrob(title, rot = 90, gp = gpar(fontsize = 16, fontface = "bold"))
})

# Create the layout - landscape dimensions (wider than tall)
png(output_file, width = 3600, height = 2100, res = 300)
grid.newpage()

# Set up the layout widths according to our ratios (with space for row titles)
widths <- c(0.15, col_widths[1], col_widths[2], col_widths[3])
heights <- c(0.15, 1, 1, 1)

# Draw using layout
pushViewport(viewport(layout = grid.layout(nrow = 4, ncol = 4, 
                                           widths = unit(widths, "null"),
                                           heights = unit(heights, "null"))))

# Draw column titles
for (i in 1:3) {
               pushViewport(viewport(layout.pos.row = 1, layout.pos.col = i + 1))
               grid.draw(col_title_grobs[[i]])
               popViewport()
}

# Draw row titles
for (i in 1:3) {
               pushViewport(viewport(layout.pos.row = i + 1, layout.pos.col = 1))
               grid.draw(row_title_grobs[[i]])
               popViewport()
}

# Draw images with their new sizes
for (row in 1:3) {
               for (col in 1:3) {
                              img_idx <- (row - 1) * 3 + col
                              pushViewport(viewport(layout.pos.row = row + 1, layout.pos.col = col + 1))
                              grid.draw(image_grobs[[img_idx]])
                              popViewport()
               }
}

dev.off()









library(magick)
library(grid)
library(gridExtra)

# Image paths (using your original paths)
image_paths <- c(
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_pn/1_1_4.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/1_1_4.png",
               "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua - Copy\\increased_plot\\114n.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_pn/2_1_2.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/2_1_2.png",
               "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua - Copy\\increased_plot\\212n.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icomp_pn/3_1_1.png",
               "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/3_1_1.png",
               "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua - Copy\\increased_plot\\311n.png"
)

# Output path
output_file <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/icon_pn/Relationship_panel_adjusted.png"

# Labels for images
labels <- letters[1:9]

# Create a function to read the image and get its dimensions
get_image_info <- function(path) {
               img <- image_read(path)
               info <- image_info(img)
               return(list(img = img, width = info$width, height = info$height))
}

# Read all images first to gather information
image_info <- lapply(image_paths, get_image_info)

# Group images by column (every 3rd image belongs to the same column)
col1_imgs <- image_info[seq(1, 9, 3)]
col2_imgs <- image_info[seq(2, 9, 3)]
col3_imgs <- image_info[seq(3, 9, 3)]

# Function to create a labeled image grob with specified dimensions
create_labeled_image <- function(image_obj, label, width, height) {
               # Resize image to the specified dimensions
               img <- image_scale(image_obj$img, paste0(width, "x", height))
               
               # Convert to raster
               raster_img <- as.raster(img)
               
               # Create grob with the label
               grob <- rasterGrob(raster_img, interpolate = TRUE)
               
               # Return a labeled grob
               return(annotateGrob(grob, label, x = 0.05, y = 0.95, just = c("left", "top"), 
                                   gp = gpar(fontsize = 10,col = "black")))
}

# Helper function to annotate grobs with text
annotateGrob <- function(grob, label, x, y, just, gp) {
               gTree(children = gList(
                              grob,
                              textGrob(label, x = x, y = y, just = just, gp = gp)
               ))
}

# Set base sizes for columns (giving more space to the last column)
# Modified width ratio: first two columns narrower, third column wider
col_widths <- c(0.85, 0.85, 1.3)  # Relationship column is now 1.3x larger

# Calculate sizes maintaining aspect ratios while respecting column width ratios
base_width <- 500

# Calculate dimensions for each column
col1_width <- base_width * col_widths[1]
col2_width <- base_width * col_widths[2]
col3_width <- base_width * col_widths[3]

# Create image grobs with adjusted sizes
image_grobs <- list()

# First column images
for (i in 1:3) {
               aspect_ratio <- col1_imgs[[i]]$height / col1_imgs[[i]]$width
               height <- col1_width * aspect_ratio
               image_grobs[[(i-1)*3 + 1]] <- create_labeled_image(col1_imgs[[i]], labels[(i-1)*3 + 1], col1_width, height)
}

# Second column images
for (i in 1:3) {
               aspect_ratio <- col2_imgs[[i]]$height / col2_imgs[[i]]$width
               height <- col2_width * aspect_ratio
               image_grobs[[(i-1)*3 + 2]] <- create_labeled_image(col2_imgs[[i]], labels[(i-1)*3 + 2], col2_width, height)
}

# Third column images (relationship plots) - make these larger
for (i in 1:3) {
               aspect_ratio <- col3_imgs[[i]]$height / col3_imgs[[i]]$width
               height <- col3_width * aspect_ratio
               image_grobs[[(i-1)*3 + 3]] <- create_labeled_image(col3_imgs[[i]], labels[(i-1)*3 + 3], col3_width, height)
}

# Set up title grobs
col_titles <- c("Complementarity", "Connectivity", "Relationship")
row_titles <- c("Acidic/Dry", "Neutral/Moist", "Alkaline/Wet")

# Create title grobs with consistent sizing
col_title_grobs <- lapply(1:3, function(i) {
               textGrob(col_titles[i], gp = gpar(fontsize = 14))
})

row_title_grobs <- lapply(row_titles, function(title) {
               textGrob(title, rot = 90, gp = gpar(fontsize = 14))
})

# Create the layout
png(output_file, width = 2400, height = 2400, res = 300)
grid.newpage()

# Set up the layout widths according to our ratios (with space for row titles)
widths <- c(0.15, col_widths[1], col_widths[2], col_widths[3])
heights <- c(0.15, 1, 1, 1)

# Draw using layout
pushViewport(viewport(layout = grid.layout(nrow = 4, ncol = 4, 
                                           widths = unit(widths, "null"),
                                           heights = unit(heights, "null"))))

# Draw column titles
for (i in 1:3) {
               pushViewport(viewport(layout.pos.row = 1, layout.pos.col = i + 1))
               grid.draw(col_title_grobs[[i]])
               popViewport()
}

# Draw row titles
for (i in 1:3) {
               pushViewport(viewport(layout.pos.row = i + 1, layout.pos.col = 1))
               grid.draw(row_title_grobs[[i]])
               popViewport()
}

# Draw images with their new sizes
for (row in 1:3) {
               for (col in 1:3) {
                              img_idx <- (row - 1) * 3 + col
                              pushViewport(viewport(layout.pos.row = row + 1, layout.pos.col = col + 1))
                              grid.draw(image_grobs[[img_idx]])
                              popViewport()
               }
}

dev.off()



# Uncomment to use the arrangeGrob approach instead
# png(output_file, width = 2400, height = 2400, res = 300)
# grid.draw(create_panel_with_adjusted_cols())
# dev.off()