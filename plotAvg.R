rm(list = ls(all = TRUE))
library(rgeos)
library(RColorBrewer)
library(terra)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/dry.tif" )    
H_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/HighE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/moist.tif")


Dif_Ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/Dif_Ele.tif")
Dif_Hum=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/Dif_Hum.tif")
Dif_PH=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/avg_masked/Dif_PH.tif")



xt=ext(acidic)
# Load elevation
elev=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/Elevation_25.tif")
elev=project(elev,acidic)
elev<- resample(elev, acidic, method = "bilinear")
# Crop elelvation
telev=crop(elev,xt)
# telev = disagg(telev,fact=6,method="bilinear")
# telev=telev/10
telev <- mask(telev, acidic)


## Prepare hillshade
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
# # current pa
# pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/grpd_ac_avg.shp")
# pas=terra::project(pas,acidic)
# pas=rasterize(pas,acidic,field = "count")
# ss_pa = crop(pas, xt)
# 
# # current pa
# pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/grpd_alk_avg.shp")
# pas=terra::project(pas,acidic)
# pas=rasterize(pas,acidic,field = "count")
# ss_pa_alk = crop(pas, xt)
# 
# # current pa
# pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/grpd_d_avg.shp")
# pas=terra::project(pas,acidic)
# pas=rasterize(pas,acidic,field = "count")
# ss_pa_d= crop(pas, xt)
# 
# # current pa
# pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/grpd_M_avg.shp")
# pas=terra::project(pas,acidic)
# pas=rasterize(pas,acidic,field = "count")
# ss_pa_m = crop(pas, xt)
# 
# 
# # current pa
# pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/grpd_HighE_avg.shp")
# pas=terra::project(pas,acidic)
# pas=rasterize(pas,acidic,field = "count")
# ss_pa_h = crop(pas, xt)
# 
# # current pa
# pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/grpd_lowE_avg.shp")
# pas=terra::project(pas,acidic)
# pas=rasterize(pas,acidic,field = "count")
# ss_pa_l = crop(pas, xt)




# 
ss_pa=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG/acidic.tif")
ss_pa=terra::project(ss_pa,acidic)
ss_pa = crop(ss_pa, xt)

ss_pak=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG/alkaline.tif")
ss_pak=terra::project(ss_pak,acidic)
ss_pak= crop(ss_pak,xt)

ss_pad=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG/dry.tif")
# ss_pad==terra::project(ss_pad,acidic)
ss_pad<- project(ss_pad, "epsg:21781")
ss_pad = crop(ss_pad,xt)

ss_pah=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG/high.tif")
ss_pah=terra::project(ss_pah,acidic)
ss_pah = crop(ss_pah, xt)

ss_pal=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG/low.tif")
ss_pal=terra::project(ss_pal,acidic)
ss_pal = crop(ss_pal, xt)

ss_pam=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/AI_avg/PAG/moist.tif")
ss_pam=terra::project(ss_pam,acidic)
ss_pam = crop(ss_pam, xt)


#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)
# # Identify overlapping cells 
# overlaps <-rast("C:/Users/ogundipe/Documents/count.tif")

### =========================================================================
### Plot
### =========================================================================


# # Identify overlapping cells 
# overlaps <-rast("C:/Users/ogundipe/Documents/count.tif")

### =========================================================================
### Plot
### =========================================================================
# Define color
# cli = brewer.pal(9,"YlOrRd")
cli = brewer.pal(9,"BuGn")
clsi = colorRampPalette(cli)(50)

et=brewer.pal(9,"PuOr")
etc<- colorRampPalette(et)(50)
# Generate colors from the palette
wc=c("darkblue","skyblue")

# # Define breaks for the raster values
# # Define breaks for the raster values
# # Define breaks for the raster values
# # Convert the matrix ss_pa to a vector
# # Define breaks and labels for grouping
# #breaks <- c(0, 0.5, 2.5, 4.5, 6.5, 8.5, 10.5, 11)
# breaks <- c(0, 1, 3, 5, 7, 9, 11, 12)
# 
# legend_labels <- c("0", "1-2", "3-4", "5-6", "7-8", "9-10", "11")  # Labels for legend
# 
# # Define your custom color palette
# colors <- c('#fee5d9','#fcbba1','#fc9272','#fb6a4a','#ef3b2c','#cb181d','#99000d')
# 
# # Use cut() on the vector
# group <- cut(floor(values(ss_pa)), breaks = breaks)
# 
# # Create a new raster layer with the group values
# ss_pa_raster <- setValues(ss_pa, as.numeric(group))
# 
# # Plot the raster with the specified breaks, colors, and legend
# plot(ss_pa_raster, col = colors, breaks = breaks, legend=T)
# 
# 
# # alkaline
# # Cut the raster values into groups, rounding down to the nearest integer
# group <- cut(floor(values(ss_pa_alk)), breaks = breaks)
# 
# # Create a new raster layer with the group values
# ss_pa_alkk <- setValues(ss_pa_alk,as.numeric(group))
# 
# # alkaline
# # Cut the raster values into groups, rounding down to the nearest integer
# 
# group <- cut(floor(values(ss_pa_d)), breaks = breaks)
# 
# # Create a new raster layer with the group values
# ss_pa_dd <- setValues(ss_pa_d, as.numeric(group))
# 
# # Cut the raster values into groups, rounding down to the nearest integer
# 
# group <- cut(floor(values(ss_pa_h)), breaks = breaks)
# 
# # Create a new raster layer with the group values
# ss_pa_hh <- setValues(ss_pa_h, as.numeric(group))
# 
# # Cut the raster values into groups, rounding down to the nearest integer
# 
# group <- cut(floor(values(ss_pa_l)), breaks = breaks)
# 
# # Create a new raster layer with the group values
# ss_pa_ll <- setValues(ss_pa_l,as.numeric(group))
# 
# # Cut the raster values into groups, rounding down to the nearest integer
# 
# group <- cut(floor(values(ss_pa_m)), breaks = breaks)
# 
# # Create a new raster layer with the group values
# ss_pa_mm <- setValues(ss_pa_m, as.numeric(group))
# 


# # Define File name
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/mod_avg.png"
# 
# # Define the colors representing shades of green, yellow, and orange
# # Define the colors representing shades of green, yellow, and orange
png(fln,width=17,height=30,unit="cm",res=300,pointsize=7.5)
# pdf(fln,width=10/2.54,height=6.54/2.54,useDingbats = F,pointsize=7.5)

par(mfrow=c(3,3),oma=c(0,0,0,0),ps=8,cex=1)

plot(acidic,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pa,col ="red",legend=F,axes=F, add=T)
#plot(ss_pa_raster, col = colors, axes=F,breaks = breaks, legend = F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8, add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(alkaline,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pak,col ="red",legend=F,axes=F, add=T)
#plot(ss_pa_alkk, col = colors,axes=F, breaks = breaks, legend = F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8, add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(Dif_PH,col=etc,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
# plot(ss_pa,col = "red", legend=F,axes=F,add = TRUE)
# plot(ss_pa_alk, col = "brown",axes=F, legend = F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
#plot(o_ph, add = TRUE, col = "green", border = "green")
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8, add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)


##Elevation
plot(H_ele,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pah,col ="red",legend=F,axes=F, add=T)
#plot(ss_pa_hh,col = colors,breaks = breaks, legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(l_ele,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pal,col ="red",legend=F,axes=F, add=T)
#plot(ss_pa_ll,col =colors,legend=F,breaks = breaks,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(Dif_Ele,col =etc,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
# plot(ss_pa_h,col = "red", legend=F,axes=F, add = TRUE)
# plot(ss_pa_l,col = "brown",legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
#plot(o_e, add = TRUE, col = "green", border = "green")
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)



#humid
plot(moist,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pam,col ="red",legend=F,axes=F, add=T)
#plot(ss_pa_mm,col = colors, legend=F,axes=F,breaks = breaks, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(dry,col =clsi,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pad,col ="red",legend=F,axes=F, add=T)
#plot(ss_pa_dd,col =colors, legend=F,axes=F,breaks = breaks, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)


plot(Dif_Hum,col =etc,legend=F,axes=F,mar=c(.1,0.1,0.1,.1))
# plot(ss_pa_m,col = "red", legend=F,axes=F,add = TRUE)
# plot(ss_pa_d,col = "brown", legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)



dev.off()