rm(list = ls(all = TRUE))
library(geos)
library(RColorBrewer)
library(terra)

##Differences
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/acidic.tif" ) 
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/alkaline.tif")
dry= rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/dry.tif" )    
m_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/modE.tif" )  
l_ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/lowE.tif"  )  
moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/moist.tif")





Dif_Ele=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/Dif_Ele.tif")
Dif_Hum=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/Dif_Hum.tif")
Dif_PH=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/con_files/rescaled/grp/Dif_PH.tif")


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
fln = "C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/t_plot/75_Con.png"
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

