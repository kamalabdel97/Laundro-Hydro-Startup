library(sp)
library(ggplot2)
library(sf)

NYCCensus <- read_sf("/Users/kamal/Documents/GitHub/Laundro-Hydro Startup/Shapefiles/2010 Census Tracts/geo_export_430aa5ff-9cc1-4b07-b3a2-f0ad4cbbda6e.shp")
NTAs <- read_sf("/Users/kamal/Documents/GitHub/Laundro-Hydro Startup/Shapefiles/Neighborhood Tabulation Areas/geo_export_312d1a91-c0f7-4fc0-a998-626c0f4e2c69.shp")
Laundromats <- read.csv("/Users/kamal/Documents/GitHub/Laundro-Hydro Startup/GeocodeResults.csv")
USCensus <- read.csv("/Users/kamal/Documents/GitHub/Laundro-Hydro Startup/ACS_17_5YR_S0101/ACS_17_5YR_S0101_with_ann.csv")

USCensus <- USCensus[-1,]
USCensus$CensusID <- substring(as.charachter(USCensus$GEO.id2),5)
newdata <- View(USCensus[order(-USCensus$GEO.id2),])
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


ggplot() + 
 geom_sf(data = NTAs) +
 geom_point(data = Laundromats, aes(Longitude, Latitude))