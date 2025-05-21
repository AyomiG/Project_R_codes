
# Load your raster map
main_map <- rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/New folder/acidic.tif")

# Load water bodies, protected areas, and cantons in vector format
lakes_rivers<-  vect("C:/Users/ogundipe/Downloads/swisstlm3d_2023-03_2056_5728.shp/TLM_GEWAESSER/wasser_poly.shp")
protected_areas <-  rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/CPA.tif")
cantons  <-   vect("C:/Users/ogundipe/Downloads/swissboundaries3d_2019-01_2056_5728.shp/swissBOUNDARIES3D_1_5_TLM_KANTONSGEBIET.shp")  # Replace with your actual file path
crs_new <- "+proj=epsg:21781"
# Change raster CRS to EPSG:21781
main_map <- project(main_map, "epsg:21781")
protected_areas=project(protected_areas, "epsg:21781")
cantons  <- project(cantons, "epsg:21781")





# Masking operations
pr <-  rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/CPA.tif")
# Extract Zurich canton polygon
zurich_canton <-  cantons[cantons$NAME == "Zürich", ]
main_map <- crop(main_map, ext(zurich_canton))

# Create Zurich canton raster
zurich_canton_raster <- rasterize(zurich_canton, main_map,field="NAME" )

# Mask raster using Zurich canton raster
masked_raster <- mask(main_map, zurich_canton_raster)

# Mask raster using protected areas raster
protected_areas = crop(protected_areas, ext(masked_raster))
# Set the values of protected areas in the priority map to NA
masked_raster[protected_areas > 0] <- NA


# # Extract lakes and rivers with area <= 1 ha
# filtered_lakes_rivers <- lakes_rivers[lakes_rivers$area > 1, ]
# lakes=rasterize(filtered_lakes_rivers, main_map,field="area")
# ext(masked_raster)=ext(lakes)
# final <- mask(masked_raster, lakes,inverse=T)
# plot(final)
# final

# Mask raster using filtered lakes and rivers polygons
# final <- mask(masked_raster, filtered_lakes_rivers)
# Mask raster using filtered lakes and rivers polygons
water_bodies=rast("C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\LU-CH_2018all.tif")
water_bodies1=project(water_bodies,"epsg:21781")
water_bodies1[water_bodies1!=61 & water_bodies1!=62]=NA
water_bodies1 = crop(water_bodies1, ext(masked_raster))
final_map <- mask(masked_raster,water_bodies1, inverse=T)
value <- quantile(values(final_map), na.rm = TRUE)
# Assuming you have a raster object called 'myRaster'
# Replace 'myRaster' with the actual name of your raster object
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas", "acidic.tif")
writeRaster(final_map , output, overwrite = TRUE)
