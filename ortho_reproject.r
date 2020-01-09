###################################################
###################################################
#######sUAS orthomosaic reprojection        #######
#######created Jan 9 2020 Heather Kropp     #######
###################################################
###################################################
#######Script for reprojecting orthomosaics #######
#######Run on Colgate server stack: Hopper  #######
###################################################
###################################################


###################################################
#######packages                             #######
###################################################
install.packages(c("rgdal"),lib ="/home/hkropp/R")

library(sp, lib ="/home/hkropp/R")
library(raster, lib ="/home/hkropp/R")


###################################################
#######declare directories                  #######
###################################################

#########################
# data directory        #
#########################
#input directory to reproject
dataDir <- "/home/hkropp/ortho/stereo"
#output directory
dataOut <- "/home/hkropp/ortho/laea"


###################################################
#######read in data                         #######
###################################################

#########################
# rgb orthos            #
#########################
#get names for all tif files
filesAll <- list.files(dataDir)



#read in all orthos
rasterRGB <- list()
for(i in 1:length(filesAll)){
	rasterRGB[[i]] <- stack(paste0(dataDir, filesAll[i]))
}


plotRGB(rasterRGB[[1]])
plotRGB(rasterRGB[[2]])
str(rasterRGB[[2]])


laea <- "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs" 
test <- projectRaster(rasterRGB[[1]],res=res(rasterRGB[[1]])[1],crs=laea,progress='text')



plotRGB(rasterRGB[[2]])