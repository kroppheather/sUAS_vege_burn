###################################################
###################################################
#######sUAS processing & vegetation indices #######
#######created Jan 9 2020 Heather Kropp     #######
###################################################
###################################################
#######Script for extracting sample areas   #######
#######around burn perimeters for both rgb  #######
#######and multispectral orthomosaics from  #######
#######sUAS. Vegetation indices are also    #######
#######calculated for transect zones.       #######
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
library(raster)


###################################################
#######declare directories                  #######
###################################################

#########################
# user server drive     #
#########################
uDir <- "z:\\"

#########################
# data directory        #
#########################
dataDir <- paste0(uDir,"data_repo\\field_data\\siberia_uas_2019")


###################################################
#######read in data                         #######
###################################################

#########################
# rgb orthos            #
#########################
#get names for all tif files
filesAll <- list.files(paste0(dataDir,"\\orthomosaics\\ortho_exports\\reproject"))

#select tif files only
filesRGB <- filesAll[grep(".tif",filesAll)]

#read in all orthos
rasterRGB <- list()
for(i in 1:length(filesRGB)){
	rasterRGB[[i]] <- brick(paste0(dataDir,"\\orthomosaics\\ortho_exports\\reproject\\", filesAll[i]))
}
plotRGB(rasterRGB[[1]])
plotRGB(rasterRGB[[2]])
str(rasterRGB[[2]])


laea <- "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs" 
test <- projectRaster(rasterRGB[[1]],res=res(rasterRGB[[1]])[1],crs=laea,progress='text')



plotRGB(rasterRGB[[2]])