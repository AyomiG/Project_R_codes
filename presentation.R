library(rgl)

# Define the number of levels for each factor
num_levels_soil <- 3
num_levels_humidity <- 4
num_levels_elevation <- 3

# Define a color palette for factor levels
color_palette <- c("red", "green", "blue", "purple")

# Create a 3D scene
open3d()

# Create 3D shapes (e.g., cubes) for each factor level
for (soil in 1:num_levels_soil) {
               for (humidity in 1:num_levels_humidity) {
                              for (elevation in 1:num_levels_elevation) {
                                             x <- soil * 2  # Adjust the spacing as needed
                                             y <- humidity * 2  # Adjust the spacing as needed
                                             z <- elevation * 2  # Adjust the spacing as needed
                                             cube_color <- color_palette[soil]
                                             material3d(color = cube_color)
                                             # rgl.bbox(x = c(x - 0.5, x + 0.5), y = c(y - 0.5, y + 0.5), z = c(z - 0.5, z + 0.5))
                             
                                             rgl.bbox(xat = NULL, xlab = NULL, xunit = 0, xlen = 5, 
                                                     yat = NULL, ylab = NULL, yunit = 0, ylen = 5, 
                                                     zat = NULL, zlab = NULL, zunit = 0, zlen = 5, 
                                                     marklen = 15, marklen.rel = TRUE, 
                                                     expand = 1, draw_front = FALSE, )                   
                                             
                                             
                                             
                                             
                               }
               }
}

# Adjust the view angle
view3d(theta = 30, phi = 30, zoom = 0.8)

# Display the 3D scene
rglwidget()
# Sample data
x <- c(1, 2, 3)
y <- c(4, 5, 6)
z <- c(7, 8, 9)

# Create a 3D plot
plot3d(x, y, z, type = "s", size = 10, col = "blue", main = "3D Coordinate Plot")
# Display the 3D scene
rglwidget()
