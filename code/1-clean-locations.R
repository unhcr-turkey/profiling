### Locations to admin 2
# Create spatial polygons
# To set the PROJ4 string, enter the EPSG SRID and uncomment the 
# following two lines:
# EPSG = make_EPSG()
# p4s = EPSG[which(EPSG$code == SRID), "prj4"]
for (i in seq(nrow(dfTemp))) {
  if (i == 1) {
    spTemp = readWKT(dfTemp$wkt_geometry[i], dfTemp$gid[i])
    # If the PROJ4 string has been set, use the following instead
    # spTemp = readWKT(dfTemp$wkt_geometry[i], dfTemp$gid[i], p4s)
  }
  else {
    spTemp = rbind(
      spTemp, readWKT(dfTemp$wkt_geometry[i], dfTemp$gid[i])
      # If the PROJ4 string has been set, use the following instead
      # spTemp, readWKT(dfTemp$wkt_geometry[i], dfTemp$gid[i], p4s)
    )
  }
}

# Create SpatialPolygonsDataFrame, drop WKT field from attributes
spdfFinal = SpatialPolygonsDataFrame(spTemp, dfTemp[-2])



require(maptools) ## Create maps
require(rgdal) ## Open geographic files
require(rgeos)

library(rgeos)
library(sp) 
library(maptools)
library(rgdal)
library(sp)

IntersectPtWithPoly <- function(x, y) {
  # Extracts values from a SpatialPolygonDataFrame with
  # SpatialPointsDataFrame, and appends table (similar to
  # ArcGIS intersect)
  # Args:
  #   x: SpatialPoints*Frame
  #   y: SpatialPolygonsDataFrame
  # Returns:
  # SpatialPointsDataFrame with appended table of polygon attributes
  
  # Set up overlay with new column of join IDs in x
  z <- over(y, x)
  
  # Bind captured data to points dataframe
  x2 <- cbind(x, z)
  
  # Make it back into a SpatialPointsDataFrame
  # Account for different coordinate variable names
  if(("coords.x1" %in% colnames(x2)) & ("coords.x2" %in% colnames(x2))) {
    coordinates(x2) <- ~coords.x1 + coords.x2
  } else if(("x" %in% colnames(x2)) & ("x" %in% colnames(x2))) {
    coordinates(x2) <- ~x + y
  }
  
  # Reassign its projection if it has one
  if(is.na(CRSargs(x@proj4string)) == "FALSE") {
    x2@proj4string <- x@proj4string
  }
  return(x2)
}



locations <- read.csv("data/locations.csv")
names(locations)


#####

EPSG = make_EPSG()
p4s = EPSG[which(EPSG$code == 4326), "prj4"]
for (i in seq(nrow(locations))) {
  if (i == 1) {
    #spTemp = readWKT(locations$Geographic.coordinates[i], locations$row.names[i])
    # If the PROJ4 string has been set, use the following instead
    spTemp = readWKT(locations$Geographic.coordinates[i], locations$row.names[i], p4s)
  }
  else {
    spTemp = rbind(
      #spTemp, readWKT(dfTemp$wkt_geometry[i], dfTemp$gid[i])
      # If the PROJ4 string has been set, use the following instead
       spTemp, readWKT(locations$Geographic.coordinates[i], locations$row.names[i], p4s)
    )
  }
}

# Create SpatialPolygonsDataFrame, drop WKT field from attributes
locations.sp = SpatialPolygonsDataFrame(spTemp, locations[-2])


#### Now for Admin 2
turkeylevel2 <- read.csv("data/turkeylevel2.csv", stringsAsFactors=FALSE)
names(turkeylevel2)
str(turkeylevel2)
EPSG = make_EPSG()
p4s = EPSG[which(EPSG$code == 4326), "prj4"]
for (i in seq(nrow(locations))) {
  if (i == 1) {
    spTemp = readWKT( turkeylevel2$wkt_geom[i],turkeylevel2$row.names[i], p4s)
    # 
  }
  else {
    spTemp = rbind(
      spTemp, readWKT(turkeylevel2$wkt_geom[i], turkeylevel2$row.names[i], p4s), makeUniqueIDs = TRUE
    )
  }
}

# Create SpatialPolygonsDataFrame, drop WKT field from attributes
level2.sp = SpatialPolygonsDataFrame(spTemp, turkeylevel2[-2])


localities0 <- SpatialPointsDataFrame(localitiesp, data= localities, proj4string=CRS("+proj=longlat +ellps=WGS84"))
plot(localities0)

datasp1  <- over(localities0, egyptdistrict)
datasp2  <- over(egyptdistrict, localities0)

localities1 <- cbind(localities0, datasp1)

write.csv(localities1,"localities1.csv")