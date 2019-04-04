NTAs <- read_sf("/Users/kamal/Documents/GitHub/Laundro-Hydro Startup/Shapefiles/Neighborhood Tabulation Areas/geo_export_312d1a91-c0f7-4fc0-a998-626c0f4e2c69.shp")
Laundromats <- read.csv("/Users/kamal/Downloads/GeocodeResults.csv")

??SpatialPointsDataFrame
spdf <- SpatialPointsDataFrame(coords = xy, data = mydf,
 proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))


ggplot() + geom_sf(data = NTAs) +
 geom_point(data = Laundromats, aes(Longitude, Latitude))