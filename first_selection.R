parent_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/comb_ras/"
o_dir <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/rescaled_comb"
# Get the list of files ending with "masked_*.tif"
masked_files <- list.files(parent_dir, pattern = ".tif", full.names = TRUE)
# Loop over the list of raster paths
for (path in masked_files) {
# Load masked raster
masked_map <- rast(path)
# Scaling operation
ac_q <- quantile(values(masked_map), probs = seq(0, 1, 0.01), na.rm = TRUE)
vls_sc <- cut(values(masked_map), breaks = ac_q)
vls_sc <- as.numeric(vls_sc)
resc_map <- masked_map
values(resc_map) <- vls_sc
# # Save the scaled raster with the same identifier
# #identifier <- gsub('.*/masked75_(\\d+_\\d+_\\d+).*', '\\1', path)
# identifier <- gsub('.*/masked321_(\\d+_\\d+_\\d+).*', '\\1', path)
#output_path <- file.path(parent_dir, paste0("scaled75_", identifier, ".tif"))
output_path <- file.path(o_dir, basename(path))
writeRaster(resc_map, output_path, overwrite = TRUE)
}
resc_map
selected_areas <- list()
bin_complementarity <- "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results/rescaled_comb"
for (i in seq_along(bin_complementarity)) {
# Load complementarity raster for current bin
complementarity_raster <- raster(bin_complementarity[i])
# Subset raster to select areas with complementarity values ranging from 80 to 100
selected_raster <- complementarity_raster
selected_raster[complementarity_raster < 80 | complementarity_raster > 100] <- NA
# Add the bin number to the raster attributes
#selected_raster$bin <- i
# Append selected areas to the list
selected_areas[[i]] <- selected_raster
}

