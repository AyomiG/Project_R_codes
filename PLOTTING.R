rm(list = ls(all = TRUE))
library(rgeos)
library(RColorBrewer)
library(terra)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/dry.tif" )    
H_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/hIGHE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/moist.tif")


Dif_Ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/Dif_Ele.tif")
Dif_Hum=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/Dif_Hum.tif")
Dif_PH=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/Dif_PH.tif")



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

# current pa
pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
pas=terra::project(pas,acidic)
pas=rasterize(pas,acidic)
ss_pa = crop(pas, xt)

##water
Waterbodiess=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/plots/water.tif")
Waterbodiess = crop(Waterbodiess, xt)
### =========================================================================
### Plot
### =========================================================================

# Define File name


# Define color
# cli = brewer.pal(9,"YoRRd")
cli = brewer.pal(9,"BuGn")
clsi = colorRampPalette(cli)(50)

et=brewer.pal(9,"PuOr")
etc<- colorRampPalette(et)(50)
# Generate colors from the palette
wc=c("darkblue","skyblue")


# # Define File name
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/full.png"
# Compl.png"
# 
# # Define the colors representing shades of green, yellow, and orange
# # Define the colors representing shades of green, yellow, and orange
png(fln,width=17,height=30,unit="cm",res=300,pointsize=7.5)
# pdf(fln,width=10/2.54,height=6.54/2.54,useDingbats = F,pointsize=7.5)

par(mfrow=c(3,3),oma=c(0,0,0,0),ps=8,cex=1)


plot(acidic,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(ss_pa,col = "red", legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F,add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(alkaline,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(ss_pa,col = "red",legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F,add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)


plot(Dif_PH,col=etc,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
#plot(ss_pa,col = "red", legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

##Elevation
plot(H_ele,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(ss_pa,col = "red",legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(l_ele,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(ss_pa,col = "red",legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F,add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(Dif_Ele,col =etc,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
#plot(ss_pa,col = "red", legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)


#humid
plot(moist,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(ss_pa,col = "red", legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(dry,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(ss_pa,col = "red", legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)


plot(Dif_Hum,col =etc,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
# plot(ss_pa,col = "red",legend=F,axes=F, add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F, add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)



dev.off()








