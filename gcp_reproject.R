##########################
#
####################################################
###################################################
#######GCP reprojection for Pix4D           #######
#######created Jan 9 2020 Heather Kropp     #######
###################################################
###################################################
#######Script for reprojecting Ground       #######
#######Countrol Points to match Projection  #######
#######used as default in Pix4D             #######
###################################################
###################################################
#######Inputs:
###################################################
###################################################
#######Outputs:
###################################################
###################################################



###################################################
#######packages                             #######
###################################################
library(spatial)
library(raster)
###################################################
#######declare directories                  #######
###################################################
setwd('/Volumes/data/projects/vege_burn_siberia_2019/flight_info/')

###################################################
#######read data, without na values         #######
###################################################
gcp <- na.omit(read.csv("gcp_coordinates.csv"))


#create spatial points, WGS 84
gcp.wgs <- SpatialPoints(data.frame(x=gcp$lon,y=gcp$lat),
                     crs("+init=epsg:4326"))


#transform to UTM Zone 57N coordinates (https://epsg.io/32657)
gcp.utm <- spTransform(gcp.wgs, crs("+init=epsg:32657"))

#add UTM coordinates to GCP data frame
gcp$x <- gcp.utm@coords[,1]
gcp$y <- gcp.utm@coords[,2]

#write updated file to project folder on server
write.csv(gcp, file = "gcp_coordinates_utm.csv",
          row.names = F)
