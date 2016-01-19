source("code/0-packages.R")
source("code/1-load-data.R")

#### Verification optimisation


### Spatial join on district 
## getting correct district and gov from coordinates


turkeygeo <- readShapePoly('data/Turkey.shp',
                           proj4string=CRS("+proj=merc +a=6378137 +b=6378137 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +k=1 +units=m +nadgrids=@null +no_defs"))
# proj4string=CRS("+proj=longlat")
#"+proj=longlat +ellps=WGS84"
#"+proj=merc +a=6378137 +b=6378137 +lat_ts=0 +lon_0=0 +x_0=0 +y_0=0 +k=1 +units=m +nadgrids=@null +no_defs"
plot(turkeygeo)
turkeygeo1 <- readOGR(dsn = "data/Turkey.shp", "Turkey")
plot(turkeygeo1)
#str(turkeygeo1)

write.csv(turkeygeo@data, "data/turkeygeo.csv")

#localities <- readShapePoly('data/Export_Output.shp', proj4string=CRS("+proj=longlat +ellps=WGS84"))
refugees <- read.csv("data/ref.csv")
names(refugees)
refugees1 <- merge(x=turkeygeo@data, y=refugees, by="province",all=TRUE)
#names(refugees)
refugees1 <- refugees1[,c("province", "RegisteredSyrians")] 
refugees1$RegisteredSyrians.class <- findCols(classIntervals(refugees1$RegisteredSyrians, n = 5, style = "jenks"))
refugees1$RegisteredSyrians.class[is.na(refugees1$RegisteredSyrians.class)] <- 0
refugees1$RegisteredSyrians.class <- as.factor(refugees1$RegisteredSyrians.class)


### Data from http://www.turkstat.gov.tr/UstMenu.do?metod=temelist
altname <- read.csv("data/altname.csv", encoding="UTF-8", sep=";")
refugees2 <- merge(x=refugees1, y=altname, by="province",all=TRUE)

refugees2$id = rownames(refugees2)
refugees2$Totalpopulation <- as.numeric(refugees2$Totalpopulation)
refugees2$RateSyrians <- refugees2$RegisteredSyrians/refugees2$Totalpopulation

refugees2$RateSyrians.class <- findCols(classIntervals(refugees2$RateSyrians, n = 5, style = "jenks"))
refugees2$RateSyrians.class[is.na(refugees2$RateSyrians.class)] <- 0
refugees2$RateSyrians.class <- as.factor(refugees2$RateSyrians.class)


# Fortifying a map makes the data frame ggplot uses to draw the map outlines.
# "region" or "id" identifies those polygons, and links them to your data. 
turkeygeo@data$id = rownames(turkeygeo@data)
turkeygeo_f <- fortify(turkeygeo, region="id")
#turkeygeo_f <- merge(turkeygeo_f, turkeygeo@data, by.x="id",by.y="row.names")
turkeygeo_f <- join(turkeygeo_f, turkeygeo@data, by="id")
#names(turkeygeo_f)
turkeygeo_f <- join(x=turkeygeo_f, y=refugees2, by="province")
#View(turkeygeo_f)
#turkeygeo_f <- merge(x=turkeygeo_f, y=refugees, by="province")


# "coordinates" extracts centroids of the polygons, in the order listed 
centroids.turkeygeo <- as.data.frame(coordinates(turkeygeo))
names(centroids.turkeygeo) <- c("Longitude", "Latitude")  #more sensible column names
centroids.turkeygeo$id = rownames(centroids.turkeygeo)
centroids.turkeygeo <- join(x=centroids.turkeygeo, y=refugees2, by="id")

turkeystamentoner <-get_stamenmap(bbox = c(left = 24, bottom = 33.505, right = 46, top = 43.882),
                                zoom = 7,
                                maptype = "toner",
                                crop = TRUE, messaging = FALSE, urlonly = FALSE,
                                filename = "out/map/iraqstamentoner.png", color =  "bw")
toner <- ggmap(turkeystamentoner)
ggsave("out/map-toner.png", toner, width=10, height=8,units="in", dpi=300)




#rm(maplevel1)
maplevel1 <-  ggplot(turkeygeo_f, aes(long, lat)) + coord_equal()+
  geom_polygon(data = turkeygeo_f, aes(x = long, y = lat, group = group), alpha = 0.5) +
  geom_path(data = turkeygeo_f, aes(x = long, y = lat, group = group), color="white")+
  ggtitle("Turkey")
maplevel1

## Applying a few classification approach

#turkeygeo_f$RegisteredSyrians.class <- findCols(classIntervals(turkeygeo_f$RegisteredSyrians, n = 5, style = "jenks"))
#turkeygeo_f$RegisteredSyrians.class[is.na(turkeygeo_f$RegisteredSyrians.class)] <- 0



## Chropleth map
rm(maplevel1_ref)
maplevel1_ref <- ggmap(turkeystamentoner)
maplevel1_ref <- maplevel1_ref + 
  geom_polygon(aes(x = long, y = lat, group = group, fill=RateSyrians.class), data = turkeygeo_f,  alpha = 0.8) +
  #ggplot(turkeygeo_f, aes(x = long, y = lat, group = group, fill=RateSyrians.class)) + 
  #geom_point(aes(size = RegisteredSyrians, x = "Longitude", y ="Latitude"),data=centroids.turkeygeo, color="orangered3")+
  coord_equal()+
  scale_fill_brewer(palette="Blues", name="") + 
  geom_path(data = turkeygeo_f, aes(x = long, y = lat, group = group), color="#2a87c8", size=0.5)+
  ggtitle("Registered Syrians in Turkey as of 23/11/15") +
  theme_tufte(base_family="Helvetica")+
  theme(plot.title=element_text(face="bold", size=14),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x = element_blank(),axis.ticks = element_blank(),
        axis.text.y = element_blank(),legend.position = "none")

ggsave("out/maplevel1_ref.png", maplevel1_ref, width=8, height=6,units="in", dpi=300)  

rm(maplevel1_ref2)
maplevel1_ref2 <- ggplot(turkeygeo_f, aes(x = long, y = lat, group = group, fill=RateSyrians.class)) +
    geom_polygon(aes(x = long, y = lat, group = group, fill=RateSyrians.class), data = turkeygeo_f,  alpha = 0.8) +
    #ggplot(turkeygeo_f, aes(x = long, y = lat, group = group, fill=RateSyrians.class)) + 
    #geom_point(aes(size = RegisteredSyrians, x = long, y = lat),data=turkeygeo_f, color="orangered3")+
    coord_equal()+
    scale_fill_brewer(palette="Blues", name="") + 
    geom_path(data = turkeygeo_f, aes(x = long, y = lat, group = group), color="#2a87c8", size=0.5)+
    ggtitle("Registered Syrians in Turkey as of 23/11/15") +
    theme_tufte(base_family="Helvetica") +
    theme(plot.title=element_text(face="bold", size=14),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(),
            axis.text.x = element_blank(),axis.ticks = element_blank(),
            axis.text.y = element_blank(),legend.position = "none")
  
  ggsave("out/maplevel1_ref2.png", maplevel1_ref2, width=12, height=8,units="in", dpi=400)  