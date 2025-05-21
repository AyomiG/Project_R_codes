#grouped combine


# load required packages
rm(list = ls(all = TRUE))
library(terra)

# Set the path to the parent directory containing the 36 folders
parent_dir <-"C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/com_results"

#parent_dir <- "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\masked_areas\\glo_masked18\\scaled"
#parent_dir <- "C:\\Users\\ogundipe\\Documents\\OneDrive - Eidg. Forschungsanstalt WSL\\visua\\new_data\\masked_areas\\avg_masked18\\scaled"

# Get the list of folders containing the rasters
# folders <- list.files(parent_dir, recursive = T, full.names = TRUE)
# rankmap_files <- list.files(parent_dir,  pattern = "scaled75_", full.names = TRUE)
rankmap_files <- list.files(parent_dir,  pattern = ".tif", full.names = TRUE)
# Filter files from subfolders starting with "1"
selected_files=rankmap_files[grep("1_[0-9]_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "acidic.tif")
writeRaster(mean_raster , output,overwrite=TRUE)

selected_files=rankmap_files[grep("3_[0-9]_[0-9]", rankmap_files )]
# this will work fine
# names(selected_files) <- seq_along(selected_files)
# Read selected rankmap files into a raster stack
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "alkaline.tif")
writeRaster(mean_raster , output,overwrite=TRUE)










##Elevation
selected_files <- rankmap_files[grep("[0-9]_1_[0-9]", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "lowE.tif")
writeRaster(mean_raster , output,overwrite=TRUE)



selected_files <- rankmap_files[grep("[0-9]_2_[0-9]", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "modE.tif")
writeRaster(mean_raster , output,overwrite=TRUE)

#humid
# Set the path to the parent directory

selected_files <- rankmap_files[grep("[0-9]_[0-9]_2", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "moist.tif")
writeRaster(mean_raster , output,overwrite=TRUE)


selected_files <- rankmap_files[grep("[0-9]_[0-9]_4", rankmap_files )]
raster_stack <- rast(selected_files)
#Calculate the sum and mean of the raster stack
mean_raster <- mean(raster_stack)
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "dry.tif")
writeRaster(mean_raster , output,overwrite=TRUE)




##Differences
Dif=list.files("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", full.names = T)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/dry.tif" )    
m_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/modE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/moist.tif")


PH=acidic-alkaline
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "Dif_PH.tif")
writeRaster(PH, output,overwrite=TRUE)

Ele=m_ele-l_ele
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "Dif_Ele.tif")
writeRaster(Ele , output,overwrite=TRUE)

humidity=moist-dry
output=file.path("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg", "Dif_Hum.tif")
writeRaster(humidity , output,overwrite=TRUE)




















rm(list = ls(all = TRUE))
library(geos)
library(RColorBrewer)
library(terra)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/dry.tif" )    
m_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/modE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/moist.tif")


Dif_Ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/Dif_Ele.tif")
Dif_Hum=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/Dif_Hum.tif")
Dif_PH=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/jg/Dif_PH.tif")


xt=ext(acidic)
# Load elevation
elev=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Elevation_25.tif")
elev=terra::project(elev,acidic)
elev<- resample(elev, acidic, method = "bilinear")
# Crop elelvation
telev=crop(elev,xt)
# telev = disagg(telev,fact=6,method="bilinear")
# telev=telev/10
telev <- mask(telev, acidic)


# Prepare hillshade
slp <- terrain(telev, v = "slope", unit="radians")
asp <- terrain(telev, v = "aspect", unit="radians")
hillshd <-shade(slp, asp,direction=315)
# Resample hillshade to match Zurich raster
# zurich_canton_raster <- rasterize(zurich_canton, elev, field = "NAME")
hill_resampled <- resample(hillshd, acidic, method = "bilinear")
hillsh = crop(hill_resampled,xt)
hillsh <- mask(hillsh, acidic)
hillcol=colorRampPalette(c("#00000000","#000000DA"),alpha=TRUE)
##water
Waterbodiess=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess = crop(Waterbodiess, xt)
# 
# Define a custom color ramp from light red to bright red
#colors <- colorRampPalette(c("#FFB6C1", "#FF0000"))

#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)


# 
ss_pa=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75/acidic.tif")
ss_pa=terra::project(ss_pa,acidic)
ss_pa = crop(ss_pa, xt)

ss_pak=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75/alkaline.tif")
ss_pak=terra::project(ss_pak,acidic)
ss_pak= crop(ss_pak,xt)

ss_pad=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75/dry.tif")
# ss_pad==terra::project(ss_pad,acidic)
ss_pad<- terra::project(ss_pad, "epsg:21781")
ss_pad = crop(ss_pad,xt)

ss_pah=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75/mod.tif")
ss_pah=terra::project(ss_pah,acidic)
ss_pah = crop(ss_pah, xt)

ss_pal=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75/low.tif")
ss_pal=terra::project(ss_pal,acidic)
ss_pal = crop(ss_pal, xt)

ss_pam=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_75/aci_75/moist.tif")
ss_pam=terra::project(ss_pam,acidic)
ss_pam = crop(ss_pam, xt)





# # Identify overlapping cells 
# overlaps <-rast("C:/Users/ogundipe/Documents/count.tif")

### =========================================================================
### Plot
### =========================================================================
# Define color
# cli = brewer.pal(9,"YlOrRd")
cli = brewer.pal(9,"BuGn")
clsi = colorRampPalette(cli)(141)

et=brewer.pal(9,"PuOr")
etc<- colorRampPalette(et)(141)
# Generate colors from the palette
wc=c("darkblue","skyblue")


# # # Define File name
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/75_NB.png"
# # # 
# # # # Define the colors representing shades of green, yellow, and orange
# # # # Define the colors representing shades of green, yellow, and orange
png(fln,width=17,height=24.5,unit="cm",res=300,pointsize=7.5)
# # pdf(fln,width=10/2.54,height=6.54/2.54,useDingbats = F,pointsize=7.5)
# 
par(mfrow=c(3,3),oma=c(0,0,0,0),ps=8,cex=1)
plot(acidic,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pa,col ="red",legend=F,axes=F, add=T)

#plot(tst_321,col ="red",legend=F,axes=F, add=T)

# plot(cut_raster1, col = colors(length(breaks) - 1), axes=F,legend = F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8, add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(alkaline,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pak,col ="red",legend=F,axes=F, add=T)
#plot(cut_raster2, col = colors(length(breaks) - 1),axes=F, legend = F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8, add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(Dif_PH,col=etc,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
#plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
#plot(dif_ph,col = "red", legend=F,axes=F,add = TRUE)
# plot(cut_raster2, col = "tomato",axes=F, legend = F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
#plot(o_ph, add = TRUE, col = "green", border = "green")
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8, add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)


##Elevation
plot(m_ele,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pah,col ="red",legend=F,axes=F, add=T)
#plot(dif_e,col = colors(length(breaks) - 1),legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(l_ele,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pal,col ="red",legend=F,axes=F, add=T)
#plot(cut_raster4,col = colors(length(breaks) - 1),legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(Dif_Ele,col =etc,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
# plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
# plot(dif_e,col = "red", legend=F,axes=F, add = TRUE)
#plot(cut_raster4,col = "tomato",legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
#plot(o_e, add = TRUE, col = "green", border = "green")
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)



#humid
plot(moist,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pah,col ="red",legend=F,axes=F, add=T)
#plot(ss_pam,col ="red",legend=F,axes=F, add=T)
#plot(cut_raster5,col = colors(length(breaks) - 1), legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(dry,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pad,col ="red",legend=F,axes=F, add=T)
#plot(cut_raster6,col = colors(length(breaks) - 1),legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)


plot(Dif_Hum,col =etc,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
#plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
#plot(dif_h,col = "red", legend=F,axes=F,add = TRUE)
#plot(cut_raster6,col = "tomato", legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

dev.off()







