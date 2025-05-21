library(RColorBrewer)
library(wsl.plot)
png(file="C:/Users/ogundipe/Pictures/journal/legend.png", width=8, height=2.5, unit="cm", res=300, pointsize=7.5)
par(mar=c(0,0,0,0), cex=1)
plot(1, type="n", bty="n", xaxt="n", yaxt="n", ps=8, xlim=c(0,8), ylim=c(0,2.5), xaxs="i", yaxs="i")

# Create a color ramp using the "BuGn" color brewer
cs1 <- colorRampPalette(brewer.pal(9, "BuGn"))(141)

# Create the color scale with just "Low" and "High" labels
cscl(colors=cs1, 
     crds=c(1.5, 6.5, 1.25, 1.55),
     zrng=c(0, 1),
     at=c(0, 1),                 # Positions for "Low" and "High"
         # Labels for the ends of the scale
     title=NULL,                 # No additional title
     lablag=1,
     titlag=2.5,
     tickle=0,                   # Remove tick marks
     cx=1,
     horiz=TRUE,                 # Horizontal color scale
     tria="n")                   # No triangular end caps

dev.off()
