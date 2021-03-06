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
#runs on R3.6.1 on Hopper

###################################################
#######packages                             #######
###################################################
#install.packages(c("sp"), lib="/home/hkropp/R3.6.2")
#install.packages(c("raster"), lib="/home/hkropp/R3.6.2")
#install.packages(c("rgdal"), lib="/home/hkropp/R3.6.2")

#library(sp, lib="/home/hkropp/R3.6.1")
#library(raster, lib="/home/hkropp/R3.6.1")
library(sp)
library(raster)
library(rgdal)

###################################################
#######declare directories                  #######
###################################################

#########################
# data directory        #
#########################
#input directory to reproject
#dataDir <- "/home/hkropp/ortho/stereo"
#output directory
#dataOut <- "/home/hkropp/ortho/laea"
dataDir <- "z:\\projects\\vege_burn_siberia_2019\\ortho_stereo"
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


laea <- "+proj=aea +lat_1=50 +lat_2=70 +lat_0=56 +lon_0=100 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs "
#test first 1
i <- 1 
rasterRGB <- brick(paste0(dataDir, "\\",filesRun[i]))
	print(paste("read",filesRun[i]))
	reproject <- projectRaster(rasterRGB,res=res(rasterRGB)[1],crs=laea,progress='text')
	print(paste("finish",filesRun[i]))
	writeRaster(reproject,paste0(dataOut,"\\",filesRun[i]),format="GTiff")
	print(paste("write",filesRun[i]))
	plotRGB(reproject)
	
testRGB <- brick(paste0(dataOut,"\\",filesRun[i]))	
	plotRGB(testRGB)
gc()	
#reproject and save file
for(i in 2:length(filesRun)){
	rasterRGB <- brick(paste0(dataDir, "\\",filesRun[i]))
	print(paste("read",filesRun[i]))
	reproject <- projectRaster(rasterRGB,res=res(rasterRGB[[i]])[1],crs=laea,progress='text')
	print(paste("finish",filesRun[i]))
	writeRaster(reproject,paste0(dataOut,"\\",filesRun[i]),format="GTiff")
	print(paste("write",filesRun[i]))
	gc()
}


