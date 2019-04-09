library(sp)
library(ggplot2)
library(sf)

NTAs <- read_sf("/Users/kamal/Documents/GitHub/Laundro-Hydro Startup/Shapefiles/Neighborhood Tabulation Areas/geo_export_312d1a91-c0f7-4fc0-a998-626c0f4e2c69.shp")
Laundromats <- read.csv("/Users/kamal/Documents/GitHub/Laundro-Hydro Startup/GeocodeResults.csv")

#Get rid of NAs for now
Laundromats <- na.omit(Laundromats)

#Get rid of scientific notations
options("scipen"=100, "digits"=4)


#Converts coordinates of Laundromats to spatial coordinates
Laundromats <- SpatialPointsDataFrame(coords = Laundromats[,c(6,7)], data = Laundromats,
 proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))
options(digits = 5)

#Converts it to sf
Laundromats <- sf::st_as_sf(Laundromats, coords = c("Longitude","Latitude"))

NTAs
format(round(Laundromats$Latitude, 2), nsmall = 2)

ggplot() + 
 geom_sf(data = NTAs) +
 geom_point(data = Laundromats, aes(Longitude, Latitude))