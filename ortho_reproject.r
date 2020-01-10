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


library(sp)
library(raster)


###################################################
#######declare directories                  #######
###################################################

#########################
# data directory        #
#########################
#input directory to reproject
dataDir <- "z:\\projects\\vege_burn_siberia_2019\\ortho_stereo"
#output directory
dataOut <- "z:\\projects\\vege_burn_siberia_2019\\ortho_laea"


###################################################
#######read in data                         #######
###################################################

#########################
# rgb orthos            #
#########################
#get names for all tif files
filesIn <- list.files(dataDir)

#check files in out
filesOut <- list.files(dataOut)

#files to reproject
#returns zero if no matching output file
fileMatch <- match(filesIn, filesOut,0)

#files to run won't have a match (marked with zero above)
filesRun <- filesIn[fileMatch == 0]

#read in all orthos
rasterRGB <- list()
for(i in 1:length(filesRun)){
	rasterRGB[[i]] <- stack(paste0(dataDir, "\\",filesAll[i]))
}


laea <- "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
#reproject and save file
for(i in 1:length(filesRun)){

	reproject <- projectRaster(rasterRGB[[1]],res=res(rasterRGB[[1]])[1],crs=laea,progress='text')
	writeRaster(reproject,paste0(dataOut,"\\",filesRun[1]),format="GTiff")
}
plotRGB(reproject)
plotRGB(rasterRGB[[2]])