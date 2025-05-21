rm(list = ls(all = TRUE))
library(rgeos)
library(RColorBrewer)
library(terra)
# tst_121=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/scaledtst_1_2_1.tif")
# tst_321=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/scaledtst_3_2_1.tif")
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/glo_masked/acidic.tif" )

acid=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/75/scaledtst_1_2_1.tif")
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/75/scaledtst_3_2_1.tif")
# Dif_PH=tst_121-tst_321
Dif_PH=acid-alkaline


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
#Tota current pa
tot = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/finalPA.shp")
tot=terra::project(tot,acidic)
tot=rasterize(tot,acidic)

pas = vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/sm/p75/121.tif.shp")
pas=terra::project(pas,acidic)
pas=rasterize(pas,acidic)
ss_pa = crop(pas, xt)


pas2=vect("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/sm/p75/321.tif.shp")
pas2=terra::project(pas2,acidic)
pas2=rasterize(pas2,acidic)
ss_pa2 = crop(pas2, xt)

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
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/tst75.png"
# Compl.png"
# 
# # Define the colors representing shades of green, yellow, and orange
# # Define the colors representing shades of green, yellow, and orange
png(fln,width=17,height=30,unit="cm",res=300,pointsize=7.5)
# pdf(fln,width=10/2.54,height=6.54/2.54,useDingbats = F,pointsize=7.5)

par(mfrow=c(1,3),oma=c(0,0,0,0),ps=8,cex=1)


plot(acid,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pa,col = "red", legend=F,axes=F,add = TRUE)
plot(Waterbodiess,col =wc,legend=F,axes=F,add=T)
plot(hillsh,bty="n",legend=F,axes=F,col=rev(hillcol(50)),maxcell=1e8,
     add=T)
contour(crop(telev,xt),add=T,maxcells=1e8,drawlabels=F,col="grey20",lwd=0.5,
        levels=0:30*100)

plot(alkaline,col =clsi,legend=F,
     axes=F,mar=c(.1,0.1,0.1,.1))
plot(tot,col = "yellow3", legend=F,axes=F,add = TRUE)
plot(ss_pa2,col = "red",legend=F,axes=F, add = TRUE)
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

dev.off()