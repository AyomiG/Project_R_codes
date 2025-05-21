
library(terra)
acidic=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/acidic.tif")
alkaline=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/alkaline.tif")
HighE=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/HighElevation.tif")
lowE=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/lowElevation.tif")
Moist=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/moist_mask.tif")
dry=rast("C:/Users/ogundipe/Documents/OneDrive - Eidg. Forschungsanstalt WSL/visua/new_data/masked_areas/dry_mask.tif")

# rescaled_acidic <- acidic*(acidic - minmax(acidic)[1])/(minmax(acidic)[2] - minmax(acidic)[1])*100
# rescaled_alk <-alkaline* (alkaline - minmax(alkaline)[1])/(minmax(alkaline)[2] - minmax(alkaline)[1])*100
# resacaled_HighE=HighE*(HighE - minmax(HighE)[1])/(minmax(HighE)[2] - minmax(HighE)[1])*100
# resacaled_lowE=lowE*(lowE - minmax(lowE)[1])/(minmax(lowE)[2] - minmax(lowE)[1])*100
# resacaled_Moist=Moist*(Moist - minmax(Moist)[1])/(minmax(Moist)[2] - minmax(lowE)[1])*100
# resacaled_dry=dry*(dry - minmax(dry)[1])/(minmax(dry)[2] - minmax(dry)[1])*100

ac_q=quantile(values(acidic), probs = seq(0, 1, 0.01),na.rm=T)
acal_q=quantile(values(alkaline), probs = seq(0, 1, 0.01),na.rm=T)
hq=quantile(values(HighE), probs = seq(0, 1, 0.25),na.rm=T)
lq=quantile(values(lowE), probs = seq(0, 1, 0.25),na.rm=T)
mq=quantile(values(Moist), probs = seq(0, 1, 0.25),na.rm=T)
dq=quantile(values(dry), probs = seq(0, 1, 0.25),na.rm=T)
d=rescaled_acidic-rescaled_alk
ac_q=quantile(values(acidic), probs = seq(0, 1, 0.01),na.rm=T)
vls_sc = cut(values(acidic), breaks = ac_q)
vls_sc = as.numeric(vls_sc)

resc_acidic = acidic
values(resc_acidic) = vls_sc


# Check if both rasters have the same dimensions
if (nrow(acidic) == nrow(alkaline) && ncol(acidic) == ncol(alkaline)) {
               # Calculate the difference between corresponding values in acidic and alkaline rasters
               d <- acidic - alkaline
               
               # Now 'd' contains the differences between corresponding values in acidic and alkaline
} else {
               print("Rasters have different dimensions.")
}

