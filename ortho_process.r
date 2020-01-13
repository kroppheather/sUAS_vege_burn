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
#directory for project
dataDir <- paste0(uDir,"projects\\vege_burn_siberia_2019")
#folder for rgb images
rgbDir <- paste0(dataDir,"\\ortho_laea")
#folder with flight metadata
flightDir <- paste0(dataDir,"\\flight_info")

###################################################
#######read in data                         #######
###################################################

#########################
# rgb orthos            #
#########################
#get names for all tif files
filesAll <- list.files(paste0(dataDir,"\\ortho_laea"))

#select tif files only
#since there are many .tif.ovr ect type files need to subset so only looking at tif
#files. Remove all .tif and any periods left will be for a different extension
filesRGB <- filesAll[grepl("[:.:]",gsub(".tif","",filesAll)) == FALSE]

#read in all orthos
rasterRGB <- list()
for(i in 1:length(filesRGB)){
	rasterRGB[[i]] <- brick(paste0(rgbDir,"\\", filesRGB[i]))
}
#isolate flight number
flightN <- character(0)
for(i in 1:length(filesRGB)){
	flightN[i] <- strsplit(filesRGB[i], "_")[[1]][3]
}

flightsRGB <- data.frame(filename= filesRGB, flight = as.numeric(gsub("\\D","",flightN)))

#########################
# transect and flight   #
#########################
#ground control for transect
gcps <- read.csv(paste0(flightDir,"\\gcp_coordinates.csv"))
flights <- read.csv(paste0(flightDir,"\\flight_meta.csv"))


###################################################
#######set up transects to match flights    #######
###################################################

laea <- "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

fl3 <- SpatialPoints(data.frame(x=gcps$lon[gcps$flight == 3],y=gcps$lat[gcps$flight == 3]),
		crs("+init=epsg:4326"))

fl3r <- spTransform(fl3, laea)


plotRGB(rasterRGB[[1]])